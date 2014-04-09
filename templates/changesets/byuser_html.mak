<%inherit file="lmkp:customization/lo/templates/base.mak" />

<%
from lmkp.views.profile import get_current_locale
from lmkp.views.profile import get_current_profile
%>

<%def name="title()">${_('Latest Changesets by %s' % username)}</%def>

<%def name="inlinemenu()">
    <div class="row-fluid">
        <div class="span9 text-right">
            <a href="${request.route_url('changesets_read_byuser', username=username, output='rss', _query=(('_LOCALE_', get_current_locale(request)),('_PROFILE_', get_current_profile(request))))}">
                <i class="icon-rss"></i> Subscribe
            </a>
            &nbsp;|&nbsp
            <a href="${request.route_url('changesets_read_latest', output='html')}">
                <i class="icon-list-ul"></i> All Changesets
            </a>
        </div>
    </div>
</%def>

<div class="container">
    <div class="content no-border">

        ## Header menu bar
        ${inlinemenu()}

        <div class="row-fluid">
            <div class="span9">
                <h3 class="form-below-toolbar">${_('Latest Changesets by %s' % username)}</h3>
            </div>
        </div>

        <div class="row-fluid">
            <div class="span9">
                <span>${_('The latest changes edited on the Land Observatory by %s' % username)}</span>
            </div>
        </div>

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
                            <td>${item['pubDate']}</td>
                            <td>${item['description'] | n}</td>
                        </tr>
                        % endfor
                    </tbody>
                </table>
            </div>
        </div>

        ## Footer menu bar
        ${inlinemenu()}

    </div>
</div>