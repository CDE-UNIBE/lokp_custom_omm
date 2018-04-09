import pytest
import requests

from .pages.api import ListStakeholderEndpoint, ListActivityEndpoint
from .base import ApiTestCase


class ActivityApiTests(ApiTestCase):

    @pytest.mark.usefixtures('activity_changeset')
    def test_stakeholder_list_ordered(self):

        self.create_test_users()
        a_agri = self.create_item(
            item_type='activity', user=self.user_editor1,
            changeset=self.activity_changeset(
                'simple', intention='Agriculture'),
            status='active')
        a_mining = self.create_item(
            item_type='activity', user=self.user_editor1,
            changeset=self.activity_changeset('simple', intention='Mining'),
            status='active')

        endpoint = ListActivityEndpoint()
        url = self.get_url_from_page(endpoint)

        unordered = requests.get(endpoint.add_url_params(
            url, profile='myanmar'))
        assert self.get_identifiers(unordered.json()) == [a_mining, a_agri]

        ordered = requests.get(endpoint.add_url_params(
            url, profile='myanmar', order_by='Intention of Investment'))
        assert self.get_identifiers(ordered.json()) == [a_agri, a_mining]


class StakeholderApiTests(ApiTestCase):

    @pytest.mark.usefixtures('stakeholder_changeset')
    def test_stakeholder_list_ordered(self):

        self.create_test_users()
        sh_a = self.create_item(
            item_type='stakeholder', user=self.user_editor1,
            changeset=self.stakeholder_changeset('simple', name='A Company'),
            status='active')
        sh_z = self.create_item(
            item_type='stakeholder', user=self.user_editor1,
            changeset=self.stakeholder_changeset('simple', name='Z Company'),
            status='active')

        endpoint = ListStakeholderEndpoint()
        url = self.get_url_from_page(endpoint)

        unordered = requests.get(url)
        assert self.get_identifiers(unordered.json()) == [sh_z, sh_a]

        ordered = requests.get(endpoint.add_url_params(url, order_by='Name'))
        assert self.get_identifiers(ordered.json()) == [sh_a, sh_z]
