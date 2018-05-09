from selenium.webdriver import ActionChains
from selenium.webdriver.common.by import By

from ..pages.base import Page, BasePage


class LandingPage(Page):
    # Landing page does not have a menu
    route_name = 'index'

    LOC_BUTTON_ENTRY = (By.XPATH, '//a[@class="btn"]')

    def is_valid(self) -> bool:
        return bool(self.get_el(self.LOC_BUTTON_ENTRY))

    def click_entry_button(self):
        self.get_el(self.LOC_BUTTON_ENTRY).click()


class MapPage(BasePage):
    route_name = 'map_view'


class LoginPage(BasePage):
    route_name = 'login'

    LOC_FIELD_LOGIN = (By.ID, 'login')
    LOC_FIELD_PASSWORD = (By.ID, 'password')
    LOC_BUTTON_SUBMIT = (By.CSS_SELECTOR, 'button[type="submit"]')

    def fill_login_form(self, username: str, password: str):
        self.get_el(self.LOC_FIELD_LOGIN).send_keys(username)
        self.get_el(self.LOC_FIELD_PASSWORD).send_keys(password)

    def submit_login_form(self):
        self.get_el(self.LOC_BUTTON_SUBMIT).click()


class LogoutPage(Page):
    route_name = 'logout'


class FormPageMixin(BasePage):
    LOC_SUCCESS_MESSAGE = (By.CLASS_NAME, 'text-success-large')

    @property
    def LOC_BUTTON_SUBMIT(self):
        raise NotImplementedError()

    @property
    def FORM_ID(self):
        raise NotImplementedError()

    def select_dropdown_value(self, key: str, value: str=''):
        self.driver.find_element_by_xpath(
            f'//form[@id="{self.FORM_ID}"]//select[@name="{key}"]/..').click()
        if not value:
            dropdown_value = self.driver.find_element_by_xpath(
                f'//form[@id="{self.FORM_ID}"]//select[@name="{key}"]/../ul/'
                f'li[2]/span')
        else:
            dropdown_value = self.driver.find_element_by_xpath(
                f'//form[@id="{self.FORM_ID}"]//select[@name="{key}"]/../ul/'
                f'li/span[text()="{value}"]')
        self.scroll_to(dropdown_value)
        dropdown_value.click()
        # Hide dropdown container, otherwise it may overlap elements to be
        # clicked in a next step
        dropdown_container = self.driver.find_element_by_xpath(
            f'//form[@id="{self.FORM_ID}"]//select[@name="{key}"]/../ul')
        self.set_style(dropdown_container, 'display', '"none"')

    def select_checkbox_values(self, key: str, values: list):
        for value in values:
            checkbox = self.driver.find_element_by_xpath(
                f'//form[@id="{self.FORM_ID}"]//label[contains(text(), "{key}")]'
                f'/../..//input[@value="{value}"]')
            # Make checkbox clickable
            self.set_style(checkbox, 'position', '"relative"')
            self.set_style(checkbox, 'opacity', '1')
            self.set_style(checkbox, 'left', '0')
            checkbox.click()

    def fill_textfield(self, key: str, value: str, empty_first: bool=False):
        field = self.driver.find_element_by_xpath(
            f'//form[@id="{self.FORM_ID}"]//*[self::textarea or '
            f'self::input[@type="text"]][@name="{key}"]')
        if empty_first:
            field.clear()
        field.send_keys(value)

    def click_submit_button(self):
        self.get_el(self.LOC_BUTTON_SUBMIT).click()


class CreateActivityPage(FormPageMixin):
    route_name = 'activities_read_many'
    route_kwargs = {'output': 'form'}

    FORM_ID = 'activityform'

    LOC_FIELD_MAP = (By.XPATH, '//div[@id="map11"]')
    LOC_BUTTON_SUBMIT = (By.ID, 'activityformsubmit')
    LOC_LINK_DETAILS = (By.XPATH, '//a[text()="View the Deal."]')
    LOC_BUTTON_CREATE_PRIMARY_INVESTOR = (
        By.NAME, 'createinvolvement_primaryinvestor')

    def create_activity(self, submit=True):
        """
        Create an activity and open the details page.
        """
        self.set_map_point()
        self.select_dropdown_value('Spatial Accuracy', value='better than 100m')
        self.select_dropdown_value('Country', value='Myanmar')
        self.select_checkbox_values('Intention of Investment', ['Agriculture'])
        self.fill_textfield(
            'Remark (Intention of Investment)', 'Remark about the intention')
        self.select_dropdown_value('Implementation status', 'In operation')
        if submit is True:
            self.click_submit_button_success()

    def set_map_point(self):
        # Activate draw mode first
        draw_locator = (
            self.LOC_FIELD_MAP[0],
            f'{self.LOC_FIELD_MAP[1]}//a[@class="leaflet-draw-draw-marker"]'
        )
        self.get_el(draw_locator).click()
        self.get_el(self.LOC_FIELD_MAP).click()

    def draw_polygon(self, map_id='map1'):
        draw_locator = self.driver.find_element_by_xpath(
            f'//div[@id="{map_id}"]//a[@class="leaflet-draw-draw-polygon"]')
        draw_locator.click()
        map = self.driver.find_element_by_xpath(f'//div[@id="{map_id}"]')
        map_height = map.size['height']
        map_width = map.size['width']
        rectangle_size = 50
        action = ActionChains(self.driver)
        for coords in [
            (map_width/2, map_height/2),
            (map_width/2, map_height/2+rectangle_size),
            (map_width/2+rectangle_size, map_height/2+rectangle_size),
            (map_width/2+rectangle_size, map_height/2),
            (map_width/2, map_height/2)]:
            action.move_to_element_with_offset(map, *coords)
            action.click()
            action.pause(0.1)
        action.perform()

    def click_submit_button_success(self):
        # Checks for success and redirects to details page
        self.click_submit_button()
        self.get_el(self.LOC_SUCCESS_MESSAGE)
        self.get_el(self.LOC_LINK_DETAILS).click()

    def add_primary_investor(self):
        self.click_create_primary_investor()
        stakeholder_create_page = CreateStakeholderPage(self.driver)
        stakeholder_create_page.create_stakeholder()
        self.check_investor('Company 1')

    def check_investor(self, stakeholder_name: str):
        self.get_el((
            By.XPATH,
            f'//form[@id="{self.FORM_ID}"]//*[self::input[@type="text"]]['
            f'@name="Name" and @value="{stakeholder_name}"]'))

    def click_create_primary_investor(self):
        self.get_el(self.LOC_BUTTON_CREATE_PRIMARY_INVESTOR).click()


