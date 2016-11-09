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
        <nav class="accent-background-color row">
            <div class="nav-wrapper">
                <div class="col s12">
                    <a href="${request.route_url('download')}${handle_query_string(request.url, return_value='query_string', remove=['order_by', 'dir', 'status'])}" class="breadcrumb" style="padding-left:15px;">${_('Download')}</a>
                    <a href="#!" class="breadcrumb">${_('Download Deals')}</a>
                </div>
            </div>
        </nav>

        <div class="row">
            <h3>
                ${_('Download Deals')}
            </h3>

            <div class="alert alert-info card-panel accent-background-color">
                <p class="white-text">${_('Only Deals which have been approved by a moderator will appear in the downloads.')}</p>
            </div>
            <p>
                ${_('Please note that the Deals are filtered spatially. Only Deals which are visible on the map will be downloaded. Also filters based on the attributes of Deals or Investors will be applied.')}
            </p>
        </div>

        <form method="POST">
            <div class="row">
                <ul class="collapsible" data-collapsible="accordion">
                   <li>
                      <div class="collapsible-header"><i class="material-icons">settings</i>${_('Change download options')}</div>
                        <div class="collapsible-body optiondownloaddiv">
                            <!--<legend>${_('Download options')}</legend>-->
                            <div class="input-field col s12">
                            <select id="output_format" name="format" class="update_option_in_overview">
                                % for format in formats:
                                    <option value="${format[0]}">${format[1]}</option>
                                % endfor
                            </select>
                            <label class="text-accent-color">${_('Output format')}</label>
                            </div>

                            <div class="input-field col s12">
                            <select id="involvements" name="involvements" class="update_option_in_overview">
                                <option value="full">${_('Yes')}</option>
                                <option value="none">${_('No')}</option>
                            </select>
                            <label class="text-accent-color">${_('Include involvements')}</label>
                            </div>

                            <label class="text-accent-color">${_('Attributes')}</label>
                                <div id="attributes_checkboxes" class="update_checkbox_in_overview">
                                    % for attribute in attributes:
                                    <p>
                                        <label class="checkbox">
                                        <input id="${attribute[0]}" type="checkbox" checked="checked" value="${attribute[0]}" name="attributes">
                                        <label for="${attribute[0]}">${attribute[1]}</label>
                                            </label>
                                    </p>
                                    % endfor
                                </div>
                      </div>
                   </li>
                </ul>

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

            <div class="row">

                <button class="btn waves-effect waves-light bottom" type="submit" name="action">
                    <i class="material-icons left">file_download</i>${_('Download')}
                </button>


                <div style="float: right;">
                   <a class="btn-floating btn-large tooltipped waves-effect waves-light button-collapse gridview_button" data-position="top" data-tooltip="Add a Filter" data-activates="slide-out-filter">
                        <i class="material-icons" style="margin-right: 15px;" data-position="top" >filter_list</i>
                    </a>
                    % if len(activeFilters) == 1:
                        <span class="badge" style="color: white; background-color: #323232; position: relative; top: -7px; left: 120px; z-index: 1; border-radius: 5px;">${len(activeFilters)} active filter</span>
                    % else:
                        <span class="badge" style="color: white; background-color: #323232; position: relative; top: -7px; left: 120px; z-index: 1; border-radius: 5px;">${len(activeFilters)} active filters</span>
                    % endif
                </div>
            </div>
            ID bei Checkboxen muss noch dynamisch angepasst werden
        </form>
    </div>
</div>



<%def name="bottom_tags()">
    <script type="text/javascript">
        var translation_all = "${_('All')}";
    </script>
    <script src="${request.static_url('lmkp:static/v2/download.js')}" type="text/javascript"></script>
    <script src="${request.static_url('lmkp:static/v2/filters.js')}" type="text/javascript"></script>
    <script>
        $(document).ready(function() {
        $('select').material_select();
        });
       </script>
</%def>
