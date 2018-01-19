import os
import unittest

import sys
from pyramid import testing
from pyramid.paster import get_appsettings
from pyvirtualdisplay import Display
from selenium import webdriver
from sqlalchemy import engine_from_config
from webtest import http

from lokp import main
from lokp.models import DBSession, Base
from lokp.scripts.initialize_db import add_sql_triggers, add_initial_values


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


class FunctionalTests(unittest.TestCase):

    def setUp(self):
        self.config = testing.setUp()

        # Prepare application
        settings = get_appsettings('testing.ini')
        app = main({}, **settings)

        # Create tables and load initial data
        self.engine = engine_from_config(settings, 'sqlalchemy.')
        Base.metadata.create_all(self.engine)
        initialize_db(self.engine, settings)
        load_initial_data(self.engine)

        # Create a wsgi server
        self.server = http.StopableWSGIServer.create(app, port=6544)
        self.server.wait()

        # Only show browser if test command is run with "-pop"
        if '-pop' not in sys.argv[1:]:
            self.display = Display(visible=0, size=(1600, 900))
            self.display.start()

        # Create a webdriver (based on chrome)
        chromedriver_path = settings.get(
            'lokp.testing_chromedriver_path', 'chromedriver')
        chrome_options = webdriver.ChromeOptions()
        chrome_options.add_argument('--no-sandbox')
        self.driver = webdriver.Chrome(
            executable_path=chromedriver_path, chrome_options=chrome_options)
        self.driver.implicitly_wait(3)

    def tearDown(self):
        self.driver.quit()
        if '-pop' not in sys.argv[1:]:
            self.display.stop()
        self.server.shutdown()
        Base.metadata.drop_all(self.engine)
        testing.tearDown()

    def test_view(self):
        self.driver.get('localhost:6544')
        assert 'Myanmar land reporting' in self.driver.page_source
