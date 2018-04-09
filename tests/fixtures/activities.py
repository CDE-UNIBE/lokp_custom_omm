import pytest


@pytest.fixture(scope='class')
def activity_changeset(request):
    """
    The main function to provide changesets for Activities.

    Mark your test to use this fixture:
        @pytest.mark.usefixtures('activity_changeset')
    and within the test, get one of the changesets as follows:
        self.activity_changeset('<name>', [*args, **kwargs])
    """
    def get_changeset(r, changeset, *args, **kwargs):
        try:
            return getattr(ActivityChangesets, changeset)(*args, **kwargs)
        except AttributeError:
            raise Exception(
                'ActivityChangeset has no fixture called "{}"'.format(
                    changeset))

    request.cls.activity_changeset = get_changeset


class ActivityChangesets:

    @staticmethod
    def simple(intention='Agriculture'):
        """
        A simple Activity in Myanmar without Involvements.

        Spatial Accuracy:                   better than 100m
        Country:                            Myanmar
        Intention of Investment:            <intention> (default: Agriculture)
        Remark (Intention of Investment):   Remark about the intention
        Implementation status:              In operation
        """
        return {
            "activities": [
                {
                    "taggroups": [
                        {
                            "op": "add",
                            "tags": [
                                {
                                    "key": "Spatial Accuracy",
                                    "value": "better than 100m",
                                    "op": "add"
                                }
                            ],
                            "main_tag": {
                                "key": "Spatial Accuracy",
                                "value": "better than 100m"
                            }
                        },
                        {
                            "op": "add",
                            "tags": [
                                {
                                    "key": "Country",
                                    "value": "Myanmar",
                                    "op": "add"
                                }
                            ],
                            "main_tag": {
                                "key": "Country",
                                "value": "Myanmar"
                            }
                        },
                        {
                            "op": "add",
                            "tags": [
                                {
                                    "key": "Intention of Investment",
                                    "value": intention,
                                    "op": "add"
                                }
                            ],
                            "main_tag": {
                                "key": "Intention of Investment",
                                "value": intention
                            }
                        },
                        {
                            "op": "add",
                            "tags": [
                                {
                                    "key": "Remark (Intention of Investment)",
                                    "value": "Remark about the intention",
                                    "op": "add"
                                }
                            ],
                            "main_tag": {
                                "key": "Remark (Intention of Investment)",
                                "value": "Remark about the intention"
                            }
                        },
                        {
                            "op": "add",
                            "tags": [
                                {
                                    "key": "Implementation status",
                                    "value": "In operation",
                                    "op": "add"
                                }
                            ],
                            "main_tag": {
                                "key": "Implementation status",
                                "value": "In operation"
                            }
                        }
                    ],
                    "geometry": {
                        "type": "Point",
                        "coordinates": [96.64902734375207, 19.33434978562127]
                    },
                    "version": 1
                }
            ]
        }
