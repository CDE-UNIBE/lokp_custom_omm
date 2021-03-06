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

## include google maps api key
<script type="text/javascript"
            src="//maps.google.com/maps/api/js?v=3&key=${str(request.registry.settings.get('lokp.google_maps_api_key'))}&libraries=places"></script>

% if statusId != '2':
    <div class="row">
        <div class="col s12 alert alert-info card-panel accent-background-color white-text">
            % if statusId == '1':
            ## Pending
                <h5>${_('Pending Version')}</h5>
                <p>${_('You are seeing a pending version which needs to be reviewed before it is publicly visible.')}</p>
            % elif statusId == '3':
            ## Inactive
                <h5>${_('Inactive Version')}</h5>
                <p>${_('You are seeing an inactive version which is not active anymore.')}</p>
            % else:
            ## All the rest (deleted, rejected, edited).
                ## TODO: Should there be a separate messages for these statuses?
                <h5>${_('Not an active Version')}</h5>
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

<ul id="slide-out-map-options" class="side-nav" style="min-width: 550px; z-index: 10000;">
    <ul class="collapsible" data-collapsible="accordion">
        <!-- Deals -->
        <li>
            <div class="collapsible-header"><i class="material-icons">group</i>${_('Deals')}</div>
            <div class="collapsible-body">
                <form action="#" id="map-areas-list">
                    <p style="padding-top: 0; padding-bottom: 0; margin: 0;">
                        <input class="input-top" type="checkbox" id="activityLayerToggle" checked="checked"
                               style="line-height: 22px; height: 22px; background-color: red;">
                        <label class="text-primary-color" for="activityLayerToggle"
                               style="line-height: 22px; height: 22px;">
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
    </ul>
</ul>


% if not isStakeholder and not empty:
    ## Map container

    <div id="mapDetailsPage" style="height: 400px;">
        ## Loading indicator

        <div class="preloader-wrapper big active map-loader" data-map-id="mapDetailsPage">
            <div class="spinner-layer spinner-teal-only">
                <div class="circle-clipper left">
                    <div class="circle"></div>
                </div>
                <div class="gap-patch">
                    <div class="circle"></div>
                </div>
                <div class="circle-clipper right">
                    <div class="circle"></div>
                </div>
            </div>
        </div>

        ## create buttons Map options and filter.

        <div class="map-floating-buttons" id="map-floating-buttons-mapDetailsPage">
        <span class="range-field tooltipped" data-position="top" data-tooltip="${_('Transparency of context layers')}">
          <input type="range" class="layer-transparency-slider" min="0" max="100" value="60"
                 data-map-id="mapDetailsPage"/>
        </span>
            <a class="btn-floating tooltipped btn-large button-collapse" data-position="top"
               data-tooltip="${_('Map Options')}" data-activates="slide-out-map-options-mapDetailsPage">
                <i class="material-icons">map</i>
            </a>
##             <a class="btn-floating tooltipped btn-large button-collapse" data-position="top"
##                data-tooltip="${_('Add a Filter')}" data-activates="slide-out-filter-mapDetailsPage">
##                 <i class="material-icons" style="margin-right: 15px;" data-position="top">filter_list</i>
##             </a>

        </div>

        ## Manages green layer button

        <%doc>    <div class="map-form-controls">

                % if editmode == 'multipoints':
                    <div class="form-map-edit pull-right">
                        <div class="btn-group pull-right" data-toggle="buttons-radio">
                            <a class="btn btn-mini active ttip" id="btn-add-point" data-toggle="tooltip"
                               title="${_('Add a location to the map')}"><i class="icon-plus"></i></a>
                            <a class="btn btn-mini ttip" id="btn-remove-point" data-toggle="tooltip"
                               title="${_('Remove a location from the map')}"><i class="icon-minus"></i></a>
                            <a class="btn btn-mini btn-danger disabled ttip disableClick"><i class="icon-pencil"></i></a>
                        </div>
                    </div>
                % endif

                <div class="form-map-menu pull-right">
                    <a class="btn-floating tooltipped btn-large button-collapse" style="margin-right: 15px; margin-top: 15px;"
                       data-position="top" data-tooltip="${_('Turn layers on and off')}" data-activates="slide-out-map-options">
                        <i class="material-icons">map</i>
                    </a>
                </div>
            </div></%doc>
    </div>

    ## Map Menu (code is rendered within a slider once the button 'Map options' is clicked)

    <div id="slide-out-map-options-mapDetailsPage" class="side-nav map-side-menu">

        ## Search

        <div class="row map-search-container">
            <div class="input-field col s11">
                <i class="material-icons prefix">search</i>
                <input id="js-map-search-mapDetailsPage" class="map-search-input" name="q" type="text">
            </div>
        </div>

        <ul class="collapsible" data-collapsible="accordion" data-map-id="mapDetailsPage">
            ## Deals

            <li>
                <div class="collapsible-header">
                    <i class="material-icons">room</i>${_('Deals')}
                </div>
                <div class="collapsible-body">
                    <form action="#" class="map-menu-form">
                        <input class="input-top js-activity-layer-toggle" type="checkbox"
                               id="activity-layer-toggle-mapDetailsPage" checked="checked">
                        <label class="text-primary-color" for="activity-layer-toggle-mapDetailsPage"
                               style="line-height: 22px; height: 22px;" id="map-deals-symbolization-mapDetailsPage">
                            ## Current symbolization (dropdown and legend)
            </label>
                        <ul id="map-points-list-mapDetailsPage" class="map-legend-points-symbols">
                            ## Points legend
            </ul>
                        <div id="map-polygons-list-mapDetailsPage">
                            ## Polygon list
            </div>
                    </form>
                </div>
            </li>

            ## Base layers

            <li>
                <div class="collapsible-header">
                    <i class="material-icons">map</i>${_('Base layers')}
                </div>
                <div class="collapsible-body">
                    <form action="#" class="map-base-layer-entries">
                        <p>
                            <input class="with-gap js-base-map-layers" name="map-base-layers-mapDetailsPage"
                                   type="radio"
                                   id="satelliteMapOption-mapDetailsPage" value="satelliteMap" checked="checked"/>
                            <label for="satelliteMapOption-mapDetailsPage">${_('Google Earth satellite images')}</label>
                        </p>
                        <p>
                            <input class="with-gap js-base-map-layers" name="map-base-layers-mapDetailsPage"
                                   type="radio"
                                   id="esriSatelliteMapOption-mapDetailsPage" value="esriSatellite"/>
                            <label for="esriSatelliteMapOption-mapDetailsPage">${_('ESRI World Imagery')}</label>
                        </p>
                        <p>
                            <input class="with-gap js-base-map-layers" name="map-base-layers-mapDetailsPage"
                                   type="radio"
                                   id="terrainMapOption-mapDetailsPage" value="terrainMap"/>
                            <label for="terrainMapOption-mapDetailsPage">${_('Google Terrain Map')}</label>
                        </p>
                        <p>
                            <input class="with-gap js-base-map-layers" name="map-base-layers-mapDetailsPage"
                                   type="radio"
                                   id="streetMapOption-mapDetailsPage" value="streetMap"/>
                            <label for="streetMapOption-mapDetailsPage">${_('OpenStreetMap')}</label>
                        </p>
                    </form>
                </div>
            </li>

            ## Context layers

            <li>
                <div class="collapsible-header">
                    <i class="material-icons">layers</i>${_('Context layers')}
                </div>
                <div class="collapsible-body">
                    <form action="#" id="context-layers-list-mapDetailsPage">
                        ## Context layers entries
          </form>
                </div>
            </li>
        </ul>
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
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

