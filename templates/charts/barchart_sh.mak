<%def name="height()">500</%def>

<%inherit file="lokp:customization/omm/templates/base.mak" />

<%def name="title()">${_("Investor bar charts")}</%def>

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

    <!-- Graph options (not shown as there is only 1 attribute) -->
    <div class="row hide" id="graphoptions">
      <div id="attribute-buttons"><!-- Placeholder --></div>
    </div>

    <div class="alert alert-info card-panel accent-background-color">
      <p class="white-text">
        <i class="icon-exclamation-sign white-text"></i>&nbsp;
        As the primary investor of deals in the Myanmar Land Reporting must be a company registered in Myanmar, the number of investors from Myanmar exceeds all other countries.
      </p>
    </div>
  </div>
</div>

<%def name="bottom_tags()">
  <script src="//code.highcharts.com/highcharts.src.js"></script>
  <script src="${request.static_url('lokp:static/js/charts/barchart_highcharts.js')}" type="text/javascript"></script>
  <script type="text/javascript">

    var group_activities_by = "${_('Group investors by:')}";
    var show_attribute = "${_('Show attribute:')}";
    var chart_data = {
      'item': 'Stakeholder',
      'attributes': {
        'Stakeholder': 'count'
      },
      'translate': {
        'keys': [
          ['Country of origin'],
        ]
      }
    };
    var attribute_names = [
      "${_('Investors')}"
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
