import datetime
import os
import unittest
import transaction
import sys

from collections import namedtuple
from pyramid import testing
from pyramid.paster import get_appsettings
from pyvirtualdisplay import Display
from selenium import webdriver
from sqlalchemy import engine_from_config
from webtest import http

from .pages import Page, LogoutPage, LoginEndpoint, CreateActivityEndpoint, \
    Endpoint
from lokp import main
from lokp.models import Base, DBSession, User, Group, Profile
from lokp.scripts.initialize_db import add_sql_triggers, add_initial_values


# Helper object to store user credentials to login during tests
UserTuple = namedtuple('UserTuple', ['username', 'password'])


def initialize_db(engine, settings):
    """
    Initialize the database structure (create triggers and tables)
    """
    add_sql_triggers(engine)
    add_initial_values(engine, settings)


def load_initial_data(engine):
    """
    Load the initial data (read and execute SQL script)
    """
    file_path = os.path.join(os.path.dirname(os.path.dirname(__file__)),
                             'scripts', 'populate_keyvalues.sql')
    fd = open(file_path, 'r')
    sql_file = fd.read()
    fd.close()

    for command in sorted(sql_file.split(';')):
        # Do not execute empty commands (newlines), this results in an error
        if command == '\n':
            continue
        engine.execute(command)


class FunctionalTestCase(unittest.TestCase):
    base_url = 'http://localhost:6544'
    profiles = ['myanmar']

    def setUp(self):
        self.config = testing.setUp()

        # Prepare application
        self.settings = get_appsettings('testing.ini')
        self.testapp = main({}, **self.settings)

        # Create tables and load initial data
        self.engine = engine_from_config(self.settings, 'sqlalchemy.')
        Base.metadata.drop_all(self.engine)
        Base.metadata.create_all(self.engine)
        initialize_db(self.engine, self.settings)
        load_initial_data(self.engine)

        # Create a wsgi server
        self.server = http.StopableWSGIServer.create(self.testapp, port=6544)
        self.server.wait()

        # Only show browser if test command is run with "-pop"
        if '-pop' not in sys.argv[1:]:
            self.display = Display(visible=0, size=(1600, 900))
            self.display.start()

        # Create a webdriver (based on chrome)
        chromedriver_path = self.settings.get(
            'lokp.testing_chromedriver_path', 'chromedriver')
        chrome_options = webdriver.ChromeOptions()
        chrome_options.add_argument('--no-sandbox')
        self.driver = webdriver.Chrome(
            executable_path=chromedriver_path, chrome_options=chrome_options)
        self.driver.set_window_size(1920, 1080)
        self.driver.implicitly_wait(3)

        # Create some users
        self.user_admin = UserTuple(
            'admin', self.settings['lokp.admin_password'])
        self.create_user(
            'editor1', 'editor_password', ['editors'])
        self.user_editor1 = UserTuple('editor1', 'editor_password')
        self.create_user(
            'editor2', 'editor_password', ['editors'])
        self.user_editor2 = UserTuple('editor2', 'editor_password')
        self.create_user(
            'moderator', 'moderator_password', ['editors', 'moderators'])
        self.user_moderator = UserTuple('moderator', 'moderator_password')

        # Make sure user is not logged in
        logout_page = LogoutPage(self.driver)
        self.get_page(logout_page)

    def tearDown(self):
        self.driver.quit()
        if '-pop' not in sys.argv[1:]:
            self.display.stop()
        self.server.shutdown()
        Base.metadata.drop_all(self.engine)
        DBSession.remove()
        testing.tearDown()

    def get_url_from_route(
            self, route_name: str, kwargs_dict: bool=None, absolute: bool=True
            ) -> str:
        """
        Return the URL based on a route name.
        """
        if kwargs_dict is None:
            kwargs_dict = {}
        url = self.testapp.routes_mapper.get_route(route_name).generate(
            kwargs_dict)
        return self.base_url + url if absolute is True else url

    def get_url_from_page(self, page: Page or Endpoint, absolute=True) -> str:
        """
        Return the URL of a page.
        """
        return self.get_url_from_route(
            page.route_name, kwargs_dict=page.route_kwargs, absolute=absolute)

    def get_page(self, page: Page):
        """
        Open a page in the driver.
        """
        self.driver.get(self.get_url_from_page(page, absolute=True))

    def create_activity(
            self, user: UserTuple, changeset: dict) -> str:
        """
        Create a new activity using the API endpoints.
        """

        # Login to get a valid cookie
        login_endpoint = LoginEndpoint()
        login_url = self.get_url_from_page(login_endpoint, absolute=True)
        cookies = login_endpoint.login(login_url, user.username, user.password)

        # Create a new activity
        create_endpoint = CreateActivityEndpoint()
        create_url = self.get_url_from_page(create_endpoint, absolute=True)
        return create_endpoint.create(create_url, cookies, changeset)

    def create_user(self, username: str, password: str, groups: list):
        with transaction.manager:
            user = User(
                username=username, password=password, email='foo@bar.com',
                is_active=True, is_approved=True,
                registration_timestamp=datetime.datetime.now())
            user.groups = DBSession.query(Group).filter(
                Group.name.in_(groups)).all()
            if 'moderators' in groups:
                # Link moderators with profiles
                user.profiles = DBSession.query(Profile).filter(
                    Profile.code.in_(self.profiles)).all()
            DBSession.add(user)
