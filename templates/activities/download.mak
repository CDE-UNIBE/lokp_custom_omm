<%inherit file="lmkp:customization/omm/templates/base.mak" />

<%
    from lmkp.views.views import getFilterKeys
    from lmkp.views.views import getActiveFilters

    aFilterKeys, shFilterKeys = getFilterKeys(request)
    activeFilters = getActiveFilters(request)
%>

<%def name="title()">${_('Download Deals')}</%def>

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
        <ul class="breadcrumb">
            <li>
                <a href="${request.route_url('download')}${handle_query_string(request.url, return_value='query_string', remove=['order_by', 'dir', 'status'])}">${_('Download')}</a>
                <span class="divider">&raquo;</span>
            </li>
            <li class="active">${_('Download Deals')}</li>
        </ul>
        <div class="row-fluid">
            <h3>
                ${_('Download Deals')}
            </h3>
            <div class="alert alert-info">
                ${_('Only Deals which have been approved by a moderator will appear in the downloads.')}
            </div>
            <p>
                ${_('Please note that the Deals are filtered spatially. Only Deals which are visible on the map will be downloaded. Also filters based on the attributes of Deals or Investors will be applied.')}
            </p>
        </div>
        <hr class="grey" />
        <form method="POST">
            <div class="row-fluid">
                <div class="accordion" id="download_options">
                    <div class="accordion-group">
                        <div class="accordion-heading">
                            <a class="accordion-toggle" data-toggle="collapse" data-parent="#download_options" href="#download_options_customize">
                                ${_('Change download options')}
                            </a>
                        </div>
                        <div id="download_options_customize" class="accordion-body collapse">
                            <div class="accordion-inner">
                                <legend>${_('Download options')}</legend>
                                <label for="output_format">${_('Output format')}</label>
                                <select id="output_format" class="update_option_in_overview" name="format">
                                    % for format in formats:
                                        <option value="${format[0]}">${format[1]}</option>
                                    % endfor
                                </select>
                                <label for="involvements">${_('Include involvements')}</label>
                                <select id="involvements" class="update_option_in_overview" name="involvements">
                                    <option value="full">${_('Yes')}</option>
                                    <option value="none">${_('No')}</option>
                                </select>
                                <label>${_('Attributes')}</label>
                                <div id="attributes_checkboxes" class="update_checkbox_in_overview">
                                    % for attribute in attributes:
                                        <label class="checkbox">
                                            <input type="checkbox" checked="checked" value="${attribute[0]}" name="attributes"> ${attribute[1]}
                                        </label>
                                    % endfor
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="accordion" id="download_overview">
                    <div class="accordion-group">
                        <div class="accordion-body collapse-in">
                            <div class="accordion-inner">
                                <h5>${_('Selected download options')}</h5>
                                <table class="download-overview-table">
                                    <tr>
                                        <th>${_('Format')}</th>
                                        <td id="output_format_overview">...</td>
                                    </tr>
                                    <tr>
                                        <th>${_('Involvements')}</th>
                                        <td id="involvements_overview">...</td>
                                    </tr>
                                    <tr>
                                        <th>${_('Attributes')}</th>
                                        <td id="attributes_checkboxes_overview">...</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row-fluid">
                <div class="span12 text-right">
                    <button type="submit" class="btn btn-primary">${_('Download')}</button>
                </div>
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
            </div>
        </form>
    </div>
</div>

<%def name="bottom_tags()">
    <script type="text/javascript">
        var translation_all = "${_('All')}";
    </script>
    <script src="${request.static_url('lmkp:static/v2/download.js')}" type="text/javascript"></script>
    <script src="${request.static_url('lmkp:static/v2/filters.js')}" type="text/javascript"></script>
</%def>
