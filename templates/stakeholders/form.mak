<%inherit file="lmkp:customization/omm/templates/base.mak" />

<%def name="title()">${_('Investor Editor')}</%def>

<%def name="head_tags()">

    <link rel="stylesheet" href="/static/form.css" type="text/css" />

    <script type="text/javascript" src="${request.static_url('lmkp:static/v2/form.js')}"></script>

    <%
        if 'scripts/jquery-ui-1.8.11.custom.min.js' not in js_links:
            js_links.append('scripts/jquery-ui-1.12.1.min.js')
    %>

    % for reqt in js_links:
        <script type="text/javascript" src="/formstatic/${reqt}"></script>
    % endfor
    <script type="text/javascript" src="/formstatic/jquery-ui-1.12.1.min.js"></script>
</%def>

<div class="container deal-edit-content">
    <div class="content no-border">

        ## Session messages
        <%include file="lmkp:templates/parts/sessionmessage.mak"/>

        ${form | n}
    </div>
</div>

<%def name="bottom_tags()">
    <script type="text/javascript">
        if (deform) {
            deform.load();
        }

        $(document).ready(function () {
            $('#menu-affix').affix();
            /*
            * Clamped-width.
            * Usage:
            *  <div data-clampedwidth=".myParent">
            *    This long content will force clamped width
            *  </div>
            *
            * Author: LV
            */
            $('[data-clampedwidth]').each(function () {
                var elem = $(this);
                var parentPanel = elem.data('clampedwidth');
                var resizeFn = function () {
                    var sideBarNavWidth = $(parentPanel).width() - parseInt(elem.css('paddingLeft')) - parseInt(elem.css('paddingRight')) - parseInt(elem.css('marginLeft')) - parseInt(elem.css('marginRight')) - parseInt(elem.css('borderLeftWidth')) - parseInt(elem.css('borderRightWidth'));
                    elem.css('width', sideBarNavWidth);
                };

                resizeFn();
                $(window).resize(resizeFn);
            });
        });
    </script>
</%def>
