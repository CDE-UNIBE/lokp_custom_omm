<%inherit file="lmkp:customization/omm/templates/base.mak" />

<%def name="title()">${_("User Registration")}</%def>

<%def name="head_tags()">

    <!-- REQUIREMENTS -->
    <!-- CSS -->
    % for reqt in css_links:
    <!--link rel="stylesheet" href="/formstatic/${reqt}" type="text/css" /-->
    % endfor
    % for reqt in js_links:
        <script type="text/javascript" src="/formstatic/${reqt}"></script>
    % endfor
</%def>

<div class="container">
    <div class="content no-border">
        <h3 class="registration-title">${_('Register')}</h3>
        <p class="registration-text">${_('Please register for the Land Observatory.')}</p>
        ${form | n}
    </div>
</div>

<%def name="bottom_tags()">
    <script type="text/javascript">
       deform.load();
    </script>
</%def>

