<%inherit file="lmkp:customization/lo/templates/base_no_menu.mak" />

<%def name="head_tags()">
  <script type="text/javascript">
    jQuery(document).bind('keyup', function(e) {
      if(e.keyCode==39){
        jQuery('a.carousel-control.right').trigger('click');
      }
      else if(e.keyCode==37){
        jQuery('a.carousel-control.left').trigger('click');
      }
    });
  </script>
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
          <div class="start">
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
  <div class="row-fluid action">
      <div class="span2 offset1">
          ${_('Select a country')}
      </div>
      <div class="span3">
          <div class="country-selector">
             <div class="btn-group">
                 % if len(profiles) > 0:
                 <button class="btn btn-country-selector">${profiles[0][1]}</button>
                 <button class="btn btn_favorite_right dropdown-toggle" data-toggle="dropdown">
                     <i class="icon-caret-down"></i>
                 </button>
                 <ul class="dropdown-menu country-selector">
                     % for p in profiles:
                      <li><a href="/${p[1]}">${p[0]}</a></li>
                      % endfor
                 </ul>
                 % else:
                 <button class="btn btn-country-selector">${_('Global')}</button>
                 <button class="btn btn_favorite_right dropdown-toggle" data-toggle="dropdown">
                     <i class="icon-caret-down"></i>
                 </button>
                 <ul class="dropdown-menu country-selector">
                      <li><a href="/global">${_('Global')}</a></li>
                 </ul>
                 % endif
             </div>
          </div>
      </div>
  </div>
  % endif

  <div class="row-fluid not-action">
      <div class="span offset1">
          ${_('Or take a short tour:')}
      </div>
  </div>

  <div class="row-fluid">
      <div class="span10 offset1">

          <!-- slider -->
          <div id="myCarousel" class="carousel slide">
              <ol class="carousel-indicators">
                  <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                  <li data-target="#myCarousel" data-slide-to="1"></li>
                  <li data-target="#myCarousel" data-slide-to="2"></li>
                  <li data-target="#myCarousel" data-slide-to="3"></li>
                  <li data-target="#myCarousel" data-slide-to="4"></li>
                  <li data-target="#myCarousel" data-slide-to="5"></li>
                  <li data-target="#myCarousel" data-slide-to="6"></li>
              </ol>

              <!-- Carousel items -->
              <div class="carousel-inner">


                  <div class="item active">
<!--                                                <div class="not-action2">
                          Or take a short tour.
                      </div>-->
                      <img class="slide" src="/custom/img/slides/slider-image_02.png" alt="">
                      <div class="carousel-caption">
                          <p>${_('Users in select pilot countries gather, explore and analyze spatial data on large-scale land acquisitions. Data is managed and reviewed locally by partners.')}</p>
                      </div>
                  </div>

                  <div class="item">
                      <img class="slide" src="/custom/img/slides/slider-image_03.png" alt="">
                      <div class="carousel-caption">
                          <p>${_('Users can see deals in full geographical context, learn more about investors and the kinds of investments in question.')}</p>
                      </div>
                  </div>

                  <div class="item">
                      <img class="slide" src="/custom/img/slides/slider-image_04.png" alt="">
                      <div class="carousel-caption">
                          <p>${_('You can also select a specific land deal to see more: "who" (investors and other stakeholders) and "what" the land will be used for.')}</p>
                      </div>
                  </div>

                  <div class="item">
                      <img class="slide" src="/custom/img/slides/slider-image_05.png" alt="">
                      <div class="carousel-caption">
                          <p>${_('You can go further and learn more about an investor, seeing the same investor''s other land deals.')}</p>
                      </div>
                  </div>

                  <div class="item">
                      <img class="slide" src="/custom/img/slides/slider-image_06.png" alt="">
                      <div class="carousel-caption">
                          <p>${_('Logged in users can also help contribute and update data, and anybody can freely comment on it.')}</p>
                      </div>
                  </div>

                  <div class="item">
                      <img class="slide" src="/custom/img/slides/slider-image_07.png" alt="">
                      <div class="carousel-caption">
                          <p>${_('You can filter the land deals by various attributes - like size, or crop. Or make a spatial selection of land deals.')}</p>
                      </div>
                  </div>

                  <div class="item">
                      <img class="slide" src="/custom/img/slides/slider-image_08.png" alt="">
                      <div class="carousel-caption">
                          <p>${_('Want to know if anybody lives on a concession? Use the context layers to view population density and more.')}</p>
                      </div>
                  </div>

              </div>

              <!-- Carousel nav -->
              <div class="carousel-controls">
                      <a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
                      <a class="carousel-control right" href="#myCarousel" data-slide="next">&rsaquo;</a>
              </div>

          </div>
      </div>

  </div>

  <div class="row-fluid not-action">
      <div class="span10 offset1">
          ${_('Are you interested in concrete use cases of the Land Observatory?')}<br/>
          <a href="${request.route_url('showcases_view')}">${_('Check out the showcases!')}</a>
      </div>
  </div>
</%def>
