import pytest

from .pages.pages import MapPage, LandingPage, ListPage
from .base import FunctionalTestCase


class ListTests(FunctionalTestCase):

    @pytest.mark.usefixtures('activity_changeset')
    def test_list_is_filtered_spatially(self):
        # Test that the list is filtered spatially by the extent currently
        # visible on the map.
        a_id_1 = self.create_item(
            item_type='activity', user=self.user_editor1,
            changeset=self.activity_changeset('simple'), status='active'
        )
        a_id_2 = self.create_item(
            item_type='activity', user=self.user_editor1,
            changeset=self.activity_changeset(
                'simple', coordinates=[96.98, 26.25]),
            status='active'
        )

        # Start from the landing page to correctly set the location cookie.
        landing_page = LandingPage(self.driver)
        self.get_page(landing_page)
        landing_page.click_entry_button()

        # For the initial zoom level, there are 2 activities on the map, which
        # are also available in the list view.
        map_page = MapPage(self.driver)
        map_page.click_menu_list()
        list_page = ListPage(self.driver)
        list_page.check_entries(expected=[
            {
                'identifier': a_id_2,
            },
            {
                'identifier': a_id_1,
            }
        ])

        # Back on the map, when zooming in, only 1 activity remains. Also on the
        # list, there is now only 1 entry.
        list_page.click_menu_map()
        for _ in range(5):
            map_page.zoom_in()
        map_page.click_menu_list()
        list_page.check_entries(expected=[
            {
                'identifier': a_id_1,
            }
        ])

        # The current map extent is stored in a cookie. Therefore going to the
        # map and back to the list should return the same spatially filtered
        # list as before.
        list_page.click_menu_map()
        map_page.click_menu_list()
        list_page.check_entries(expected=[
            {
                'identifier': a_id_1,
            }
        ])

        # There is a button to filter by the extent of the profile. Clicking on
        # this brings all results back on the list.
        list_page.click_filter_by_profile()
        list_page.check_entries(expected=[
            {
                'identifier': a_id_2,
            },
            {
                'identifier': a_id_1,
            }
        ])
