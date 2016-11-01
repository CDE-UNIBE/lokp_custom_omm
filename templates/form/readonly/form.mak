<%
    isStakeholder = 'itemType' in cstruct and cstruct['itemType'] == 'stakeholders'
    statusId = cstruct['statusId'] if 'statusId' in cstruct else '2'
    empty = cstruct['taggroup_count'] == '0'

    from pyramid.security import ACLAllowed
    from pyramid.security import has_permission
    isModerator = isinstance(has_permission('moderate', request.context, request), ACLAllowed)
    _ = request.translate

    if isStakeholder:
        routeName = 'stakeholders_read_one'
        historyRouteName = 'stakeholders_read_one_history'
        editLinkText = _('Edit this Investor')
        deleteLinkText = _('Delete this Investor')
        deleteConfirmText = _('Are you sure you want to delete this Investor?')
        form_id = 'stakeholderform'
    else:
        routeName = 'activities_read_one'
        historyRouteName = 'activities_read_one_history'
        editLinkText = _('Edit this Deal')
        deleteLinkText = _('Delete this Deal')
        deleteConfirmText = _('Are you sure you want to delete this Deal?')
        form_id = 'activityform'
%>

% if statusId != '2':
    <div class="row-fluid">
        <div class="span12 alert alert-block">
            % if statusId == '1':
                ## Pending
                <h4>${_('Pending Version')}</h4>
                <p>${_('You are seeing a pending version which needs to be reviewed before it is publicly visible.')}</p>
            % elif statusId == '3':
                ## Inactive
                <h4>${_('Inactive Version')}</h4>
                <p>${_('You are seeing an inactive version which is not active anymore.')}</p>
            % else:
                ## All the rest (deleted, rejected, edited).
                ## TODO: Should there be a separate messages for these statuses?
                <h4>${_('Not an active Version')}</h4>
                <p>${_('You are seeing a version which is not active.')}</p>
            % endif
        </div>
    </div>
% endif

${editToolbar('top')}

<div class="row-fluid">
    <div class="span12">
        <h3 class="form-below-toolbar">
        % if isStakeholder:
            ${_('Investor Details')}
        % else:
            ${_('Deal Details')}
        % endif
        </h3>
    </div>
</div>
<div class="row-fluid">
    % if 'id' in cstruct:
        <div class="span12">
            <p class="id">${cstruct['id']}</p>
        </div>
    % endif
</div>

<ul id="slide-out-map-options" class="side-nav" style="min-width: 550px;">
    <ul class="collapsible" data-collapsible="accordion">
        <!-- Deals -->
        <li>
            <div class="collapsible-header"><i class="material-icons">group</i>${_('Deals')}</div>
            <div class="collapsible-body">
                <form action="#" id="map-areas-list">
                    <p style="padding-top: 0; padding-bottom: 0; margin: 0;">
                        <input class="input-top" type="checkbox" id="activityLayerToggle" checked="checked" style="line-height: 22px; height: 22px; background-color: red;">
                        <label class="text-primary-color" for="activityLayerToggle" style="line-height: 22px; height: 22px;">
                            <span id="map-deals-symbolization">

                            </span>
                        </label>
                        <ul id="map-points-list" style="margin: 0; padding: 0; padding-left: 100px;">
                        <!-- Placeholder for map points -->
                        </ul>
                    </p>
                </form>
            </div>
        </li>


        <!-- Base layers -->
        <li>
            <div class="collapsible-header"><i class="material-icons">map</i>${_('Base layers')}</div>
            <div class="collapsible-body">
                <form action="#">
                    <p style="padding-top: 0; padding-bottom: 0;">
                      <input class="with-gap baseMapOptions" name="baseMapOptions" type="radio" id="streetMapOption" value="streetMap" checked/>
                      <label for="streetMapOption">${_('Street Map')}</label>
                    </p>
                    <p style="padding-top: 0; padding-bottom: 0;">
                      <input class="with-gap baseMapOptions" name="baseMapOptions" type="radio" id="satelliteMapOption" value="satelliteMap" />
                      <label for="satelliteMapOption">${_('Satellite Imagery')}</label>
                    </p>
                    <p style="padding-top: 0; padding-bottom: 0;">
                      <input class="with-gap baseMapOptions" name="baseMapOptions" type="radio" id="terrainMapOption" value="terrainMap" />
                      <label for="terrainMapOption">${_('Terrain Map')}</label>
                    </p>
                </form>
            </div>
        </li>
        <!-- Context layers -->
        <li>
            <div class="collapsible-header"><i class="material-icons">layers</i>${_('Context layers')}</div>
            <div class="collapsible-body">
                <form action="#" id="context-layers-list">
                    <!--  Placeholder context layer entries -->
                </form>
            </div>
        </li>
    </ul>
