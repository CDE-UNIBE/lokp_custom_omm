<%
    from lokp.views.filter import getFilterKeys
    from lokp.views.filter import getActiveFilters

    aFilterKeys, shFilterKeys = getFilterKeys(request)
    activeFilters = getActiveFilters(request)
%>

<%inherit file="lokp:customization/omm/templates/base.mak" />

<%def name="title()">${_('Map View')}</%def>

<%def name="head_tags()">
    <link rel="stylesheet" href="${request.static_url('lokp:static/lib/leaflet/leaflet.css')}"/>
    <link rel="stylesheet" href="${request.static_url('lokp:static/lib/leaflet/MarkerCluster.css')}">
</%def>

## Content

<div class="row" style="margin: 0 !important;">
    <div id="window_left" class="col s12 m12 l8">
        ## Map

        <div id="main-map-id" class="main-map">
            ## Loading indicator

            <div class="preloader-wrapper big active map-loader" data-map-id="main-map-id">
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
            ## Map buttons

            <div class="map-floating-buttons" id="map-floating-buttons-main-map-id">
        <span class="range-field tooltipped" data-position="top" data-tooltip="${_('Transparency of context layers')}">
          <input type="range" class="layer-transparency-slider" min="0" max="100" value="60" data-map-id="main-map-id"/>
        </span>
                <a class="btn-floating tooltipped btn-large button-collapse" data-position="top"
                   data-tooltip="${_('Map Options')}" data-activates="slide-out-map-options-main-map-id">
                    <i class="material-icons">map</i>
                </a>
                <a class="btn-floating tooltipped btn-large button-collapse" data-position="top"
                   data-tooltip="${_('Add a Filter')}" data-activates="slide-out-filter">
                    <i class="material-icons" style="margin-right: 15px;" data-position="top">filter_list</i>
                </a>
                % if len(activeFilters) == 1:
                    <span class="badge"
                          style="color: white; background-color: #323232; position: relative; top: -25px; left: -40px; z-index: 1; border-radius: 5px;">${len(activeFilters)}
                        active filter</span>
                % else:
                    <span class="badge"
                          style="color: white; background-color: #323232; position: relative; top: -25px; left: -40px; z-index: 1; border-radius: 5px;">${len(activeFilters)}
                        active filters</span>
                % endif
            </div>
        </div>
    </div>
    <div id="window_right" class="col s12 m12 l4">
        <div id="window-right-top" style="height: 50%;">
            ## Detail / News

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
                <li class="tab col s3"><a href="#bottom-tab1" class="active text-accent-color">Picture of the week</a>
                </li>
                <li class="tab col s3"><a href="#bottom-tab2" class="text-accent-color">Archive</a></li>
            </ul>
            <div id="bottom-tab1" class="col s12 potw" style="text-align: center; height: 100%; margin: 0;"></div>
            <div id="bottom-tab2" class="col s12 potw-archive"
                 style="padding: 30px; overflow-y: auto; height: 80%;"></div>
        </div>
    </div>
</div>

## Map Menu

<div id="slide-out-map-options-main-map-id" class="side-nav map-side-menu">

    ## Search

    <div class="row map-search-container">
        <div class="input-field col s11">
            <i class="material-icons prefix">search</i>
            <input id="js-map-search-main-map-id" class="map-search-input" name="q" type="text">
        </div>
    </div>

    <ul class="collapsible" data-collapsible="accordion" data-map-id="main-map-id">
        ## Deals

        <li>
            <div class="collapsible-header">
                <i class="material-icons">room</i>${_('Deals')}
            </div>
            <div class="collapsible-body">
                <form action="#" class="map-menu-form">
                    <input class="input-top js-activity-layer-toggle" type="checkbox"
                           id="activity-layer-toggle-main-map-id" checked="checked">
                    <label class="text-primary-color" for="activity-layer-toggle-main-map-id"
                           style="line-height: 22px; height: 22px;" id="map-deals-symbolization-main-map-id">
                        ## Current symbolization (dropdown and legend)
            </label>
                    <ul id="map-points-list-main-map-id" class="map-legend-points-symbols">
                        ## Points legend
            </ul>
                    <div id="map-polygons-list-main-map-id">
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
                        <input class="with-gap js-base-map-layers" name="map-base-layers-main-map-id" type="radio"
                               id="satelliteMapOption-main-map-id" value="satelliteMap" checked="checked"/>
                        <label for="satelliteMapOption-main-map-id">${_('Google Earth satellite images')}</label>
                    </p>
                    <p>
                        <input class="with-gap js-base-map-layers" name="map-base-layers-main-map-id" type="radio"
                               id="esriSatelliteMapOption-main-map-id" value="esriSatellite"/>
                        <label for="esriSatelliteMapOption-main-map-id">${_('ESRI World Imagery')}</label>
                    </p>
                    <p>
                        <input class="with-gap js-base-map-layers" name="map-base-layers-main-map-id" type="radio"
                               id="terrainMapOption-main-map-id" value="terrainMap"/>
                        <label for="terrainMapOption-main-map-id">${_('Google Terrain Map')}</label>
                    </p>
                    <p>
                        <input class="with-gap js-base-map-layers" name="map-base-layers-main-map-id" type="radio"
                               id="streetMapOption-main-map-id" value="streetMap"/>
                        <label for="streetMapOption-main-map-id">${_('OpenStreetMap')}</label>
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
                <form action="#" id="context-layers-list-main-map-id">
                    ## Context layers entries
          </form>
            </div>
        </li>
    </ul>
</div>

## Map modal (used for legend of context layers)
<div id="map-modal-main-map-id" class="modal">
    <div id="map-modal-body-main-map-id" class="modal-content">
        ## Placeholder for map modal
  </div>
    <div class="modal-footer">
        <a href="#" class="modal-action modal-close waves-effect waves-green btn-flat">${_('Close')}</a>
    </div>
</div>

## Filter (only once per page)

<ul id="slide-out-filter" class="side-nav map-side-menu">
        <%include file="lokp:customization/omm/templates/parts/filter.mak" />
</ul>

<%def name="bottom_tags()">
    <script type="text/javascript"
            src="//maps.google.com/maps/api/js?v=3&amp;key=${str(request.registry.settings.get('lokp.google_maps_api_key'))}&libraries=places"></script>
    <script src="${request.static_url('lokp:static/lib/leaflet/leaflet.js')}"></script>
    <script src="${request.static_url('lokp:static/lib/leaflet/Leaflet.GoogleMutant.js')}"></script>
    <script src="${request.static_url('lokp:static/lib/leaflet/leaflet.markercluster.js')}"></script>
    <script type="text/javascript" src="${request.static_url('lokp:static/lib/chroma/chroma.min.js')}"></script>
    <script type="text/javascript" src="${request.route_url('map_variables')}"></script>
    <script src="${request.static_url('lokp:static/js/maps/base.js')}" type="text/javascript"></script>
    <script src="${request.static_url('lokp:static/js/maps/main.js')}" type="text/javascript"></script>
    <script src="${request.static_url('lokp:static/js/filters.js')}" type="text/javascript"></script>
    <script src="${request.static_url('lokp:static/lib/jquery.cookie/jquery.cookie.min.js')}"
            type="text/javascript"></script>
    <script src="/custom/js/news.js"></script>
    <script src="/custom/js/potw.js"></script>
</%def>
