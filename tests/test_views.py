import pytest

from .pages.pages import MapPage, LandingPage, CreateActivityPage, \
    DetailActivityPage
from .base import FunctionalTestCase


class ViewTests(FunctionalTestCase):

    def test_landing_page(self):
        # Test that the landing page is available.
        page = LandingPage(self.driver)
        self.get_page(page)
        assert page.is_valid()

    def test_login_view(self):
        # Test that a user can log in.

        # Alice goes to the map page.
        map_page = MapPage(self.driver)
        self.get_page(map_page)

        # She sees she is not logged in.
        assert map_page.is_not_logged_in()

        # She logs in. This fills out the login form and submits it.
        map_page.do_login(user=self.user_editor1)

        # She sees she is redirected back to the map page.
        assert self.driver.current_url == self.get_url_from_page(
            map_page, absolute=True)

        # She sees she is now logged in.
        assert map_page.is_logged_in()

    def test_logout_view(self):
        # Test that a user can log out.

        # Alice logs in
        map_page = MapPage(self.driver)
        map_page.do_login(user=self.user_editor1)
        assert map_page.is_logged_in()

        # She logs out again
        map_page.do_logout()
        assert map_page.is_not_logged_in()

    def test_create_activity(self):
        # Test that a new activity can be created.

        # Alice goes to the landing page and enters the map (this step is
        # important for setting the location cookie correctly for the current
        # profile)
        landing_page = LandingPage(self.driver)
        self.get_page(landing_page)
        landing_page.click_entry_button()

        # She logs in
        create_page = CreateActivityPage(self.driver)
        create_page.do_login(user=self.user_editor1)

        # She creates a new activity
        self.get_page(create_page)
        create_page.create_activity()

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