</ul>


% if not isStakeholder and not empty:
    ## Map container
    <div class="row-fluid">
        <div class="span12 map-not-whole-page">
            <div id="googleMapNotFull">
                <div class="map-form-controls">
                    <div class="form-map-menu pull-right">
                        <a class="btn-floating tooltipped btn-large button-collapse" style="margin-right: 15px; margin-top: 15px;" data-position="top" data-tooltip="${_('Turn layers on and off')}" data-activates="slide-out-map-options">
                            <i class="material-icons">map</i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
% endif

% for child in field:
    ${child.render_template(field.widget.readonly_item_template)}
% endfor

% if empty:
    <div class="empty-details">
        ${_('This version does not have any attributes to show.')}
    </div>
% endif

${editToolbar('bottom')}

<%def name="editToolbar(position)">
<div class="row-fluid">
  <div class="span12 text-right deal-${position}-toolbar">
    <ul class="inline item-toolbar">
      <li>
        <a class="text-accent-color right" href="${request.route_url(historyRouteName, output='html', uid=cstruct['id'])}"><i class="icon-time"></i><span class="link-with-icon">${_('History')}</span></a>
      </li>
      % if not isStakeholder:
        <li>
          <a  class="text-accent-color right"href="${request.route_url(routeName, output='statistics', uid=cstruct['id'])}"><i class="icon-bar-chart"></i><span class="link-with-icon">${_("Areal statistics")}</span><span class="dealview_seperator"span>|</span></a>
        </li>
      % endif
      % if request.user and 'id' in cstruct and not empty:
        <li>
          <a  class="text-accent-color right"href="${request.route_url(routeName, output='form', uid=cstruct['id'], _query=(('v', cstruct['version']),))}"><i class="icon-pencil"></i><span class="link-with-icon">${editLinkText}</span></a>
        </li>
        <li>
          <a  class="text-accent-color right"href="javascript:void(0);" data-toggle="collapse" data-target="#delete-${form_id}-${position}"><i class="icon-trash"></i><span class="link-with-icon">${deleteLinkText}</span></a>
        </li>
      % endif
      % if request.user and isModerator and statusId == '1':
        <li>
          <a  class="text-accent-color right"href="${request.route_url(routeName, output='review', uid=cstruct['id'])}"><i class="icon-check"></i><span class="link-with-icon">${_('Review')}</span></a>
        </li>
      % endif
    </ul>
  </div>
</div>
% if request.user and 'id' in cstruct:
  <div id="delete-${form_id}-${position}" class="collapse">
    <form id="${form_id}-${position}" class="delete-confirm alert alert-error" action="${request.route_url(routeName, output='form', uid=cstruct['id'])}" method="POST">
      <input type="hidden" name="__formid__" value="${form_id}"/>
      <input type="hidden" name="id" value="${cstruct['id']}"/>
      <input type="hidden" name="version" value="${cstruct['version']}"/>
      <p>${deleteConfirmText}</p>
      <button name="delete" class="btn btn-small btn-danger">${_('Delete')}</button>
      <button onclick="javascript:console.log($('#delete-${form_id}-${position}')); $('#delete-${form_id}-${position}').collapse('hide'); return false;" class="btn btn-small delete-confirm-cancel">${_('Cancel')}</button>
    </form>
  </div>
% endif
</%def>