<%def name="editToolbar(position)">
    <div class="row-fluid" style="margin-bottom: 30px;">
        <div class="span12 text-right deal-${position}-toolbar">
            <ul class="inline item-toolbar">
                <li>
                    <a class="text-accent-color right"
                       href="${request.route_url(historyRouteName, output='html', uid=cstruct['id'])}"><i
                            class="icon-time"></i><span class="link-with-icon">${_('History')}</span></a>
                </li>
                % if not isStakeholder:
                    <li style="margin-left: 10px;">
                        <a class="text-accent-color right"
                           href="${request.route_url(routeName, output='statistics', uid=cstruct['id'])}"><i
                                class="icon-bar-chart" style="margin-left: 10px;"></i><span
                                class="link-with-icon">${_("Areal statistics")}</span><span class="dealview_seperator"
                                                                                            span>|</span></a>
                    </li>
                % endif
                % if request.user and 'id' in cstruct and not empty:
                    <li style="margin-left: 10px;">
                        <a class="text-accent-color right"
                           href="${request.route_url(routeName, output='form', uid=cstruct['id'], _query=(('v', cstruct['version']),))}"><i
                                class="icon-pencil" style="margin-left: 10px;"></i><span
                                class="link-with-icon">${editLinkText}</span></a>
                    </li>
                    <li style="margin-left: 10px;">
                        <a class="text-accent-color right" href="javascript:void(0);"
                           onclick='$( "#delete-${form_id}-${position}" ).show();'><i class="icon-trash"
                                                                                      style="margin-left: 10px;"></i><span
                                class="link-with-icon">${deleteLinkText}</span></a>
                    </li>
                % endif
                % if request.user and isModerator and statusId == '1':
                    <li style="margin-left: 10px;">
                        <a class="text-accent-color right"
                           href="${request.route_url(routeName, output='review', uid=cstruct['id'])}"><i
                                class="icon-check"></i><span class="link-with-icon">${_('Review')}</span></a>
                    </li>
                % endif
            </ul>
        </div>
    </div>
    % if request.user and 'id' in cstruct:
        <div id="delete-${form_id}-${position}" style="display: none; margin-top: 50px;">
            <form id="${form_id}-${position}" class="delete-confirm alert alert-error"
                  action="${request.route_url(routeName, output='form', uid=cstruct['id'])}" method="POST">
                <input type="hidden" name="__formid__" value="${form_id}"/>
                <input type="hidden" name="id" value="${cstruct['id']}"/>
                <input type="hidden" name="version" value="${cstruct['version']}"/>
                <p>${deleteConfirmText}</p>
                <button name="delete" class="btn red">${_('Delete')}</button>
                <button onclick="this.parentNode.parentNode.style.display = 'none';"
                        class="btn grey delete-confirm-cancel">${_('Cancel')}</button>
            </form>
        </div>
    % endif
</%def>



<script>
    $('document').ready(function () {
        createMap("mapDetailsPage", {
            pointsVisible: false,
            pointsCluster: true,
            readonly: true,
            dbLocationGeometry: geometry, // geometry and deal areas are passed from the server to js in mapform.mak
            dbDealAreas: dealAreas
        })
});


</script>
