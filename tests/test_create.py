from .pages.activities import DetailActivityPage, CreateActivityPage
from .pages.pages import LandingPage
from .base import FunctionalTestCase


class CreateTests(FunctionalTestCase):

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

    def test_create_activity_with_stakeholder(self):
        # Test that a new activity can be created with a stakeholder as
        # involvement

        # Alice goes to the landing page and enters the map (this step is
        # important for setting the location cookie correctly for the current
        # profile)
        landing_page = LandingPage(self.driver)
        self.get_page(landing_page)
        landing_page.click_entry_button()

        # She logs in
        create_page = CreateActivityPage(self.driver)
        create_page.do_login(user=self.user_editor1)

        # She starts to create a new activity
        self.get_page(create_page)
        create_page.create_activity(submit=False)

        # She creates a new involvement
        create_page.add_primary_investor()

        # She submits the form
        create_page.click_submit_button_success()

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

        # The investor is also there
        detail_page.has_investor('primary', 'Company 1', 'China')

    def test_create_activity_with_area_but_no_polygon(self):
        # Test that a new activity can be created with an area but no polygon.
        # This was a bug that should now be fixed.

        # Alice goes to the landing page and enters the map (this step is
        # important for setting the location cookie correctly for the current
        # profile)
        landing_page = LandingPage(self.driver)
        self.get_page(landing_page)
        landing_page.click_entry_button()

        # She logs in
        create_page = CreateActivityPage(self.driver)
        create_page.do_login(user=self.user_editor1)

        # She starts to create a new activity
        self.get_page(create_page)
        create_page.create_activity(submit=False)

        # She draws a new polygon
        create_page.fill_textfield('Intended area (ha)', '123')

        # She submits the form
        create_page.click_submit_button_success()

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
        detail_page.has_attribute('Intended area (ha)', '123.0')

        geom = self.get_taggroup_geometry(key='Intended area (ha)')
        assert geom == {}

    def test_create_activity_with_polygon(self):
        # Test that a new activity can be created with a polygon

        # Alice goes to the landing page and enters the map (this step is
        # important for setting the location cookie correctly for the current
        # profile)
        landing_page = LandingPage(self.driver)
        self.get_page(landing_page)
        landing_page.click_entry_button()

        # She logs in
        create_page = CreateActivityPage(self.driver)
        create_page.do_login(user=self.user_editor1)

        # She starts to create a new activity
        self.get_page(create_page)
        create_page.create_activity(submit=False)

        # She draws a new polygon
        create_page.fill_textfield('Intended area (ha)', '123')
        create_page.draw_polygon(map_index='2')

        # She submits the form
        create_page.click_submit_button_success()

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

        # Check in the DB that a geometry was created
        geom = self.get_taggroup_geometry(key='Intended area (ha)')
        assert geom != {}

    def test_create_activity_with_multipolygon(self):
        # Test that a new activity can be created with multi polygons.

        # Alice goes to the landing page and enters the map (this step is
        # important for setting the location cookie correctly for the current
        # profile)
        landing_page = LandingPage(self.driver)
        self.get_page(landing_page)
        landing_page.click_entry_button()

        # She logs in
        create_page = CreateActivityPage(self.driver)
        create_page.do_login(user=self.user_editor1)

        # She starts to create a new activity
        self.get_page(create_page)
        create_page.create_activity(submit=False)

        # She draws 2 new polygons
        create_page.fill_textfield('Intended area (ha)', '123')
        create_page.draw_polygon(map_index='2', size=25, offset=(0, 0))
        create_page.draw_polygon(map_index='2', size=25, offset=(30, 30))

        # She submits the form
        create_page.click_submit_button_success()

        # Check geometries in the database
        geom = self.get_taggroup_geometry(key='Intended area (ha)')
        assert geom['type'] == 'MultiPolygon'
        assert len(geom['coordinates']) == 2
