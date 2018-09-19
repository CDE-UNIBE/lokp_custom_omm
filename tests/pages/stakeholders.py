from selenium.webdriver.common.by import By

from .pages import FormPageMixin


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
