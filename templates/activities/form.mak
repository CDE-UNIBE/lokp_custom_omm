<%inherit file="lokp:customization/omm/templates/base.mak" />

<%def name="title()">${_('Deal Editor')}</%def>

<%def name="head_tags()">
    <link rel="stylesheet" href="/static/css/form.css" type="text/css" />

    <script type="text/javascript" src="${request.static_url('lokp:static/js/form.js')}"></script>

    <!-- REQUIREMENTS -->
    % for reqt in css_links:
        <link rel="stylesheet" href="${request.static_url(reqt)}" type="text/css" />
    % endfor
    % for reqt in js_links:
        % if reqt.startswith('/app'):
            <script type="text/javascript" src="${reqt}"></script>
        % else:
            <script type="text/javascript" src="${request.static_url(reqt)}"></script>
        % endif
    % endfor

    <script type="text/javascript">
       jQuery.fn.autocompleteJQuery = jQuery.fn.autocomplete;
    </script>

    % if js:
        <script type="text/javascript">${js|n}</script>
    % endif
</%def>


<div class="container deal-edit-content">
    <div class="content no-border">
        ## Session messages
        <%include file="lokp:templates/parts/sessionmessage.mak"/>

        ${form | n}
    </div>
</div>


<%def name="bottom_tags()">
    <script type="text/javascript">

        var identifier = '${uid}';
        var version = ${version};

        if (deform) {
            deform.load();
        }

        $(document).ready(function () {
            $('.collapsible').collapsible();

            $('.datepicker').pickadate({
                selectMonths: true, // Creates a dropdown to control month
                selectYears: 15} // Creates a dropdown of 15 years to control year
            );

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

            Materialize.updateTextFields();
            deform.load();
        });


    </script>
</%def>

