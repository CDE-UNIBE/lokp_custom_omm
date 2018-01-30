<%inherit file="lokp:customization/omm/templates/base.mak" />

<%def name="title()">${_("Investor Map")}</%def>

<%def name="head_tags()">
  <link rel="stylesheet" href="/custom/css/charts.css"></link>
</%def>

<div class="container">
  <div class="content no-border">

    <!--backbutton-->
      <a class="btn-floating btn-large waves-effect waves-light btn btn-back" href="${request.route_url('charts_overview')}">
        <i class="material-icons">arrow_back</i>Back
      </a>



    <div class="row-fluid chart-top-menu">
      % if len(profiles) > 0:
        <div class="pull-right">
          <div class="map-profile-select">${_("Profile")}:</div>
             <a id="group-by-dropdown-title" class='dropdown-button btn right' href='#' data-toggle="dropdown" href='#' data-activates='profile-selector'>${profile}</a>
            <ul class="dropdown-content" id="profile-selector">
              % for p in profiles:
                <li><a href="javascript:void(0);" data-profile="${p[1]}">${p[0]}</a></li>
              % endfor
            </ul>
          </div>
        </div>
      % endif
    </div>



    <div class="row-fluid visible-phone">
      <h2 class="chart-title"><!-- Placeholder --></h2>
    </div>
    <div id="map" class="row-fluid">
      <div id="loading-div">
        <div id="graphLoading" style="height: 200px;"></div>
      </div>
    </div>
    <div class="row-fluid">
      <div class="span6 hidden-phone">
        <div id="country-details"></div>
        <div id="helptext" class="hide">
          <h2 class="chart-title"></h2>
          <p>${_('The map shows the country of origin of Investors involved in Deals from the selected profile.')}</p>
          <p>${_('The colors represent the number of Investors from a certain country. The darker the color, the more Investors.')}</p>
          <p>${_('Move your mouse over a country in the list or on the map to show the details.')}</p>
        </div>
      </div>
      <div class="span6">
        <ul id="countries-list"><!-- Placeholder --></ul>
      </div>
    </div>
  </div>
</div>

<%def name="bottom_tags()">
  <script src="${request.static_url('lokp:static/lib/d3/d3.min.js')}"></script>
  <script src="${request.static_url('lokp:static/lib/colorbrewer/colorbrewer.min.js')}"></script>
  <script src="${request.static_url('lokp:static/lib/topojson/topojson.min.js')}"></script>
  <script src="${request.static_url('lokp:static/js/charts/mapchart.js')}" type="text/javascript"></script>
  <script type="text/javascript">

    var attributeNames = [
      "${_('Investors')}"
    ];
    var chartData = {
      'item': 'Stakeholder',
      'attributes': {
        'Stakeholder': 'count'
      },
      'group_by': ['Country of origin'],
      'locales': ['code'],
      'translate': {
        'keys': [['Country of origin']]
      }
    };
    var data_url = '${request.route_url("evaluation")}';
    var map_url = '${request.static_url("lokp:static/js/charts/world.topo.json")}';

    drawMap();
    loadMapData();

    $('#profile-selector>li>a').click(function() {
      $('.btn-country-selector').text($(this).text());
      changeProfile($(this).data('profile'));
    });
  </script>
</%def>
