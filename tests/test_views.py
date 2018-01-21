from .pages import MapPage, LandingPage, CreateActivityPage, DetailActivityPage
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
        map_page.do_login(
            username='admin', password=self.settings['lokp.admin_password'])

        # She sees she is redirected back to the map page.
        assert self.driver.current_url == self.get_url_from_route(
            map_page.route_name, kwargs_dict=map_page.route_kwargs,
            absolute=True)

        # She sees she is now logged in.
        assert map_page.is_logged_in()

    def test_logout_view(self):
        # Test that a user can log out.

        # Alice logs in
        map_page = MapPage(self.driver)
        map_page.do_login(
            username='admin', password=self.settings['lokp.admin_password'])
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
        create_page.do_login(
            username='admin', password=self.settings['lokp.admin_password'])

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
