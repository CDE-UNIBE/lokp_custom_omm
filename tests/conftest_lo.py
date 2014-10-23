import pytest
import os
from pyramid.paster import get_app
from pyramid.paster import get_appsettings
from sqlalchemy import engine_from_config
from webtest import TestApp

from lmkp.scripts.populate import _populate
from lmkp.models import meta

# Specify the INI configuration files for the tests to run.
# The INI file must specifically point to an empty database!
LO_CUSTOMIZATION_TESTS_INI = 'lo_testing.ini'
USERNAME = 'admin'
PASSWORD = 'asdfasdf'


def lo_ini_is_not_set():
    """
    Check if the INI file is present. Return True if it is not.
    """
    try:
        open(LO_CUSTOMIZATION_TESTS_INI)
        return False
    except:
        return True

lo_skip_if_no_ini = pytest.mark.skipif(
    lo_ini_is_not_set(),
    reason="INI (%s) for testing customization not found" %
    LO_CUSTOMIZATION_TESTS_INI)


@pytest.fixture(scope='session')
def connection(request):
    """
    Fixture to set up a database connection and create the tables.
    """
    settings = get_appsettings(LO_CUSTOMIZATION_TESTS_INI)
    engine = engine_from_config(settings, 'sqlalchemy.')

    meta.Base.metadata.create_all(engine)
    connection = engine.connect()
    meta.DBSession.registry.clear()
    meta.DBSession.configure(bind=connection)
    meta.Base.metadata.bind = engine

    _populate(engine, settings)

    request.addfinalizer(meta.Base.metadata.drop_all)
    return connection


@pytest.fixture
def db_session(request, connection):
    """
    Fixture to roll back the database after tests. Also populates database with
    initial keys, values and other data.
    """
    from transaction import abort
    trans = connection.begin()

    here = os.path.dirname(__file__)
    location = os.path.join(here, '..', 'scripts', 'populate_keyvalues.sql')

    sql_file = open(location, 'r')
    sql_query = sql_file.read()
    sql_file.close()
    connection.execute(sql_query)

    request.addfinalizer(trans.rollback)
    request.addfinalizer(abort)

    from lmkp.models.meta import DBSession
    return DBSession


@pytest.fixture(scope='function')
def customization_app(request, db_session):
    """
    Use this fixture to retreive a TestApp object which can be used as self.app
    in the test functions.
    """
    request.cls.app = TestApp(get_app(LO_CUSTOMIZATION_TESTS_INI))
    request.cls.db_session = db_session
    return request
