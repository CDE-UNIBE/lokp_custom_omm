import pytest


@pytest.fixture(scope='class')
def stakeholder_changeset(request):
    """
    The main function to provide changesets for Stakeholders.

    Mark your test to use this fixture:
        @pytest.mark.usefixtures('stakeholder_changeset')
    and within the test, get one of the changesets as follows:
        self.stakeholder_changeset('<name>', [*args, **kwargs])
    """
    def get_changeset(r, changeset, *args, **kwargs):
        try:
            return getattr(StakeholderChangesets, changeset)(*args, **kwargs)
        except AttributeError:
            raise Exception(
                'StakeholderChangesets has no fixture called "{}"'.format(
                    changeset))

    request.cls.stakeholder_changeset = get_changeset


class StakeholderChangesets:

    @staticmethod
    def simple(name='Company 1'):
        """
        A simple Stakeholder of Myanmar.

        Name:       <name> (default: Company 1)
        Country:    Myanmar
        """
        return {
            "stakeholders": [
                {
                    "taggroups": [
                        {
                            "main_tag": {
                                "value": name,
                                "key": "Name"
                            },
                            "tags": [
                                {
                                    "value": name,
                                    "key": "Name",
                                    "op": "add"
                                }
                            ],
                            "op": "add"
                        }, {
                            "main_tag": {
                                "value": "China",
                                "key": "Country of origin"
                            },
                            "tags": [
                                {
                                    "value": "China",
                                    "key": "Country of origin",
                                    "op": "add"
                                }
                            ],
                            "op": "add"
                        }
                    ],
                    "version": 1,
                }
            ]
        }
