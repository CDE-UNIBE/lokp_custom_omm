import time

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

    def get_els(self, locator: tuple) -> list:
        """
        Shortcut to get a list of elements.
        """
        return self.driver.find_elements(*locator)

    @staticmethod
    def format_locator(locator: tuple, **kwargs) -> tuple:
        return (
            locator[0],
            locator[1].format(**kwargs),
        )

    def scroll_to(self, element: WebElement):
        self.driver.execute_script("arguments[0].scrollIntoView();", element)

    def wait_for_visibility(self, element: WebElement):
        WebDriverWait(self.driver, 20).until(EC.visibility_of(element))

    def wait_for_invisibility(self, *locator):
        WebDriverWait(self.driver, 20).until(
            EC.invisibility_of_element_located(*locator))

    def set_style(self, element: WebElement, prop: str, value: str):
        self.driver.execute_script(
            f"arguments[0].style.{prop} = {value};", element)

    def do_logout_cookie(self):
        """
        Log out by deleting the cookie. Use this if the menu is not accessible.
        Be sure to redirect or refresh the page (self.driver.refresh()) after
        logging out.
        """
        self.driver.delete_cookie('auth_tkt')


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
    LOC_MENU_LIST = (By.XPATH, '//nav//a/span[contains(text(), "List")]')
    LOC_MENU_MAP = (By.XPATH, '//nav//a/span[contains(text(), "Map")]')

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

    def do_login(self, user=None, username: str='', password: str=''):
        """
        Do the login for a user.
        """
        if self.is_not_logged_in() is False:
            # User is already logged in
            return
        self.get_el(self.LOC_MENU_LOGIN).click()
        from ..pages.pages import LoginPage
        page = LoginPage(self.driver)
        if user is not None:
            username = user.username
            password = user.password
        page.fill_login_form(username, password)
        page.submit_login_form()

    def do_logout(self):
        self.get_el(self.LOC_MENU_LOGOUT).click()

    def is_not_found(self):
        return self.driver.title == '404 Not Found'

    def click_menu_list(self):
        self.get_el(self.LOC_MENU_LIST).click()

    def click_menu_map(self):
        self.get_el(self.LOC_MENU_MAP).click()

    def add_filter(
            self, key: str, value: str, operator: str=None,
            is_text: bool=False):
        self.get_el((By.XPATH, '//a[@data-activates="slide-out-filter"]')).click()
        self.get_el((By.XPATH, '//ul[@id="slide-out-filter"]//div[contains(@class, "js-add-new-filter")]')).click()

        # Key
        self.get_el((By.ID, 'new-filter-key')).click()
        key_xpath = '//ul[@id="dropdown_categories"]'
        self.wait_for_visibility(self.get_el((By.XPATH, key_xpath)))
        self.get_el((By.XPATH, f'{key_xpath}/li/a[text()="{key}"]')).click()
        self.wait_for_invisibility((By.XPATH, key_xpath))

        # Operator
        if operator:
            self.get_el((By.ID, 'new-filter-operator-display')).click()
            operator_xpath = '//ul[@id="new-filter-operator-dropdown"]'
            time.sleep(0.5)
            # self.wait_for_visibility(self.get_el((By.XPATH, operator_xpath)))
            self.get_el((By.XPATH, f'{operator_xpath}/li/a[text()="{operator}"]')).click()
            self.wait_for_invisibility((By.XPATH, operator_xpath))

        # Wait for the values to be populated
        time.sleep(0.5)

        # Value
        if is_text:
            self.get_el((By.ID, 'new-filter-value-internal')).send_keys(value)
        else:
            self.get_el((By.ID, 'new-filter-value-dd')).click()
            value_xpath = '//ul[@id="dropdown3"]'
            self.wait_for_visibility(self.get_el((By.XPATH, value_xpath)))
            self.get_el((By.XPATH, f'{value_xpath}/li/a[text()="{value}"]')).click()
            self.wait_for_invisibility((By.XPATH, value_xpath))

        # Submit
        self.get_el((By.ID, 'js-submit-new-filter')).click()
