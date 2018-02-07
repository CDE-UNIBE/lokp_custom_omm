<%
    from lokp.views.filter import getFilterKeys
    from lokp.views.filter import getActiveFilters

    aFilterKeys, shFilterKeys = getFilterKeys(request)
    activeFilters = getActiveFilters(request)
%>

<%inherit file="lokp:customization/omm/templates/base.mak" />

<%def name="title()">${_('Map View')}</%def>

<%def name="head_tags()">
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.3.1/dist/leaflet.css"
        integrity="sha512-Rksm5RenBEKSKFjgI3a41vrjkw4EVPlJ3+OiI65vTjIdo9brlAacEuKOiQ5OFh7cOI1bkDwLqdLw3Zg0cRJAAQ=="
        crossorigin=""/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/1.3.0/MarkerCluster.css">
<script type="text/javascript">
<%
    from lokp.config.profile import get_current_profile_extent
    from lokp.config.customization import getOverviewKeys
    from lokp.views.filter import getFilterValuesForKey
    from lokp.views.map import getMapSymbolKeys
    from lokp.views.form import form_geomtaggroups
    import json

    aKeys, shKeys = getOverviewKeys(request)
    extent = json.dumps(get_current_profile_extent(request))
    geomTaggroups = form_geomtaggroups(request)

%>
    var profilePolygon = ${extent | n};
    var aKeys = ${json.dumps(aKeys) | n};
    var shKeys = ${json.dumps(shKeys) | n};
    var areaNames = ${json.dumps(geomTaggroups['mainkeys']) | n};

    ## JS Translation
    var tForDeals = '${_("Deal")}';
    var tForInvestor = '${_("Investor")}';
    var tForInvestors = '${_("Investors")}';
    var tForLegend = '${_("Legend")}';
    var tForLegendforcontextlayer = '${_("Legend for context layer")}';
    var tForLoading = '${_("Loading ...")}';
    var tForLoadingdetails = '${_("Loading the details ...")}';
    var tForMoredeals = '${_(" more deals ...")}';
    var tForNodealselected = '${_("No deal selected.")}';
    var tForSelecteddeals = '${_("Selected Deals")}';

</script>
</%def>
## Start of content

## Filter


<ul id="slide-out-map-options" class="side-nav" style="min-width: 550px; z-index: 1001;">
    <div class="row" style="margin: 10px 0px 0px 0px;">
        <div class="input-field col s11" action="">
            <i class="material-icons prefix">search</i>
            <input id="js-map-search" name="q" type="text" style="height: 20px; line-height: 20px;">
        </div>
    </div>

    <ul class="collapsible" data-collapsible="accordion" data-map-id="googleMapFull">
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
                      <input class="with-gap baseMapOptions" name="baseMapOptions" type="radio" id="satelliteMapOption" value="satelliteMap" checked="checked" />
                      <label for="satelliteMapOption">${_('Google Earth satellite images')}</label>
                    </p>
                    <p style="padding-top: 0; padding-bottom: 0;">
                      <input class="with-gap baseMapOptions" name="baseMapOptions" type="radio" id="esriSatelliteMapOption" value="esriSatellite" />
                      <label for="esriSatelliteMapOption">${_('ESRI World Imagery')}</label>
                    </p>
                    <p style="padding-top: 0; padding-bottom: 0;">
                      <input class="with-gap baseMapOptions" name="baseMapOptions" type="radio" id="terrainMapOption" value="terrainMap" />
                      <label for="terrainMapOption">${_('Google Terrain Map')}</label>
                    </p>
                    <p style="padding-top: 0; padding-bottom: 0;">
                      <input class="with-gap baseMapOptions" name="baseMapOptions" type="radio" id="streetMapOption" value="streetMap"/>
                      <label for="streetMapOption">${_('OpenStreetMap')}</label>
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

