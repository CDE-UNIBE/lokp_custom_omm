<%inherit file="lmkp:customization/omm/templates/base.mak" />

<%
from lmkp.views.views import (
    get_current_locale,
    get_current_profile,
)
%>

<%def name="title()">${_('Latest approved Changesets')}</%def>

<%def name="inlinemenu()">
<div class="row-fluid">
    <div class="span9 text-right">
        <a class="btn-floating btn-large waves-effect waves-light accent-background-color gridview_button tooltipped" data-position="top" data-delay="50" data-tooltip="${_("Subscribe")}" href="${request.route_url('changesets_read_latest', output='rss', _query=(('_LOCALE_', get_current_locale(request)),('_PROFILE_', get_current_profile(request))))}">
            <i class="icon-rss"></i>
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
                <h3 class="form-below-toolbar">${_('Latest approved Changesets')}</h3>
            </div>
        </div>

        ##<div class="row-fluid">
        ##    <div class="span9">
        ##        <span>${_('The latest approved changes edited on the Land Observatory')}</span>
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
                        <tr class="all_changset_description">
                            <td>${item['pubDate']}</td>
                            <td>${item['description'] | n}</td>
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
                    <%include file="lmkp:templates/parts/pagination.mak"
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
