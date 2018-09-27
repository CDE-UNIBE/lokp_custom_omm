<%inherit file="lokp:customization/omm/templates/base.mak" />

<%
from lokp.utils.views import get_current_locale, get_current_profile
%>

<%def name="title()">${_('Approved changesets by %s' % username)}</%def>

<%def name="inlinemenu()">
<div class="row-fluid">
    <div class="span9 text-right">
        <a class="btn-floating btn-large waves-effect waves-light accent-background-color gridview_button tooltipped" data-position="top" data-delay="50" data-tooltip="${_(u'Subscribe')}" href="${request.route_url('changesets_read_byuser', username=username, output='rss', _query=(('_LOCALE_', get_current_locale(request)),))}">
            <i class="icon-rss"></i>
        </a>
        % if pagesize != 10:
        <a class="btn-floating btn-large waves-effect waves-light accent-background-color gridview_button tooltipped" data-position="top" data-delay="50" data-tooltip="${_(u'All Changesets')}" href="${request.route_url('changesets_read_latest', output='html', _query=(('pagesize', pagesize),))}">
        % else:
        <a class="btn-floating btn-large waves-effect waves-light accent-background-color gridview_button tooltipped" data-position="top" data-delay="50" data-tooltip="${_(u'All Changesets')}" href="${request.route_url('changesets_read_latest', output='html')}">
        % endif
            <i class="icon-list-ul"></i>
        </a>
    </div>
</div>
</%def>

<div class="container">
    <div class="content no-border">

        <div class="alert alert-info card-panel accent-background-color white-text">
            ${_('Please note that only approved changes are visible in the changesets.')}
        </div>

        <div class="row-fluid">
            <div class="span9">
                <h3 class="form-below-toolbar">${_('Approved changesets by %s' % username)}</h3>
            </div>
        </div>

        ##<div class="row-fluid">
            ##    <div class="span9">
                ##        <span>${_('The latest changes edited on the Myanmar land reporting by %s' % username)}</span>
                ##    </div>
            ##</div>

        <div class="row-fluid">
            <div class="span9">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>${_('Timestamp')}</th>
                            <th>${_('Changeset description')}</th>
                        </tr>
                    </thead>
                    <tbody>
                        % for item in items:
                        <tr>
                            <td>${item['timestamp'].strftime("%a, %d %b %Y %H:%M:%S %Z")}</td>
                            <%
                            date = item['timestamp'].strftime("%a, %d %b %Y %H:%M:%S %Z")
                            %>
                            % if item['type'] == "activity":
                            <td>Update of deal
                                <a href="${request.route_url('activities_read_one', output='html', uid=item['identifier'], _query=(('v', item['version']),))}" class="text-accent-color">
                                    #${item['identifier'].split("-")[0].upper()}
                                </a> on ${date} to version&nbsp;${item['version']}
                            </td>
                            % elif item['type'] == "stakeholder":
                            <td>Update of investor
                                <a href="${request.route_url('stakeholders_read_one', output='html', uid=item['identifier'], _query=(('v', item['version']),))}" class="text-accent-color">
                                    #${item['identifier'].split("-")[0].upper()}
                                </a>
                                on ${date} to version&nbsp;${item['version']}</td>
                            % endif
                        </tr>
                        % endfor
                    </tbody>
                </table>
            </div>
        </div>

        <div id="gridviw_tableoptions" class="row" style="margin-top: 30px;">
            <!-- Buttons für Desktop Ansicht -->
            <div class="col s3 right gridview_mobile_hidden">
                ## Footer menu bar
                ${inlinemenu()}
            </div>

            ## Pagination
            % if len(items) > 0:
            <div class="row-fluid">
                <div class="span9">
                    <%include file="lokp:templates/parts/pagination.mak"
                    args="totalitems=totalitems, currentpage=currentpage, pagesize=pagesize, itemsname=_('Changesets')"
                    />
                </div>
            </div>
            % endif

            <!-- Buttons für Mobile Ansicht -->
            <div class="col right gridview_desktop_hidden">
                ## Footer menu bar
                ${inlinemenu()}
            </div>
        </div>
    </div>
</div>