<ul id="slide-out-filter" class="side-nav" style="min-width: 550px; z-index: 1001;">
    <%include file="lokp:customization/omm/templates/parts/filter.mak" />
</ul>

<!-- content -->
<div class="row" style="margin: 0 !important;">
    <div id="window_left"  class="col s12 m12 l8">
        <div id="googleMapFull">
        <!--  Placeholder for the map -->
        </div>
        <div class="preloader-wrapper big active" style="position: fixed; top: 50%;">
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
        <div id="floating-buttons" style="text-align: right;">
            <span class="range-field tooltipped" data-position="top" data-tooltip="${_('Transparency of context layers')}">
              <input type="range" id="layer-transparency-slider" min="0" max="100" value="60" data-map-id="googleMapFull" />
            </span>
            <a class="btn-floating tooltipped btn-large button-collapse" style="margin-right: 15px;" data-position="top" data-tooltip="Map Options" data-activates="slide-out-map-options">
                <i class="material-icons">map</i>
            </a>
            <a class="btn-floating tooltipped btn-large button-collapse" style="margin-right: 15px;" data-position="top" data-tooltip="Add a Filter" data-activates="slide-out-filter">
                <i class="material-icons" style="margin-right: 15px;" data-position="top" >filter_list</i>
            </a>
            % if len(activeFilters) == 1:
                <span class="badge" style="color: white; background-color: #323232; position: relative; top: -25px; left: -40px; z-index: 1; border-radius: 5px;">${len(activeFilters)} active filter</span>
            % else:
                <span class="badge" style="color: white; background-color: #323232; position: relative; top: -25px; left: -40px; z-index: 1; border-radius: 5px;">${len(activeFilters)} active filters</span>
            % endif
        </div>
    </div>
    <div id="window_right" class="col s12 m12  l4">

        <div id="window-right-top" style="height: 50%;">
            <ul class="tabs" style="overflow-x: hidden;">
                <li class="tab col s3"><a href="#tab1" class="active text-accent-color">Preview of deal</a></li>
                <li class="tab col s3"><a href="#tab2" class="text-accent-color">News</a></li>
            </ul>
            <div id="tab1" class="col s12" style="padding: 30px;">
                <div class="deal-data">
                    <h5 class="deal-headline">${_('Deal')}
                        <span id="deal-shortid-span" class="underline">#</span>
                    </h5>
                    <ul id="taggroups-ul" class="text-primary-color">
                        <li>
                            <p>${_('Select a deal on the map to show details. If you select multiple deals, zoom in and use the list view to show the details.')}</p>
                        </li>
                    </ul>
                </div>
                <div class="deal-data-footer" style="font-size: 12px; margin-top: 10px;">
                </div>
            </div>
            <div id="tab2" class="col s12" style="padding: 30px; overflow-y: auto; height: 80%;">
                <div id="newscontent"></div>
            </div>
        </div>
        <div id="window-right-bottom" style="height: 50%;">
            <ul class="tabs" style="overflow-x: hidden;">
                <li class="tab col s3"><a href="#bottom-tab1" class="active text-accent-color">Picture of the week</a></li>
                <li class="tab col s3"><a href="#bottom-tab2" class="text-accent-color">Archive</a></li>
            </ul>
            <div id="bottom-tab1" class="col s12 potw" style="text-align: center; height: 100%; margin: 0;"></div>
            <div id="bottom-tab2" class="col s12 potw-archive" style="padding: 30px; overflow-y: auto; height: 80%;"></div>
        </div>
    </div>
</div>

