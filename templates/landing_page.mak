<%inherit file="lmkp:customization/omm/templates/base_no_menu.mak" />

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
      <p>${_('Welcome to the')} <strong>${_('Demonstration Version')}</strong> ${_('of the')} <a href="http://www.landobservatory.org">${_('Myanmar land reporting')}</a>. ${_('This demo version is for learning and experimentation purposes, so first-time users can get a feel for the Observatory and its functions.')}</p>
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

<br><br>
<a href="/myanmar" class="btn"><i class="material-icons left ">public</i>${_('Enter')}</a>

<br><br><br><br><br>
<h5>${_('Or take a short tour:')}</h5>

<div class="slider slider-landingpage">
    <ul class="slides">
        <li>
            <img src="/custom/img/slides/test.jpg">
            <div class="caption right-align">
                <h3>Overview</h3>
                <h5 class="light grey-text text-lighten-3">
                    ${_('Users in select pilot countries gather, explore and analyze spatial data on large-scale land acquisitions. Data is managed and reviewed locally by partners.')}
                </h5>
            </div>
        </li>
        <li>
            <img src="/custom/img/slides/test2.jpg">
            <div class="caption left-align">
                <h3>Deals</h3>
                <h5 class="light grey-text text-lighten-3">
                    ${_('Users can see deals in full geographical context, learn more about investors and the kinds of investments in question.')}
                </h5>
            </div>
        </li>
        <li>
            <img src="/custom/img/slides/test3.jpg">
            <div class="caption right-align">
                <h3>Context Layers</h3>
                <h5 class="light grey-text text-lighten-3">
                    ${_('Want to know if anybody lives on a concession? Use the context layers to view population density and more.')}
                </h5>
            </div>
        </li>
    </ul>
</div>

% endif

</%def>
