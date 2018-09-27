from contextlib import contextmanager

from fabric.api import cd, env, run
from fabric.context_managers import prefix
from fabric.decorators import task


"""
Usage:
(env) fab -f lokp/customization/omm/fabfile -H <user>@<host> deploy:<environ>
"""


ENVIRONMENTS = {
    'dev': {
        'source_path': '/srv/webapps/mmlokp-dev/lokp',
        'customization_path': '/srv/webapps/mmlokp-dev/lokp/lokp/customization'
                              '/omm',
        'virtualenv_path': '/srv/webapps/mmlokp-dev/virtualenv/bin/activate',
        'touch_file': '/etc/uwsgi-emperor/vassals/mmlokpdev.ini',
        'git_branch': 'develop',
    },
    'live': {
        'source_path': '/srv/webapps/mmlokp-live/lokp',
        'customization_path': '/srv/webapps/mmlokp-live/lokp/lokp/customization'
                              '/omm',
        'virtualenv_path': '/srv/webapps/mmlokp-live/liveenv/bin/activate',
        'touch_file': '/etc/uwsgi-emperor/vassals/mmlokplive.ini',
        'git_branch': 'master',
    }
}


@task
def deploy(environment_name: str):
    if environment_name not in ENVIRONMENTS.keys():
        raise BaseException(f'{environment_name} is not a valid environment.')

    setup_environment(environment_name)

    with cd(env.source_path):
        update_lokp_source()
        update_customization_source()
        install_dependencies()
        touch_file()


def touch_file():
    run(f'touch {env.touch_file}')


def install_dependencies():
    with virtualenv():
        run('pip install -e .[deploy]')


def update_customization_source():
    with cd(env.customization_path):
        run(f'git pull origin {env.git_branch}')


def update_lokp_source():
    run(f'git pull origin {env.git_branch}')


def setup_environment(environment_name: str):
    """
    Set the proper environment and read the configured values.
    """
    env.environment = environment_name
    for option, value in ENVIRONMENTS[environment_name].items():
        setattr(env, option, value)


@contextmanager
def virtualenv():
    """
    Activate the virtual environment.
    """
    with prefix(f'source {env.virtualenv_path}'):
        yield
