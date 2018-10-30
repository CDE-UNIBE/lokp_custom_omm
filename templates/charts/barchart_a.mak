<%def name="height()">500</%def>

<%inherit file="lokp:customization/omm/templates/base.mak" />

<%def name="title()">${_("Deal bar charts")}</%def>

<%def name="head_tags()">
  <link rel="stylesheet" href="/custom/css/charts.css"></link>
</%def>

<div class="container">
  <div class="content no-border">

    <!-- Back button -->
      <a class="btn-floating btn-large waves-effect waves-light btn btn-back" href="${request.route_url('charts_overview')}">
      <i class="material-icons">arrow_back</i>Back
    </a>

    <!-- Dropdown list -->
    <div class="row">
      <a id="group-dropdown-title" class='dropdown-button btn right' href='#' data-toggle="dropdown" href='#' data-activates='group-dropdown'><!-- Placeholder --></a>
      <ul class="dropdown-content nav nav-pills chartNav" id="group-dropdown"><!-- Placeholder --></ul>
    </div>

    <!-- Graph -->
    <div id="loadingRow" class="row">
      <div class="col s12">
        <div id="graphLoading" style="height: ${height()}px;"></div>
      </div>
    </div>
    <div id="container" class="row-fluid"><!-- Placeholder --></div>

    <!-- Graph options -->
    <div class="row" id="graphoptions">
      <div id="attribute-buttons"><!-- Placeholder --></div>
    </div>
  </div>
</div>

<%def name="bottom_tags()">
  <script src="//code.highcharts.com/highcharts.src.js"></script>
  <script src="${request.static_url('lokp:static/js/charts/barchart_highcharts.js')}" type="text/javascript"></script>
  <script type="text/javascript">

    var group_activities_by = "${_('Group deals by:')}";
    var show_attribute = "${_('Show attribute:')}";
    var chart_data = {
      'item': 'Activity',
      'attributes': {
        'Activity': 'count',
        'Intended area (ha)': 'sum'
      },
      'translate': {
        'keys': [
          ['Intention of Investment'],
          ['Negotiation Status'],
          ['Implementation status']
        ]
      }
    };
    var attribute_names = [
      "${_('Deals')}",
      "${_('Intended area')}"
    ];

    var group_key = "${attr}";
    chart_data['group_by'] = chart_data['translate']['keys'][group_key];

    var responseData;

    $.ajax({
      type: 'POST',
      url: '${request.route_url("evaluation")}',
      data: JSON.stringify(chart_data),
      dataType: 'json',
      success: function(data) {
        if (!data['success']) {
          return console.warn(data['msg']);
        }
        $('#loadingRow').hide();

        responseData = data;

        initContent(attribute_names);
        prepareChartData(0);
      }
    });
  </script>
</%def>
