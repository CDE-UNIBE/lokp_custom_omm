<%doc>
  This template renders short details of one or more activities selected on the
  map.

  Available context variables:
  - activity_list: A list of tuples with
      [0] activity_dict:
        contains the keys marked with "mapdetail: true" in the activity yaml and
        the corresponding values
      [1] stakeholder_list:
        contains a list of dicts (similar to activity_dict) for each involved
        stakeholder
    for each activity.
  - additional_activities: An integer indicating if there are additional
    activities for which the details are not displayed
</%doc>

<%!
  def comma_list(the_list):
    return ', '.join(the_list)

  def thousand_separator(number):
    return '{0:,}'.format(float(number))
%>

<div class="map-deal-data
  % if len(activity_list) > 1:
      map-deal-data-multiple
  % endif
">
% if len(activity_list) > 1:
  <h5 class="deal-headline text-primary-color">Selected Deals</h5>
% endif
  % for activity_dict, stakeholder_list in activity_list:
    <h5 class="deal-headline map-deal-data-headline">Deal
      <a class="map-deal-data-id" href="${request.route_url('activities_read_one', output='html', uid=activity_dict['identifier'])}">
        # ${activity_dict['short_identifier']}
      </a>
    </h5>
    <ul>
      % if 'Intention of Investment' in activity_dict:
        <li>
          <p>
            <span class="bolder">Intention of Investment:</span> ${comma_list(activity_dict['Intention of Investment'])}
          </p>
        </li>
      % endif
      % if 'Intended area (ha)' in activity_dict:
        <li>
          <p>
            <span class="bolder">Intended area (ha)</span> ${thousand_separator(activity_dict['Intended area (ha)'][0])}
          </p>
        </li>
      % endif
      % if 'Crop' in activity_dict:
        <li>
          <p>
            <span class="bolder">Crops:</span> ${comma_list(activity_dict['Crop'])}
          </p>
        </li>
      % endif
      % if stakeholder_list:
          <li>
            <p>
              <span class="bolder">Investors:</span>
              % for stakeholder in stakeholder_list:
                ${comma_list(stakeholder['Name'])}, ${comma_list(stakeholder['Country of origin'])}
                % if not loop.last:
                  ,
                % endif
              % endfor
            </p>
          </li>
      % endif
    </ul>
  % endfor
</div>
<div class="map-deal-data-footer">
  % if additional_activities > 0:
    <span>... and ${additional_activities} more deals ...</span>
  % endif
</div>
