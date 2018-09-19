from .pages.pages import MapPage, LandingPage
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
