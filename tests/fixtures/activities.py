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
            return getattr(ActivityChangesets(), changeset)(*args, **kwargs)
        except AttributeError:
            raise Exception(
                'ActivityChangeset has no fixture called "{}"'.format(
                    changeset))

    request.cls.activity_changeset = get_changeset


class ActivityChangesets:

    @staticmethod
    def simple(intention='Agriculture', coordinates=None, intended_area=None):
        """
        A simple Activity in Myanmar without Involvements.

        [coordinates]:                      default: ~ center of Myanmar
        Spatial Accuracy:                   better than 100m
        Country:                            Myanmar
        Intention of Investment:            <intention> (default: Agriculture)
        Remark (Intention of Investment):   Remark about the intention
        Implementation status:              In operation
        Intended area:                      - (empty by default)
        """
        if not coordinates:
            coordinates = [96.64902734375207, 19.33434978562127]
        taggroups = [
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
        ]
        if intended_area:
            taggroups.append({
                "op": "add",
                "tags": [
                    {
                        "key": "Intended area (ha)",
                        "value": intended_area,
                        "op": "add"
                    }
                ],
                "main_tag": {
                    "key": "Intended area (ha)",
                    "value": intended_area
                }
            })

        return {
            "activities": [
                {
                    "taggroups": taggroups,
                    "geometry": {
                        "type": "Point",
                        "coordinates": coordinates
                    },
                    "version": 1
                }
            ]
        }

    def linked(self, stakeholders: list):
        # Basically the simple activity (see above) with links to the
        # stakeholders specified
        activity = self.simple()
        role_mapping = {
            'primary': '6',
        }
        linked_stakeholders = []
        for identifier, role in stakeholders:
            linked_stakeholders.append({
                "id": identifier,
                "version": 1,
                "role": role_mapping[role],
                "op": "add"
            })
        activity['activities'][0]['stakeholders'] = linked_stakeholders
        return activity

    def polygon(self):
        # The simple activity (see above) with a rectangular polygon for
        # "Intended area"
        activity = self.simple()
        activity['activities'][0]['taggroups'].append({
            "op": "add",
            "tags": [
                {
                    "key": "Intended area (ha)",
                    "value": 123.0,
                    "op": "add"
                }, {
                    "key": "map",
                    "value": {
                        "geometry": "{\"type\":\"Polygon\",\"coordinates\":[[[95.935567,21.930944],[95.935567,20.90821],[97.0337,20.90821],[97.0337,21.930944],[95.935567,21.930944]]]}"
                    },
                    "op": "add"
                }
            ],
            "main_tag": {
                "key": "Intended area (ha)",
                "value": 123.0
            },
            "geometry": "{\"type\":\"Polygon\",\"coordinates\":[[[95.935567,21.930944],[95.935567,20.90821],[97.0337,20.90821],[97.0337,21.930944],[95.935567,21.930944]]]}"
        })
        return activity