class CreateStakeholderPage(FormPageMixin):
    route_name = 'stakeholders_read_many'
    route_kwargs = {'output': 'form'}

    FORM_ID = 'stakeholderform'

    LOC_BUTTON_SUBMIT = (By.ID, 'stakeholderformsubmit')
    LOC_LINK_DETAILS = (By.XPATH, '//a[text()="View the Deal."]')
    LOC_SUCCESS_MESSAGE = (
        By.XPATH,
        '//div[contains(@class, "card-panel")]//strong[text()="Success"]')

    def create_stakeholder(self, submit=True):
        self.fill_textfield('Name', 'Company 1')
        self.select_dropdown_value('Country of origin', 'China')
        if submit is True:
            self.click_submit_button_success()

    def click_submit_button_success(self):
        # Checks for success (redirect to ActivityCreatePage is usually done
        # automatically)
        self.click_submit_button()
        self.get_el(self.LOC_SUCCESS_MESSAGE)


class DetailActivityPage(BasePage):
    route_name = 'activities_read_one'
    route_kwargs = {'output': 'html', 'uid': None}

    LOC_ACTIVITY_TOOLBAR_ITEMS = (
        By.XPATH, '//div[contains(@class, "deal-top-toolbar")]/ul/li/a/span'
                  '[@class="link-with-icon"]'
    )
    LOC_ACTIVITY_EDIT_BUTTON = (
        By.XPATH,
        '//div[contains(@class, "deal-top-toolbar")]//a/i[@class="icon-pencil"]/..'
    )

    def has_status(self, status: str):
        if status == 'pending':
            self.driver.find_element_by_xpath('//h5[text()="Pending Version"]')
        else:
            raise NotImplementedError()

    def has_attribute(self, key: str, value: str, is_checkbox: bool=False):
        if is_checkbox is False:
            self.driver.find_element_by_xpath(
                f'//h5[contains(@class, "dealview_item_titel") and '
                f'text()="{key}"]/../../div[@class="dealview_item_attribute" '
                f'and contains(text(), "{value}")]')
        else:
            self.driver.find_element_by_xpath(
                f'//h5[contains(@class, "dealview_item_titel") and '
                f'text()="{key}"]/../../div[@class="dealview_item_attribute"]'
                f'/p[contains(text(), "{value}")]')

    def has_investor(self, investor_type: str, name: str, country: str):
        if investor_type == 'primary':
            investor_type_name = 'Primary Investor'
        else:
            raise Exception('Unknown investor_type')
        self.driver.find_element_by_xpath(
            f'//h5[contains(text(), "{investor_type_name}")]/../..//h5['
            f'contains(@class, "dealview_item_titel") and text()="Name"]/../../'
            f'div[@class="dealview_item_attribute" and contains('
            f'text(), "{name}")]')
        self.driver.find_element_by_xpath(
            f'//h5[contains(text(), "{investor_type_name}")]/../..//h5['
            f'contains(@class, "dealview_item_titel") and '
            f'text()="Country of origin"]/../../'
            f'div[@class="dealview_item_attribute" and contains('
            f'text(), "{country}")]')

    def is_reviewable(self):
        toolbar_elements = self.get_els(self.LOC_ACTIVITY_TOOLBAR_ITEMS)
        return 'Review' in [el.text for el in toolbar_elements]

    def is_editable(self):
        toolbar_elements = self.get_els(self.LOC_ACTIVITY_TOOLBAR_ITEMS)
        return 'Edit this Deal' in [el.text for el in toolbar_elements]

    def click_edit_button(self):
        self.get_el(self.LOC_ACTIVITY_EDIT_BUTTON).click()
