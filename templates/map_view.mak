<%
    from lmkp.views.views import getFilterKeys
    from lmkp.views.views import getActiveFilters

    aFilterKeys, shFilterKeys = getFilterKeys(request)
    activeFilters = getActiveFilters(request)
%>

<%inherit file="lmkp:customization/omm/templates/base.mak" />

<%def name="title()">${_('Map View')}</%def>

<%def name="head_tags()">
<link rel="stylesheet" href="${request.static_url('lmkp:static/lib/OpenLayers-2.12/theme/default/style.css')}" type="text/css" />
<script type="text/javascript">
<%
    from lmkp.views.profile import _getCurrentProfileExtent
    from lmkp.views.views import getOverviewKeys
    from lmkp.views.views import getFilterValuesForKey
    from lmkp.views.views import getMapSymbolKeys
    from lmkp.views.config import form_geomtaggroups
    import json

    aKeys, shKeys = getOverviewKeys(request)
    extent = json.dumps(_getCurrentProfileExtent(request))
    mapSymbols = getMapSymbolKeys(request)
    mapCriteria = mapSymbols[0]
    mapSymbolValues = [v[0] for v in sorted(getFilterValuesForKey(request,
        predefinedType='a', predefinedKey=mapCriteria[1]),
        key=lambda value: value[1])]
    geomTaggroups = form_geomtaggroups(request)

%>
    var profilePolygon = ${extent | n};
    var aKeys = ${json.dumps(aKeys) | n};
    var shKeys = ${json.dumps(shKeys) | n};
    var mapValues = ${json.dumps(mapSymbolValues) | n};
    var mapCriteria = ${json.dumps(mapCriteria) | n};
    var areaNames = ${json.dumps(geomTaggroups['mainkeys']) | n};
    var allMapCriteria = ${json.dumps(mapSymbols) | n};

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


<ul id="slide-out-map-options" class="side-nav" style="min-width: 550px;">
    <div class="row" style="margin: 10px 0px 0px 0px;">
        <div class="input-field col s11" action="">
            <i class="material-icons prefix">search</i>
            <input id="search" name="q" type="text" style="height: 20px; line-height: 20px;">
        </div>
    </div>

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

<ul id="slide-out-filter" class="side-nav" style="min-width: 550px;">
    <%include file="lmkp:customization/omm/templates/parts/filter.mak" />
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
            <div id="tab2" class="col s12" style="padding: 30px;">
                <h5 class="deal-headline text-primary-color">News</h5>
            </div>
        </div>
        <div id="window-right-bottom" style="height: 50%;">
            <ul class="tabs" style="overflow-x: hidden;">
                <li class="tab col s3"><a href="#bottom-tab1" class="active text-accent-color">Picture of the week</a></li>
                <li class="tab col s3"><a href="#bottom-tab2" class="text-accent-color">Archive</a></li>
            </ul>
            <div id="bottom-tab1" class="col s12" style="text-align: center; height: 100%; margin: 0;">
                  <img src="/custom/img/slides/pictureoftheweek.jpeg" id="img-weekpicture" style="margin-top: 30px; margin-bottom: 30px; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
            </div>
            <div id="bottom-tab2" class="col s12" style="padding: 30px;">
                <h5 class="deal-headline">Archive</h5>
                <p>No archived data at the moment..</p>
            </div>
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
            <input name="q" id="search" class="search-query" placeholder="${_('search location')}" />
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

<div id="mapModal" class="modal bottom-sheet">
    <div id="mapModalBody" class="modal-content">
        <!-- Placeholder -->
    </div>
    <div class="modal-footer">
        <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">Agree</a>
    </div>
</div>

<%def name="bottom_tags()">
<script type="text/javascript" src="http://maps.google.com/maps/api/js?v=3&amp;"></script>
<script src="${request.static_url('lmkp:static/build/openlayers/OpenLayers.mapview.min.js')}" type="text/javascript"></script>
<script type="text/javascript" src="${request.route_url('context_layers')}"></script>
<script src="${request.static_url('lmkp:static/v2/maps/main.js')}" type="text/javascript"></script>
<script src="${request.static_url('lmkp:static/v2/maps/base.js')}" type="text/javascript"></script>
<script src="${request.static_url('lmkp:static/v2/filters.js')}" type="text/javascript"></script>
<script src="${request.static_url('lmkp:static/v2/jquery.cookie.js')}" type="text/javascript"></script>
</%def>