<!-- map menu -->
<div class="map-menu" style="display: none;">
    <div id="map-menu-button-container">
        <h6 id="map-menu-button">
            <i class="icon-chevron-up"></i>
            ${_("Map options")}
        </h6>
    </div>
    <div id="map-menu-container" class="hide">
        <form class="navbar-search" action="">
            <input name="q" id="js-map-search" class="search-query" placeholder="${_('search location')}" />
            <input value="Search" id="search-submit" />
        </form><br/>

        <!-- Deals -->
        <div class="map-menu-deals">
            <h6 class="map-deals">
                <i class="icon-chevron-down"></i>
                ${_('Deals')}
            </h6>
            <div class="map-deals-content">
                <ul>
                    <li>
                        <div class="checkbox-modified-small">
                            <input class="input-top" type="checkbox" id="activityLayerToggle" checked="checked">
                            <label for="activityLayerToggle"></label>
                        </div>

                        <div id="map-deals-symbolization" class="dropdown context-layers-description">
                            ${_('Loading ...')}
                        </div>
                        <ul id="map-points-list">
                            <!-- Placeholder for map points -->
                        </ul>
                    </li>
                </ul>
                <ul id="map-areas-list">
                    <!-- Placeholder for area entries -->
                </ul>
            </div>
        </div>

        <!-- Base layers -->
        <div class="map-menu-base-layers">
            <h6 class="base-layers">
                <i class="icon-chevron-right"></i>
                ${_('Base layers')}
            </h6>
            <div class="base-layers-content">
                <ul>
                    <li>
                        <label class="radio inline"><input type="radio" class="baseMapOptions" name="baseMapOptions" id="streetMapOption" value="streetMap" checked />${_('Street Map')}</label>
                    </li>
                    <li>
                        <label class="radio inline"><input type="radio" class="baseMapOptions" name="baseMapOptions" id="satelliteMapOption" value="satelliteMap" />${_('Satellite Imagery')}</label>
                    </li>
                    <li>
                        <label class="radio inline"><input type="radio" class="baseMapOptions" name="baseMapOptions" id="terrainMapOption" value="terrainMap" />${_('Terrain Map')}</label>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Context layers -->
        <div class="map-menu-context-layers">
            <h6 class="context-layers">
                <i class="icon-chevron-right"></i>
                ${_('Context layers')}
            </h6>
            <div class="context-layers-content">
                <ul id="context-layers-list">
                    <!--  Placeholder for context layers entries -->
                </ul>
            </div>
        </div>
    </div>
</div>

## End of content

<div id="mapModal" class="modal">
    <div id="mapModalBody" class="modal-content">
        <!-- Placeholder -->
    </div>
    <div class="modal-footer">
        <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">${_('Close')}</a>
    </div>
</div>

<%def name="bottom_tags()">
<script type="text/javascript" src="//maps.google.com/maps/api/js?v=3&amp;key=${str(request.registry.settings.get('lokp.google_maps_api_key'))}&libraries=places"></script>
<script src="https://unpkg.com/leaflet@1.3.1/dist/leaflet.js"
        integrity="sha512-/Nsx9X4HebavoBvEBuyp3I7od5tA0UzAxs+j83KgC8PU0kgB4XiK4Lfe4y4cgBtaRJQEIFCW+oC506aPT2L1zw=="
        crossorigin=""></script>
<script src='https://unpkg.com/leaflet.gridlayer.googlemutant@latest/Leaflet.GoogleMutant.js'></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/1.3.0/leaflet.markercluster.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/chroma-js/1.3.6/chroma.min.js"></script>
## <script type="text/javascript" src="${request.route_url('context_layers')}"></script>
<script type="text/javascript" src="${request.route_url('map_variables')}"></script>
<script src="${request.static_url('lokp:static/js/maps2/base.js')}" type="text/javascript"></script>
<script src="${request.static_url('lokp:static/js/maps2/main.js')}" type="text/javascript"></script>
<script src="${request.static_url('lokp:static/js/filters.js')}" type="text/javascript"></script>
<script src="${request.static_url('lokp:static/lib/jquery.cookie/jquery.cookie.min.js')}" type="text/javascript"></script>
<script src="/custom/js/news.js"></script>
<script src="/custom/js/potw.js"></script>
</%def>
