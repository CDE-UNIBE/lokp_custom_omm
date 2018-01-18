<%def name="height()">500</%def>

<%inherit file="lmkp:customization/omm/templates/base.mak" />

<%def name="title()">${_("Investor bar charts")}</%def>

<%def name="head_tags()">
  <link rel="stylesheet" href="/custom/css/charts.css"></link>
</%def>

<div class="container">
  <div class="content no-border">

    <!-- zurückbutton -->
      <a class="btn-floating btn-large waves-effect waves-light btn btn-back" href="${request.route_url('charts_overview')}">
        <i class="material-icons">arrow_back</i>Back
      </a>

    <!--Dropdownliste -->
    <div class="row">
       <h4 id="group-by-title"><!-- Placeholder --></h4>
        <a id="group-by-dropdown-title" class='dropdown-button btn right' href='#' data-toggle="dropdown" href='#' data-activates='group-by-pills'></a>
        <ul class="dropdown-content nav nav-pills chartNav" id="group-by-pills">
            <!-- Placeholder -->
        </ul>
      </div>

    <!--Graph-->
    <div id="loadingRow" class="row-fluid">
      <div class="span12">
        <div id="graphLoading" style="height: ${height()}px;"></div>
      </div>
    </div>
    <div id="chart" class="row-fluid"><!-- Placeholder --></div>

    <!--Graphoptions-->
    <div class="row" id="graphoptions">
      <div class="btn-group" data-toggle="buttons-radio" id="attribute-buttons"><!-- Placeholder --></div>
      <a id="sortDesc" class="right btn-floating btn-large waves-effect waves-light accent-background-color gridview_button tooltipped" data-position="top" data-delay="50" data-tooltip="${_('Sort data descending')}">
        <i class="icon-sort-by-attributes-alt"></i>
      </a>
      <a id="sortAsc" class="right btn-floating btn-large waves-effect waves-light accent-background-color gridview_button tooltipped" data-position="top" data-delay="50" data-tooltip="${_('Sort data ascending')}">
        <i class="icon-sort-by-attributes"></i>
      </a>
    </div>
  </div>
</div>

<%def name="bottom_tags()">
  <script src="${request.static_url('lmkp:static/lib/d3/d3.v3.min.js')}" type="text/javascript"></script>
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
      "${_('Investors')}",
    ];

    var group_key = "${attr}";
    chart_data['group_by'] = chart_data['translate']['keys'][group_key];

    d3.xhr('${request.route_url("evaluation")}')
      .header("Content-Type", "application/json")
      .post(
        JSON.stringify(chart_data),
        function(err, rawData){
          var data = JSON.parse(rawData.responseText);
          if (!data['success']) {
            return console.warn(data['msg']);
          }
          $('#loadingRow').hide();
          updateContent(data);
          visualize(data.data);
        }
      );

    /**
     * Initialize all bootstrap tooltips.
     * https://github.com/twitter/bootstrap/issues/5687#issuecomment-14917403
     */
    $(function () {
      // Tooltips for buttons are placed at the top
      $("button[data-toggle='tooltip']").tooltip({
        container: 'body'
      });
      // Tooltips for links are place at the bottom
      $("a[data-toggle='tooltip']").tooltip({
        container: 'body',
        placement: 'bottom'
      });
    });
  </script>
  <script src="${request.static_url('lmkp:static/v2/charts/barchart.js')}" type="text/javascript"></script>

</%def>
