import requests
from requests.cookies import RequestsCookieJar


class Endpoint:
    route_kwargs = None

    @property
    def route_name(self):
        raise NotImplementedError


class LoginEndpoint(Endpoint):
    route_name = 'login_json'

    @staticmethod
    def login(
            login_url: str, username: str, password: str) -> RequestsCookieJar:
        login_data = {
            'login': username,
            'password': password,
        }
        login_request = requests.post(login_url, json=login_data)
        assert login_request.status_code == 200
        assert login_request.json().get('login') == 'true'
        return login_request.cookies


class CreateActivityEndpoint(Endpoint):
    route_name = 'activities_create'

    @staticmethod
    def create(
            create_url: str, login_cookies: RequestsCookieJar,
            changeset: dict) -> str:
        """
        This creates a new Activity by using the JSON API. If successful, the
        UUID of the new Activity is returned.
        """
        create_request = requests.post(
            create_url, json=changeset, cookies=login_cookies)
        assert create_request.status_code == 201
        assert create_request.json().get('created') is True
        return create_request.json()['data'][0]['id']
