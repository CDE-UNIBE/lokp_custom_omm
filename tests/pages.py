from selenium.webdriver.chrome.webdriver import WebDriver
from selenium.webdriver.common.by import By
from selenium.webdriver.remote.webelement import WebElement


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


class LandingPage(Page):
    # Landing page does not have a menu
    route_name = 'index'

    LOC_BUTTON_ENTRY = (By.XPATH, '//a[@class="btn"]')

    def is_valid(self) -> bool:
        return bool(self.get_el(self.LOC_BUTTON_ENTRY))


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
