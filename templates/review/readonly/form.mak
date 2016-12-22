<%
    isStakeholder = 'itemType' in cstruct and cstruct['itemType'] == 'stakeholders'
    geomChanged = cstruct['geomchange'] if 'geomchange' in cstruct else False
    
    from pyramid.security import ACLAllowed
    from pyramid.security import has_permission
    isModerator = isinstance(has_permission('moderate', request.context, request), ACLAllowed)
%>

% if not isStakeholder:
## Map container
<ul class="row comparemapcontainer collapsible">
<li>

            <%
             cls = 'collapsible-header category row'
             clsBody = 'row collapsible-body collapse'
             chevronClass = 'expand_more'
             if geomChanged == 'change':
                cls += ' change'
                clsBody += ' in'
                chevronClass = 'expand_less'
            %>

            <div class="${cls}" id="form-map-compare-heading">
                <div class="col s12 compareviewmapcollapsetitle">
                    % if geomChanged == 'change':
                        <i class="icon-exclamation-sign ttip pointer" data-toggle="tooltip" data-original-title="${_('There are changes in this section')}"></i>
                    % endif
                    <a class="accordion-toggle text-accent-color" data-toggle="collapse" href="#collapse-map">
                        ${_('Map')}
                        <i class="material-icons text-accent-color right">${chevronClass}</i>
                    </a>
                </div>
            </div>

        <ul id="slide-out-map-options" class="side-nav" style="min-width: 550px; z-index: 10000;">
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

        <div class="row-fluid">
            <div id="collapse-map" class="span12 map-not-whole-page">
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
    </li>
</ul>
% endif

% for child in field:
    ${child.render_template(field.widget.readonly_item_template)}
% endfor
