<%inherit file="lmkp:customization/omm/templates/base.mak" />

<%
    from lmkp.views.views import getFilterKeys
    from lmkp.views.views import getActiveFilters

    aFilterKeys, shFilterKeys = getFilterKeys(request)
    activeFilters = getActiveFilters(request)
%>

<%def name="title()">${_('Grid View')} - ${_('Investors')}</%def>

## Start of content

<%
    import urllib
    import datetime
    from lmkp.utils import handle_query_string

    # Get the keys and their translation
    from lmkp.views.config import getGridColumnKeys
    keys = getGridColumnKeys(request, 'stakeholders')

    a_uids = ','.join(invfilter) if invfilter is not None else ''
%>

## Filter
<ul id="slide-out-filter" class="side-nav" style="min-width: 550px;">
    <%include file="lmkp:customization/omm/templates/parts/filter.mak" />
</ul>

<!-- content -->
<div class="container">

    <div class="content">

        ## Spatial Filter
        <%
            spatialFilterBasedOn = _('Profile')
            spatialFilterExplanation = _('You are seeing all the Investors involved in Deals within the current profile.')
            spatialFilterLink = None

            if spatialfilter == 'map':
                spatialFilterBasedOn = _('Map Extent')
                spatialFilterExplanation = _('You are currently only seeing Investors involved in Deals which are visible on the map.')
                spatialFilterLink = _('Show all the Investors involved in Deals of the profile.')
        %>

        % if spatialfilter:
        <div class="alert alert-info card-panel accent-background-color">
            <p class="white-text">
            <i class="icon-globe white-text"></i>&nbsp;
            <strong>${_('Spatial Filter')}</strong> ${_('based on')}
                % if spatialFilterLink:
                    <strong><a href="${request.route_url('map_view')}">${spatialFilterBasedOn}</a></strong>.
                % else:
                    <strong>${spatialFilterBasedOn}</strong>.
                % endif
            ${spatialFilterExplanation}
            % if spatialFilterLink:
                <br/><a href="${handle_query_string(request.url, add=[('bbox', 'profile')])}">${spatialFilterLink}</a>
            % endif
             </p>
        </div>
        % endif

        ## Involvement Filter
        % if invfilter:
        <div class="alert alert-info card-panel accent-background-color">
            <p class="white-text">
            <i class="icon-filter"></i>&nbsp;
            <strong>${_('Deal Filter')}</strong>: ${_('You are currently only seeing Investors which are involved in Deal')}
            % for uid in invfilter:
                <a href="${request.route_url('activities_read_one', output='html', uid=uid)}">
                    ${uid[:6]}</a>
            % endfor
            .<br/><a href="${request.route_url('stakeholders_byactivities_all', output='html')}">${_('Remove this filter and show all Investors')}</a>.
            </p>
        </div>
        % endif

        ## Status Filter
        % if statusfilter:
        <div class="alert alert-info card-panel accent-background-color">
            <p class="white-text">
                <i class="icon-filter"></i>&nbsp;
                <strong>${_('Status Filter')}</strong>: ${_('You are only seeing Investors with the following status:')} ${statusfilter}
            </p>
        </div>
        % endif

        ## Tabs
        <div id="gridview_tab" class="row">
            <div class="col s12">
                <ul class="tabs">

                    ##erstes Tab
                    % if request.current_route_url() in [request.route_url('activities_read_many', output='html')]:
                        <li class="tab col s3" onClick="self.location.href='${request.route_url('activities_read_many', output='html')}${handle_query_string(request.url, return_value='query_string', remove=['order_by', 'dir', 'status'])}'">
                    % else:
                        <li class="tab col s3" onClick="self.location.href='${request.route_url('activities_read_many', output='html')}${handle_query_string(request.url, return_value='query_string', remove=['order_by', 'dir', 'status'])}'">
                    % endif
                        <a class="text-accent-color" href="${request.route_url('activities_read_many', output='html')}${handle_query_string(request.url, return_value='query_string', remove=['order_by', 'dir', 'status'])}">${_('Deals')}</a>
                    </li>

                    ##zweites Tab
                    % if request.current_route_url() in [request.route_url('stakeholders_byactivities_all', output='html'), request.route_url('stakeholders_byactivities', output='html', uids=a_uids), request.route_url('stakeholders_read_many', output='html')]:
                        % if is_moderator:
                            <li class="active moderator-show-pending-left tab col s3">
                        % else:
                            <li class="active tab col s3">
                        % endif
                    % else:
                        <li class="active tab col s3">
                    % endif
                        <a class="active text-accent-color" href="${request.route_url('stakeholders_byactivities_all', output='html')}${handle_query_string(request.url, return_value='query_string', remove=['order_by', 'dir', 'status'])}">${_('Investors')}</a>
                    </li>

                    ##Unklar
                    % if is_moderator:
                        % if 'status=pending' in request.path_qs:
                            <li class="active moderator-show-pending-right tab col s3">
                                <a class="active text-accent-color" href="${handle_query_string(request.current_route_url(), remove=['status'])}" data-toggle="tooltip" title="${_('Show all')}">
                                    <i class="icon-flag"></i>
                                </a>
                            </li>
                        % else:
                            <li class="moderator-show-pending-right tab col s3">
                                <a class="active text-accent-color" href="${handle_query_string(request.current_route_url(), add=[('status', 'pending')])}" data-toggle="tooltip" title="${_('Show only pending')}">
                                    <i class="icon-flag"></i>
                                </a>
                            </li>
                        % endif
                    % endif
                </ul>
                </div>
        </div>

        ## Table
        <div>

            % if len(data) == 0:

                ## Empty data
                <p>&nbsp;</p>
                <h5>${_('Nothing found')}</h5>
                <p>${_('No results were found.')}</p>
                <p>&nbsp;</p>

            % else:

                <table
                    class="table table-hover table-self table-bordered"
                    id="itemgrid">
                    <thead>
                        ## The table headers
                        <tr>
                            <th>${_('Investor ID')}</th>
                            <th>
                                ${_('Last Change')}
                                <a href="${handle_query_string(request.url, add=[('order_by', 'timestamp'), ('dir', 'asc')])}">
                                    <div class="desc
                                         % if 'order_by=timestamp' in request.path_qs and 'dir=%s' % urllib.quote_plus('asc') in request.path_qs:
                                            active
                                         % endif
                                         ">&nbsp;</div>
                                </a>
                                <a href="${handle_query_string(request.url, add=[('order_by', 'timestamp'), ('dir', 'desc')])}">
                                <div class="asc
                                     % if ('order_by=timestamp' in request.path_qs and 'dir=%s' % urllib.quote_plus('desc') in request.path_qs) or 'order_by=' not in request.path_qs:
                                        active
                                     % endif
                                     ">&nbsp;</div>
                                </a>
                            </th>
                            % for k in keys:
                                <th>${k[1]}
                                    <a href="${handle_query_string(request.url, add=[('order_by', k[0]), ('dir', 'asc')])}">
                                        <div class="desc
                                             % if 'order_by=%s' % urllib.quote_plus(k[0]) in request.path_qs and 'dir=%s' % urllib.quote_plus('asc') in request.path_qs:
                                                active
                                             % endif
                                             ">&nbsp;</div>
                                    </a>
                                    <a href="${handle_query_string(request.url, add=[('order_by', k[0]), ('dir', 'desc')])}">
                                    <div class="asc
                                         % if 'order_by=%s' % urllib.quote_plus(k[0]) in request.path_qs and 'dir=%s' % urllib.quote_plus('desc') in request.path_qs:
                                            active
                                         % endif
                                         ">&nbsp;</div>
                                    </a>
                                </th>
                            % endfor
                        </tr>
                    </thead>
                    <tbody>
                        ## The table body

                        % for d in data:
                            <%
                                # Collect and prepare the necessary values to
                                # show in the grid.

                                pending = False
                                if 'status_id' in d and d['status_id'] == 1:
                                    pending = True

                                id = d['id'] if 'id' in d else _('Unknown')
                                timestamp = (datetime.datetime.strptime(d['timestamp'], '%Y-%m-%d %H:%M:%S.%f').strftime('%Y-%m-%d %H:%M')
                                    if 'timestamp' in d else _('Unknown'))
                                values = []
                                translatedkeys = []
                                for k in keys:
                                    translatedkeys.append(k[1])
                                    values.append('Unknown')
                                for tg in d['taggroups']:
                                    for t in tg['tags']:
                                        for i, tk in enumerate(translatedkeys):
                                            if t['key'] == tk:
                                                values[i] = t['value']
                            %>

                            % if pending:
                                <tr class="pending tooltipped" data-position="top" data-delay="50" data-tooltip="${_("Show deals of this investor")}">
                            % else:

                                <tr class="tooltipped" data-position="top" data-delay="50" data-tooltip="${_("Show deals of this investor")}">
                            % endif
                                <td>
                                    <a class="btn" href="${request.route_url('stakeholders_read_one', output='html', uid=id)}">
                                        ${id[:6]}
                                    </a>
                                </td>
                                <td>${timestamp}</td>
                                % for v in values:
                                    <td>${v}</td>
                                % endfor

                                <td class="identifier hide">${id}</td>
                                <td class="itemType hide">stakeholders</td>

                            </tr>
                        % endfor

                    </tbody>
                </table>

            % endif
        </div>

        <div id="gridview_tableoptions" class="row">
            <!-- Buttons für Desktop Ansicht -->
            <div class="col s6 right gridview_mobile_hidden">
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
                <a class="btn-floating btn-large waves-effect waves-light accent-background-color gridview_button tooltipped" data-position="top" data-delay="50" data-tooltip="${_('Download Investors')}" href="${request.route_url('stakeholders_read_many', output='download')}${handle_query_string(request.url, return_value='query_string', remove=['order_by', 'dir', 'status'])}">
                    <i class="icon-download-alt"></i>
                </a>

                <a class="btn-floating btn-large waves-effect waves-light accent-background-color gridview_button tooltipped" data-position="top" data-delay="50" data-tooltip="${_('View and subscribe to latest changes')}" href="${request.route_url('changesets_read_latest', output='rss', _query=(('_LOCALE_', locale),('_PROFILE_', profile)))}">
                    <i class="icon-rss"></i>
                </a>

                % if default_search_translated:
                        <li class="grid-tab-right">
                            <a href="javascript:void(0)" id="search" data-toggle="tooltip" title="${_('Search by')} ${default_search_translated}">
                                <i class="icon-search"></i>
                            </a>
                        </li>
                % endif
            </div>

            ## Pagination
            % if len(data) > 0:
                <%include file="lmkp:templates/parts/pagination.mak"
                    args="totalitems=total, currentpage=currentpage, pagesize=pagesize, itemsname=_('Investors')"
                />
            % endif

             <!-- Buttons für Mobile Ansicht -->
                <div class="col s3 right gridview_desktop_hidden">
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
                    <a class="btn-floating btn-large waves-effect waves-light accent-background-color gridview_button tooltipped" data-position="top" data-delay="50" data-tooltip="${_('Download Investors')}" href="${request.route_url('stakeholders_read_many', output='download')}${handle_query_string(request.url, return_value='query_string', remove=['order_by', 'dir', 'status'])}">
                        <i class="icon-download-alt"></i>
                    </a>

                    <a class="btn-floating btn-large waves-effect waves-light accent-background-color gridview_button tooltipped" data-position="top" data-delay="50" data-tooltip="${_('View and subscribe to latest changes')}" href="${request.route_url('changesets_read_latest', output='rss', _query=(('_LOCALE_', locale),('_PROFILE_', profile)))}">
                        <i class="icon-rss"></i>
                    </a>

                    % if default_search_translated:
                            <li class="grid-tab-right">
                                <a href="javascript:void(0)" id="search" data-toggle="tooltip" title="${_('Search by')} ${default_search_translated}">
                                    <i class="icon-search"></i>
                                </a>
                            </li>
                    % endif
                </div>
            </div>
    </div>
</div>

## End of content

<%def name="bottom_tags()">
    <script type="text/javascript">
        $(function () {
            $("a[data-toggle='tooltip']").tooltip({
                container: 'body',
                placement: 'bottom'
            });
        });
        var link_involvement_text = '${_("Show deals of this investor")}';
    </script>
    <script src="${request.static_url('lmkp:static/v2/grid.js')}" type="text/javascript"></script>
    <script src="${request.static_url('lmkp:static/v2/filters.js')}" type="text/javascript"></script>
</%def>