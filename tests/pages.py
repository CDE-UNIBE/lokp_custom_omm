from selenium.webdriver.chrome.webdriver import WebDriver
from selenium.webdriver.common.by import By
from selenium.webdriver.remote.webelement import WebElement
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait


class Page:
    route_kwargs = None

    @property
    def route_name(self):
        raise NotImplementedError

    def __init__(self, driver: WebDriver):
        self.driver = driver

    def get_el(self, locator: tuple) -> WebElement:
        """
        Shortcut to get an element.
        """
        return self.driver.find_element(*locator)

    def scroll_to(self, element: WebElement):
        self.driver.execute_script("arguments[0].scrollIntoView();", element)

    def wait_for_visibility(self, element: WebElement):
        WebDriverWait(self.driver, 20).until(EC.visibility_of(element))

    def set_style(self, element: WebElement, prop: str, value: str):
        self.driver.execute_script(
            f"arguments[0].style.{prop} = {value};", element)


class BasePage(Page):
    """
    Basically every page with a top menu.
    """
    route_name = None

    LOC_MENU_LOGOUT = (
        By.XPATH,
        '//div[@class="nav-wrapper"]//a[text()[contains(.,"Logout")]]')
    LOC_MENU_LOGIN = (
        By.XPATH,
        '//div[@class="nav-wrapper"]//a[text()[contains(.,"Login")]]')

    def is_logged_in(self) -> bool:
        """
        A user is not logged in if there is a "Logout" entry in the top menu
        """
        return bool(self.get_el(self.LOC_MENU_LOGOUT))

    def is_not_logged_in(self) -> bool:
        """
        A user is not logged in if there is a "Login" entry in the top menu
        """
        return bool(self.get_el(self.LOC_MENU_LOGIN))

    def do_login(self, username: str, password: str):
        """
        Do the login for a user.
        """
        if self.is_not_logged_in() is False:
            # User is already logged in
            return
        self.get_el(self.LOC_MENU_LOGIN).click()
        page = LoginPage(self.driver)
        page.fill_login_form(username, password)
        page.submit_login_form()

    def do_logout(self):
        self.get_el(self.LOC_MENU_LOGOUT).click()


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


class CreateActivityPage(BasePage):
    route_name = 'activities_read_many'
    route_kwargs = {'output': 'form'}

    LOC_FIELD_MAP = (By.XPATH, '//div[@class="olMap"]')
    LOC_BUTTON_SUBMIT = (By.ID, 'activityformsubmit')
    LOC_SUCCESS_MESSAGE = (By.CLASS_NAME, 'text-success-large')
    LOC_LINK_DETAILS = (By.XPATH, '//a[text()="View the Deal."]')

    def create_activity(self):
        """
        Create an activity and open the details page.
        """
        self.get_el(self.LOC_FIELD_MAP).click()
        self.select_dropdown_value('Spatial Accuracy', value='better than 100m')
        self.select_dropdown_value('Country', value='Myanmar')
        self.select_checkbox_values('Intention of Investment', ['Agriculture'])
        self.fill_textfield(
            'Remark (Intention of Investment)', 'Remark about the intention')
        self.select_dropdown_value('Implementation status', 'In operation')
        self.click_submit_button()
        self.get_el(self.LOC_SUCCESS_MESSAGE)
        self.get_el(self.LOC_LINK_DETAILS).click()

    def select_dropdown_value(self, key: str, value: str=''):
        self.driver.find_element_by_xpath(
            f'//form[@id="activityform"]//select[@name="{key}"]/..').click()
        if not value:
            dropdown_value = self.driver.find_element_by_xpath(
                f'//form[@id="activityform"]//select[@name="{key}"]/../ul/'
                f'li[2]/span')
        else:
            dropdown_value = self.driver.find_element_by_xpath(
                f'//form[@id="activityform"]//select[@name="{key}"]/../ul/'
                f'li/span[text()="{value}"]')
        self.scroll_to(dropdown_value)
        dropdown_value.click()
        # Hide dropdown container, otherwise it may overlap elements to be
        # clicked in a next step
        dropdown_container = self.driver.find_element_by_xpath(
            f'//form[@id="activityform"]//select[@name="{key}"]/../ul')
        self.set_style(dropdown_container, 'display', '"none"')

    def select_checkbox_values(self, key: str, values: list):
        for value in values:
            checkbox = self.driver.find_element_by_xpath(
                f'//form[@id="activityform"]//label[contains(text(), "{key}")]'
                f'/../..//input[@value="{value}"]')
            # Make checkbox clickable
            self.set_style(checkbox, 'position', '"relative"')
            self.set_style(checkbox, 'opacity', '1')
            self.set_style(checkbox, 'left', '0')
            checkbox.click()

    def fill_textfield(self, key: str, value: str, empty_first: bool=False):
        field = self.driver.find_element_by_xpath(
            f'//form[@id="activityform"]//*[self::textarea or '
            f'self::input[@type="text"]][@name="{key}"]')
        if empty_first:
            field.clear()
        field.send_keys(value)

    def click_submit_button(self):
        self.get_el(self.LOC_BUTTON_SUBMIT).click()


class DetailActivityPage(BasePage):
    route_name = 'activities_read_one'
    route_kwargs = {'output': 'html', 'identifier': None}

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
