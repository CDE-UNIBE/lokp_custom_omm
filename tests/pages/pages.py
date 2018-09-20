import time

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

    LOC_BUTTON_ZOOM_IN = (By.XPATH, '//a[@class="leaflet-control-zoom-in"]')

    def zoom_in(self):
        self.get_el(self.LOC_BUTTON_ZOOM_IN).click()
        # Wait for the zoom animation to finish. This is especially important
        # when zooming multiple times. Just waiting for half a second is not
        # very nice, but a lot faster than detecting the disappearance of the
        # zoom animation.
        time.sleep(0.5)


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


class ListPage(BasePage):
    route_name = 'grid_view'

    LOC_TABLE_ROW_ID = (
        By.XPATH, '//table[@id="itemgrid"]/tbody/tr[{index_1}]/td/a[contains('
                  '@href, "{identifier}")]')
    LOC_BUTTON_FILTER_PROFILE = (
        By.XPATH, '//a[contains(@href, "bbox=profile")]')

    def check_entries(self, expected: list):
        for i, entry in enumerate(expected):
            self.check_entry(index_1=i+1, expected=entry)

    def check_entry(self, index_1: int, expected: dict):
        if 'identifier' in expected:
            self.get_el(self.format_locator(
                self.LOC_TABLE_ROW_ID,
                index_1=index_1,
                identifier=expected['identifier']
            ))

    def click_filter_by_profile(self):
        self.get_el(self.LOC_BUTTON_FILTER_PROFILE).click()


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
        self.wait_for_invisibility(
            (By.XPATH, f'//form[@id="{self.FORM_ID}"]//select[@name="{key}"]/../ul'))

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
