import datetime
import os
import unittest
import transaction
import sys

from collections import namedtuple
from geoalchemy2.shape import to_shape
from pyramid import testing
from pyramid.paster import get_appsettings, setup_logging
from pyvirtualdisplay import Display
from selenium import webdriver
from sqlalchemy import engine_from_config
from webtest import http

from .pages.pages import Page, LogoutPage
from .pages.api import LoginEndpoint, CreateActivityEndpoint, Endpoint, \
    CreateStakeholderEndpoint
from lokp import main
from lokp.models import Base, DBSession, User, Group, Profile, Activity, \
    Stakeholder, A_Tag_Group, A_Tag, A_Key
from lokp.scripts.initialize_db import add_sql_triggers, add_initial_values


# Helper object to store user credentials to login during tests
UserTuple = namedtuple('UserTuple', ['username', 'password'])

# Basically a duplication of the Status table with {'name': id} of each status.
# These are practically static and that way, no DB calls are necessary.
STATUS_MAP = {
    'pending': 1,
    'active': 2,
    'inactive': 3,
    'deleted': 4,
    'rejected': 5,
    'edited': 6,
}


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


class BaseTestCase(unittest.TestCase):
    """
    Base functionality (setup, teardown and some helper methods) for every test.
    """
    base_url = 'http://localhost:6544'
    profiles = ['myanmar']

    def setUp(self):
        self.config = testing.setUp()

        # Prevent logging of all debug information
        setup_logging('testing.ini')

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

    def tearDown(self):
        self.server.shutdown()
        Base.metadata.drop_all(self.engine)
        DBSession.remove()
        testing.tearDown()

    @staticmethod
    def validate_item_type(item_type: str) -> str:
        if item_type not in ['activity', 'stakeholder']:
            raise BaseException(f'Invalid item_type {item_type}')
        return item_type

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

    def create_item(
            self, item_type: str, user: UserTuple, changeset: dict,
            status: str=None) -> str:

        # Login to get a valid cookie
        login_endpoint = LoginEndpoint()
        login_url = self.get_url_from_page(login_endpoint, absolute=True)
        cookies = login_endpoint.login(login_url, user.username, user.password)

        # Create a new item (Activity or Stakeholder)
        if self.validate_item_type(item_type) == 'activity':
            create_endpoint = CreateActivityEndpoint()
        else:
            create_endpoint = CreateStakeholderEndpoint()

        create_url = self.get_url_from_page(create_endpoint, absolute=True)
        identifier = create_endpoint.create(create_url, cookies, changeset)

        if status and status != 'pending':
            self.set_item_status(item_type, identifier, status, version=None)

        return identifier

    def set_item_status(
            self, item_type: str, identifier: str, status: str,
            version: int=None):
        if status not in STATUS_MAP.keys():
            raise BaseException(f'Status {status} is not valid.')
        if self.validate_item_type(item_type) == 'activity':
            Model = Activity
        else:
            Model = Stakeholder
        with transaction.manager:
            items = DBSession.query(Model).filter(
                Model.identifier == identifier)
            if version is not None:
                items = items.filter(Model.version == version)
            item = items.one()
            item.fk_status = STATUS_MAP[status]

    def create_test_users(self):
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

    def get_taggroup_geometry(
            self, key: str, identifier: str=None, version: int=None) -> dict:
        with transaction.manager:
            # If identifier and version are not provided, it is assumed that
            # there is only one Activity in the DB. Use this.
            if identifier is None and version is None:
                activity = DBSession.query(Activity).one()
                identifier = activity.activity_identifier
                version = activity.version
            taggroup = DBSession.query(A_Tag_Group)\
                .join(Activity)\
                .join(A_Tag, A_Tag_Group.fk_a_tag==A_Tag.id)\
                .join(A_Key)\
                .filter(
                    Activity.identifier == identifier,
                    Activity.version == version,
                    A_Key.key == key
                )\
                .one()
            if taggroup.geometry is None:
                return {}
            return to_shape(taggroup.geometry).__geo_interface__

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


class FunctionalTestCase(BaseTestCase):
    """
    Additional methods for functional testing (setup browser).
    """

    def setUp(self):
        super().setUp()

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

        # Make sure user is not logged in
        logout_page = LogoutPage(self.driver)
        self.get_page(logout_page)

        # Create some users
        self.create_test_users()

    def tearDown(self):
        # self.save_failed_screenshots()
        self.driver.quit()
        if '-pop' not in sys.argv[1:]:
            self.display.stop()
        super().tearDown()

    def save_failed_screenshots(self):
        if self._outcome.errors:
            path = os.path.join(
                os.path.dirname(os.path.realpath(__file__)),
                'failed_screenshots')
            if not os.path.exists(path):
                os.makedirs(path)
            file = os.path.join(path, f'failed_{self.id()}.png')
            self.driver.save_screenshot(file)

    def get_page(self, page: Page):
        """
        Open a page in the driver.
        """
        self.driver.get(self.get_url_from_page(page, absolute=True))


class ApiTestCase(BaseTestCase):
    """
    Additional methods for API tests (no browser required).
    """

    @staticmethod
    def get_identifiers(json_response: dict) -> list:
        """
        Get a list of identifiers based on a list response of the API.
        """
        return [entry.get('id') for entry in json_response['data']]
