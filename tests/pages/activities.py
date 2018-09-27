from selenium.webdriver import ActionChains
from selenium.webdriver.common.by import By

from .base import BasePage
from .pages import FormPageMixin
from .stakeholders import CreateStakeholderPage


class ActivityFormMixin(FormPageMixin):

    FORM_ID = 'activityform'

    XPATH_MAP = '(//div[contains(@class, "map-div")])[{map_index}]'
    LOC_FIELD_MAP = (By.XPATH, '(//div[contains(@class, "map-div")])[1]')
    LOC_BUTTON_SUBMIT = (By.ID, 'activityformsubmit')
    LOC_LINK_DETAILS = (By.XPATH, '//a[text()="View the Deal."]')
    LOC_BUTTON_CREATE_PRIMARY_INVESTOR = (
        By.NAME, 'createinvolvement_primaryinvestor')

    def set_map_point(self):
        # Activate draw mode first
        draw_locator = (
            self.LOC_FIELD_MAP[0],
            f'{self.LOC_FIELD_MAP[1]}//a[@class="leaflet-draw-draw-marker"]'
        )
        self.get_el(draw_locator).click()
        self.get_el(self.LOC_FIELD_MAP).click()

    def draw_polygon(self, map_index='2', size=50, offset=(0,0)):
        map_xpath = self.XPATH_MAP.format(map_index=map_index)
        draw_locator = self.driver.find_element_by_xpath(
            f'{map_xpath}//a[@class="leaflet-draw-draw-polygon"]')
        draw_locator.click()
        map = self.driver.find_element_by_xpath(map_xpath)
        map_height = map.size['height']
        map_width = map.size['width']
        action = ActionChains(self.driver)
        for coords in [
            (map_width/2+offset[0], map_height/2+offset[1]),
            (map_width/2+offset[0], map_height/2+size+offset[1]),
            (map_width/2+size+offset[0], map_height/2+size+offset[1]),
            (map_width/2+size+offset[0], map_height/2+offset[1]),
            (map_width/2+offset[0], map_height/2+offset[1])]:
            action.move_to_element_with_offset(map, *coords)
            action.click()
            action.pause(0.1)
        action.perform()

    def remove_map_features(self, map_index='2'):
        map_xpath = self.XPATH_MAP.format(map_index=map_index)
        delete_button = self.driver.find_element_by_xpath(
            f'{map_xpath}//a[@class="leaflet-draw-edit-remove"]')
        delete_button.click()
        delete_all_button = self.driver.find_element_by_xpath(
            f'{map_xpath}//a[text()="Clear All"]')
        delete_all_button.click()

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


class CreateActivityPage(ActivityFormMixin):
    route_name = 'activities_read_many'
    route_kwargs = {'output': 'form'}

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


class EditActivityPage(ActivityFormMixin):
    route_name = 'activities_read_one'
    route_kwargs = {'output': 'form', 'uid': None}


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
        key_el_xpath = f'//h5[contains(@class, "dealview_item_titel") and ' \
                       f'text()="{key}"]'
        if is_checkbox is False:
            self.driver.find_element_by_xpath(
                f'{key_el_xpath}/../../div[@class="dealview_item_attribute" '
                f'and contains(text(), "{value}")]')
        else:
            self.driver.find_element_by_xpath(
                f'{key_el_xpath}/../../div[@class="dealview_item_attribute"]'
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
