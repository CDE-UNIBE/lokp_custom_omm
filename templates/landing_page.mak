<%inherit file="lmkp:customization/lo/templates/base_no_menu.mak" />

<%def name="head_tags()">

</%def>

<%def name="body()">
<%
from lmkp.views.translation import get_profiles
profiles = sorted(get_profiles(), key=lambda profile: profile[0])
%>


% if mode == 'demo':
<div class="row-fluid">
  <div class="span10 offset1">
      <p>${_('Welcome to the')} <strong>${_('Demonstration Version')}</strong> ${_('of the')} <a href="http://www.landobservatory.org">${_('Land Observatory')}</a>. ${_('This demo version is for learning and experimentation purposes, so first-time users can get a feel for the Observatory and its functions.')}</p>
      <div class="starst">
          <div class="btn-group">
              <a href="/global" class="btn btn-start">${_('Enter')}</a>
              <a href="/global" class="btn btn_favorite_right dropdown-toggle">
                  <i class="icon-caret-right"></i>
              </a>
          </div>
      </div>
  </div>
</div>
% else:

<!-- Dropdown Trigger -->
<a class='dropdown-button btn' href='#' data-activates='dropdown2' style="margin-top: 50px;">${_('Select a country')}<i class="material-icons right">arrow_drop_down</i></a>
<!-- Dropdown Structure -->
<ul id='dropdown2' class='dropdown-content'>
    % if len(profiles) > 0:
        % for p in profiles:
        <li><a href="/${p[1]}">${p[0].capitalize()}</a></li>
        % endfor
    % else:
        <li><a href="/global">${_('Global')}</a></li>
    % endif
</ul>

<div style="width: 100%; margin-top: 80px;">
    <h5>${_('Or take a short tour:')}</h5>
</div>

<div class="slider" style="margin-top: 20px; height: 450px !important;">
    <ul class="slides">
        <li>
            <img src="/custom/img/slides/test.jpg" style="height: 100% !important;">
            <div class="caption right-align">
                <h3 style="color: teal; text-shadow: 1px 1px 1px #000;">Overview</h3>
                <h5 class="light grey-text text-lighten-3" style="text-shadow: 1px 1px 1px #000;">
                    ${_('Users in select pilot countries gather, explore and analyze spatial data on large-scale land acquisitions. Data is managed and reviewed locally by partners.')}
                </h5>
            </div>
        </li>
        <li>
            <img src="/custom/img/slides/test2.jpg">
            <div class="caption left-align">
                <h3 style="color: teal; text-shadow: 1px 1px 1px #000;">Deals</h3>
                <h5 class="light grey-text text-lighten-3" style="text-shadow: 1px 1px 1px #000;">
                    ${_('Users can see deals in full geographical context, learn more about investors and the kinds of investments in question.')}
                </h5>
            </div>
        </li>
        <li>
            <img src="/custom/img/slides/test3.jpg">
            <div class="caption right-align">
                <h3 style="color: teal; text-shadow: 1px 1px 1px #000;">Context Layers</h3>
                <h5 class="light grey-text text-lighten-3" style="text-shadow: 1px 1px 1px #000;">
                    ${_('Want to know if anybody lives on a concession? Use the context layers to view population density and more.')}
                </h5>
            </div>
        </li>
    </ul>
</div>
<script type="text/javascript">
    $('.slider').slider({full_width: true});
</script>

% endif


<p style="margin-top: 80px;">${_('Are you interested in concrete use cases of the Land Observatory?')}</p>
</br>
<a class="waves-effect waves-light btn" href="${request.route_url('showcases_view')}">${_('Check out the showcases!')}</a>

</%def>
