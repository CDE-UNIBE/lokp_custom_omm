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


class ListActivityEndpoint(Endpoint):
    route_name = 'activities_read_many'
    route_kwargs = {'output': 'json'}

    @staticmethod
    def add_url_params(url: str, profile: str=None, order_by: str=None) -> str:
        """
        Add URL parameters such as filter and order to the endpoint url.
        """
        url_params = []
        if profile:
            url_params.append(f'_PROFILE_={profile}')
        if order_by:
            url_params.append(f'order_by={order_by}')
        if url_params:
            return f'{url}?{"&".join(url_params)}'
        else:
            return url


class CreateStakeholderEndpoint(CreateActivityEndpoint):
    route_name = 'stakeholders_create'


class ListStakeholderEndpoint(ListActivityEndpoint):
    route_name = 'stakeholders_read_many'
