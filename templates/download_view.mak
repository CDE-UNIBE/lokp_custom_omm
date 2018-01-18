<%inherit file="lmkp:customization/omm/templates/base.mak" />

<%
    from lmkp.views.views import getFilterKeys
    from lmkp.views.views import getActiveFilters

    aFilterKeys, shFilterKeys = getFilterKeys(request)
    activeFilters = getActiveFilters(request)
%>

<%def name="title()">${_('Download')}</%def>

<%
    from lmkp.utils import handle_query_string
%>

## Filter
##<%include file="lmkp:customization/omm/templates/parts/filter.mak" />

<ul id="slide-out-filter" class="side-nav" style="min-width: 550px;">
    <%include file="lmkp:customization/omm/templates/parts/filter.mak" />
</ul>

<div class="container">
    <div class="content no-border">
        <div class="row-fluid">
            <h3>
                ${_('Download')}
            </h3>
            <p>
                ${_('All the information about the Deals or Investors found on the Myanmar land reporting can be downloaded.')}
            </p>
            <p>
                ${_('Please select one of the download options below.')}
            </p>
        </div>
        <div class="row">
            <div id="downloadoverviewbuttoncontainer" class="col s12 ">
                <div style="float: right;">
                    <a class="btn-floating tooltipped btn-large button-collapse" data-position="top" data-tooltip="Add a Filter" data-activates="slide-out-filter">
                        <i class="material-icons" style="margin-right: 15px;" data-position="top" >filter_list</i>
                    </a>
                    % if len(activeFilters) == 1:
                        <span class="badge" style="color: white; background-color: #323232; position: relative; top: -25px; left: -40px; z-index: 1; border-radius: 5px;">${len(activeFilters)} active filter</span>
                    % else:
                        <span class="badge" style="color: white; background-color: #323232; position: relative; top: -25px; left: -40px; z-index: 1; border-radius: 5px;">${len(activeFilters)} active filters</span>
                    % endif
                </div>
                <a class="btn btn-primary margin" href="${request.route_url('activities_read_many', output='download')}${handle_query_string(request.url, return_value='query_string', remove=['order_by', 'dir', 'status'])}">
                    ${_('Download Deals')}
                </a>
                <a class="btn btn-primary margin" href="${request.route_url('stakeholders_read_many', output='download')}${handle_query_string(request.url, return_value='query_string', remove=['order_by', 'dir', 'status'])}">
                    ${_('Download Investors')}
                </a>
            </div>
        </div>
    </div>
</div>

<%def name="bottom_tags()">
    <script src="${request.static_url('lmkp:static/v2/filters.js')}" type="text/javascript"></script>
</%def>