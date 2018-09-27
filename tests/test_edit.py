import pytest

from .pages.activities import DetailActivityPage, CreateActivityPage, \
    EditActivityPage
from .pages.pages import LandingPage, MapPage
from .base import FunctionalTestCase


class EditTest(FunctionalTestCase):

    @pytest.mark.usefixtures('activity_changeset')
    def test_edit_activity_no_change(self):
        # Test that pending activities can be edited
        activity_identifier = self.create_item(
            item_type='activity', user=self.user_editor1,
            changeset=self.activity_changeset('simple'))

        detail_page = DetailActivityPage(self.driver)
        detail_page.route_kwargs.update({'uid': activity_identifier})

        # Alice logs in
        map_page = MapPage(self.driver)
        self.get_page(map_page)
        map_page.do_login(user=self.user_editor1)

        # She opens the detail page
        self.get_page(detail_page)

        # She checks the detail page and sees the activity is pending and all
        # the attributes are there
        detail_page = DetailActivityPage(self.driver)
        detail_page.has_status('pending')
        detail_page.has_attribute('Spatial Accuracy', 'better than 100m')
        detail_page.has_attribute('Country', 'Myanmar')
        detail_page.has_attribute(
            'Intention of Investment', 'Agriculture', is_checkbox=True)
        detail_page.has_attribute('Remark', 'Remark about the intention')
        detail_page.has_attribute('Implementation status', 'In operation')

        # She clicks the edit button
        detail_page.click_edit_button()

        # She submits the form without changes
        create_page = CreateActivityPage(self.driver)
        create_page.click_submit_button_success()

        # She sees the activity is still pending and all the attributes there
        detail_page = DetailActivityPage(self.driver)
        detail_page.has_status('pending')
        detail_page.has_attribute('Spatial Accuracy', 'better than 100m')
        detail_page.has_attribute('Country', 'Myanmar')
        detail_page.has_attribute(
            'Intention of Investment', 'Agriculture', is_checkbox=True)
        detail_page.has_attribute('Remark', 'Remark about the intention')
        detail_page.has_attribute('Implementation status', 'In operation')

        # TODO: Check history

    @pytest.mark.usefixtures('activity_changeset')
    @pytest.mark.usefixtures('stakeholder_changeset')
    def test_edit_activity_with_stakeholder(self):
        # Test that pending activities with linked stakeholders can be edited
        stakeholder_identifier = self.create_item(
            item_type='stakeholder', user=self.user_editor1,
            changeset=self.stakeholder_changeset('simple'))

        activity_identifier = self.create_item(
            item_type='activity', user=self.user_editor1,
            changeset=self.activity_changeset(
                'linked', stakeholders=[(stakeholder_identifier, 'primary')]))

        detail_page = DetailActivityPage(self.driver)
        detail_page.route_kwargs.update({'uid': activity_identifier})

        # Alice logs in
        map_page = MapPage(self.driver)
        self.get_page(map_page)
        map_page.do_login(user=self.user_editor1)

        # She opens the detail page
        self.get_page(detail_page)

        # She checks the detail page and sees the activity is pending and all
        # the attributes are there
        detail_page = DetailActivityPage(self.driver)
        detail_page.has_status('pending')
        detail_page.has_attribute('Spatial Accuracy', 'better than 100m')
        detail_page.has_attribute('Country', 'Myanmar')
        detail_page.has_attribute(
            'Intention of Investment', 'Agriculture', is_checkbox=True)
        detail_page.has_attribute('Remark', 'Remark about the intention')
        detail_page.has_attribute('Implementation status', 'In operation')
        detail_page.has_investor('primary', 'Company 1', 'China')

        # She clicks the edit button
        detail_page.click_edit_button()

        # She changes a dropdown and submits the form
        create_page = CreateActivityPage(self.driver)
        create_page.fill_textfield(
            'Remark (Intention of Investment)', 'Some other remark',
            empty_first=True)
        create_page.click_submit_button_success()

        # She sees the activity is still pending and all the attributes there
        detail_page = DetailActivityPage(self.driver)
        detail_page.has_status('pending')
        detail_page.has_attribute('Spatial Accuracy', 'better than 100m')
        detail_page.has_attribute('Country', 'Myanmar')
        detail_page.has_attribute(
            'Intention of Investment', 'Agriculture', is_checkbox=True)

        detail_page.has_attribute('Remark', 'Some other remark')
        detail_page.has_attribute('Implementation status', 'In operation')
        detail_page.has_investor('primary', 'Company 1', 'China')

    @pytest.mark.usefixtures('activity_changeset')
    def test_edit_activity_remove_polygon(self):
        # Test that activities can be edited (by removing the geometry)
        activity_identifier = self.create_item(
            item_type='activity', user=self.user_editor1,
            changeset=self.activity_changeset('polygon'))

        detail_page = DetailActivityPage(self.driver)
        detail_page.route_kwargs.update({'uid': activity_identifier})

        # Alice logs in
        map_page = MapPage(self.driver)
        self.get_page(map_page)
        map_page.do_login(user=self.user_editor1)

        geom_1 = self.get_taggroup_geometry(
            identifier=activity_identifier, version=1, key='Intended area (ha)')

        # She opens the detail page
        self.get_page(detail_page)

        detail_page = DetailActivityPage(self.driver)
        detail_page.click_edit_button()

        edit_page = EditActivityPage(self.driver)
        edit_page.remove_map_features()
        edit_page.click_submit_button_success()

        geom_2 = self.get_taggroup_geometry(
            identifier=activity_identifier, version=2, key='Intended area (ha)')

        assert geom_1 != geom_2
        assert geom_2 == {}

    @pytest.mark.usefixtures('activity_changeset')
    def test_edit_activity_with_polygon_no_change(self):
        # Test that activities with polygons can be edited (without change)
        activity_identifier = self.create_item(
            item_type='activity', user=self.user_editor1,
            changeset=self.activity_changeset('polygon'))

        detail_page = DetailActivityPage(self.driver)
        detail_page.route_kwargs.update({'uid': activity_identifier})

        # Alice logs in
        map_page = MapPage(self.driver)
        self.get_page(map_page)
        map_page.do_login(user=self.user_editor1)

        # She opens the detail page
        self.get_page(detail_page)

        # She checks the detail page and sees the activity is pending and all
        # the attributes are there
        detail_page = DetailActivityPage(self.driver)
        detail_page.has_status('pending')
        detail_page.has_attribute('Spatial Accuracy', 'better than 100m')
        detail_page.has_attribute('Country', 'Myanmar')
        detail_page.has_attribute(
            'Intention of Investment', 'Agriculture', is_checkbox=True)
        detail_page.has_attribute('Remark', 'Remark about the intention')
        detail_page.has_attribute('Implementation status', 'In operation')

        geom_1 = self.get_taggroup_geometry(
            identifier=activity_identifier, version=1, key='Intended area (ha)')

        # She clicks the edit button
        detail_page.click_edit_button()

        # She submits the form without changes
        create_page = CreateActivityPage(self.driver)
        create_page.click_submit_button_success()

        # She sees the activity is still pending and all the attributes there
        detail_page = DetailActivityPage(self.driver)
        detail_page.has_status('pending')
        detail_page.has_attribute('Spatial Accuracy', 'better than 100m')
        detail_page.has_attribute('Country', 'Myanmar')
        detail_page.has_attribute(
            'Intention of Investment', 'Agriculture', is_checkbox=True)
        detail_page.has_attribute('Remark', 'Remark about the intention')
        detail_page.has_attribute('Implementation status', 'In operation')

        geom_2 = self.get_taggroup_geometry(
            identifier=activity_identifier, version=2, key='Intended area (ha)')
        assert geom_1 == geom_2

    @pytest.mark.usefixtures('activity_changeset')
    def test_pending_activity(self):
        # Test that pending activities can be seen and edited only by editors
        # who created it, moderators and admins. It can only be reviewed by
        # moderators and admins.
        activity_identifier = self.create_item(
            item_type='activity', user=self.user_editor1,
            changeset=self.activity_changeset('simple'))

        detail_page = DetailActivityPage(self.driver)
        detail_page.route_kwargs.update({'uid': activity_identifier})

        # Alice is not logged in. She sees the detail page is not visible to her
        self.get_page(detail_page)
        assert detail_page.is_not_found()

        # Alice logs in
        map_page = MapPage(self.driver)
        self.get_page(map_page)
        map_page.do_login(user=self.user_editor1)

        # She opens the detail page again and this time the page is found. She
        # sees the deal is editable but not reviewable.
        self.get_page(detail_page)
        assert detail_page.is_not_found() is False
        assert detail_page.is_editable() is True
        assert detail_page.is_reviewable() is False

        # She logs out again
        detail_page.do_logout()

        # Bob logs in as another editor
        detail_page.do_login(user=self.user_editor2)
        # Setting the profile is necessary
        landing_page = LandingPage(self.driver)
        self.get_page(landing_page)
        landing_page.click_entry_button()

        # He opens the detail page and sees the page is found. He sees the deal
        # is editable and reviewable.
        self.get_page(detail_page)
        assert detail_page.is_not_found() is True

        # He logs out again
        detail_page.do_logout_cookie()
        self.get_page(map_page)

        # Chris logs in as moderator
        detail_page.do_login(user=self.user_moderator)
        # Setting the profile is necessary
        landing_page = LandingPage(self.driver)
        self.get_page(landing_page)
        landing_page.click_entry_button()

        # He opens the detail page and sees the page is found. He sees the deal
        # is editable and reviewable.
        self.get_page(detail_page)
        assert detail_page.is_not_found() is False
        assert detail_page.is_editable() is True
        assert detail_page.is_reviewable() is True

        # He logs out again
        detail_page.do_logout()

        # Denise logs in as administrator
        detail_page.do_login(user=self.user_admin)

        # She opens the detail page and sees the page is found. She sees the
        # deal is editable and reviewable.
        self.get_page(detail_page)
        assert detail_page.is_not_found() is False
        assert detail_page.is_editable() is True
        assert detail_page.is_reviewable() is True
