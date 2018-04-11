<%
    isStakeholder = 'itemType' in cstruct and cstruct['itemType'] == 'stakeholders'
    geomChanged = cstruct['geomchange'] if 'geomchange' in cstruct else False

    from pyramid.security import ACLAllowed
    from pyramid.security import has_permission
    isModerator = isinstance(has_permission('moderate', request.context, request), ACLAllowed)

    ## TODO: workaround use placeholder geometry | dirctly access code from python?

    print('VARIABLE GEOMETRY', geometry);

##     # load geometry
##     import colander
## ##     import pdb; pdb.set_trace()
##     print('CSTRUCT') # cstruct form customMapMapping only contains geometry! ## TODO: get parameters from cstruct
##     print(cstruct)
##     #geometry = None if cstruct['geometry'] == colander.null else cstruct['geometry']


%>

<link rel="stylesheet" href="${request.static_url('lokp:static/css/leaflet.css')}">

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
                        <i class="icon-exclamation-sign ttip pointer" data-toggle="tooltip" data-tooltip="${_('There are changes in this section')}"></i>
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
                    <div class="map-floating-buttons" id="map-floating-buttons-googleMapNotFull">
                        <span class="range-field tooltipped" data-position="top" data-tooltip="${_('Transparency of context layers')}">
                          <input type="range" class="layer-transparency-slider" min="0" max="100" value="60"
                                 data-map-id="googleMapNotFull"/>
                        </span>
                        <a class="btn-floating tooltipped btn-large button-collapse" data-position="top"
                           data-tooltip="${_('Map Options')}" data-activates="slide-out-map-options-googleMapNotFull">
                            <i class="material-icons">map</i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </li>
</ul>
    

<div id="slide-out-map-options-googleMapNotFull" class="side-nav map-side-menu">

    ## Search

    <div class="row map-search-container">
        <div class="input-field col s11">
            <i class="material-icons prefix">search</i>
            <input id="js-map-search-googleMapNotFull" class="map-search-input" name="q" type="text">
        </div>
    </div>

    <ul class="collapsible" data-collapsible="accordion" data-map-id="googleMapNotFull">
        ## Deals

        <li>
            <div class="collapsible-header">
                <i class="material-icons">room</i>${_('Deals')}
            </div>
            <div class="collapsible-body">
                <form action="#" class="map-menu-form">
                    <input class="input-top js-activity-layer-toggle" type="checkbox"
                           id="activity-layer-toggle-googleMapNotFull" checked="checked">
                    <label class="text-primary-color" for="activity-layer-toggle-googleMapNotFull"
                           style="line-height: 22px; height: 22px;" id="map-deals-symbolization-googleMapNotFull">
                        ## Current symbolization (dropdown and legend)
        </label>
                    <ul id="map-points-list-googleMapNotFull" class="map-legend-points-symbols">
                        ## Points legend
        </ul>
                    <div id="map-polygons-list-googleMapNotFull">
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
                        <input class="with-gap js-base-map-layers" name="map-base-layers-googleMapNotFull"
                               type="radio"
                               id="satelliteMapOption-googleMapNotFull" value="satelliteMap" checked="checked"/>
                        <label for="satelliteMapOption-googleMapNotFull">${_('Google Earth satellite images')}</label>
                    </p>
                    <p>
                        <input class="with-gap js-base-map-layers" name="map-base-layers-googleMapNotFull"
                               type="radio"
                               id="esriSatelliteMapOption-googleMapNotFull" value="esriSatellite"/>
                        <label for="esriSatelliteMapOption-googleMapNotFull">${_('ESRI World Imagery')}</label>
                    </p>
                    <p>
                        <input class="with-gap js-base-map-layers" name="map-base-layers-googleMapNotFull"
                               type="radio"
                               id="terrainMapOption-googleMapNotFull" value="terrainMap"/>
                        <label for="terrainMapOption-googleMapNotFull">${_('Google Terrain Map')}</label>
                    </p>
                    <p>
                        <input class="with-gap js-base-map-layers" name="map-base-layers-googleMapNotFull"
                               type="radio"
                               id="streetMapOption-googleMapNotFull" value="streetMap"/>
                        <label for="streetMapOption-googleMapNotFull">${_('OpenStreetMap')}</label>
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
                <form action="#" id="context-layers-list-googleMapNotFull">
                    ## Context layers entries
      </form>
            </div>
        </li>
    </ul>
</div>


<script type="text/javascript" src="//maps.googleapis.com/maps/api/js?v=3&key=${str(request.registry.settings.get('lokp.google_maps_api_key'))}&libraries=places"></script>
<script src="${request.static_url('lokp:static/js/maps/compare.js')}" type="text/javascript"></script>
<script src="${request.static_url('lokp:static/lib/leaflet/leaflet.js')}" type="text/javascript"></script>
<script src="${request.static_url('lokp:static/lib/leaflet/leaflet.markercluster.js')}"
        type="text/javascript"></script>
<script src="${request.static_url('lokp:static/lib/leaflet/Leaflet.GoogleMutant.js')}"
        type="text/javascript"></script>
<script src="/app/view/map_variables.js" type="text/javascript"></script>
<script src="${request.static_url('lokp:static/lib/chroma/chroma.min.js')}" type="text/javascript"></script>
<script src="${request.static_url('lokp:static/js/maps2/base.js')}" type="text/javascript"></script>
<script src="${request.static_url('lokp:static/lib/jquery.cookie/jquery.cookie.min.js')}"
            type="text/javascript"></script>

    ## TODO: load dependencies over new widget
<script>
    $('document').ready(function(){
         console.log('geometry in compare', ${geometry | n})
         var geometry = ${geometry | n};
         console.log('form.mak');
         createReviewMap('googleMapNotFull', {pointsVisible: false, pointsCluster: true}, geometry);
    });
</script>

% endif

% for child in field:
    ${child.render_template(field.widget.readonly_item_template)}
% endfor
