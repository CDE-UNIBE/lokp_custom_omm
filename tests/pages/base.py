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
