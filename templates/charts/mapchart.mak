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

    <div class="row-fluid visible-phone">
      <h4 class="chart-title">${_('Investor Map')}</h4>
    </div>
    <div id="map" class="row-fluid">
      <div id="loading-div">
        <div id="graphLoading" style="height: 200px;"></div>
      </div>
    </div>
    <div class="row">
      <div class="col s6">
        <div id="country-details"></div>
        <div id="helptext">
          <p>${_('The map shows the country of origin of Investors involved in Deals from the selected profile.')}</p>
          <p>${_('The colors represent the number of Investors from a certain country. The darker the color, the more Investors.')}</p>
          <p>${_('Move your mouse over a country in the list or on the map to show the details.')}</p>
        </div>
      </div>
      <div class="col s6">
        <ul id="countries-list"><!-- Placeholder --></ul>
      </div>
    </div>
  </div>
</div>

<%def name="bottom_tags()">
  <script src="//www.amcharts.com/lib/3/ammap.js"></script>
  <script src="//www.amcharts.com/lib/3/maps/js/worldLow.js"></script>
  <script src="${request.static_url('lokp:static/js/charts/mapchart_amcharts.js')}" type="text/javascript"></script>
  <script type="text/javascript">

    var attributeName = "${_('Investors')}";
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

    var responseData;

    $.ajax({
      type: 'POST',
      url: '${request.route_url("evaluation")}',
      data: JSON.stringify(chartData),
      dataType: 'json',
      success: function(data) {
        if (!data['success']) {
          return console.warn(data['msg']);
        }
        $('#loadingRow').hide();

        responseData = data;

        var areaData = data.data.map(function(d) {
          var name = d.group.value.value;
          var val = d.values[0].value;
          var code = countryMapping[name];
          return {
            "id": code,
            "value": val,
            "name": name
          }
        }).filter(function(d) {
          // Keep only those entries with ID (= code found in mapping)
          return d.id && d.id !== 'MM';
        }).sort(function(a, b) {
            return (a.value > b.value) ? -1 : ((b.value > a.value) ? 1 : 0);
        });
        createChartMap(areaData);
        initContent(areaData, attributeName);
      }
    });
  </script>
</%def>
