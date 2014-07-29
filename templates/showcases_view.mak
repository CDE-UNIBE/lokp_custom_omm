<%
from lmkp.views.views import getQueryString
from lmkp.views.translation import get_profiles
from lmkp.views.translation import get_languages
profiles = sorted(get_profiles(), key=lambda profile: profile[0])
languages = get_languages()
selectedlanguage = languages[0]
for l in languages:
    if locale == l[0]:
        selectedlanguage = l
mode = None
if 'lmkp.mode' in request.registry.settings:
    if str(request.registry.settings['lmkp.mode']).lower() == 'demo':
        mode = 'demo'

use_piwik_analytics = False
if 'lmkp.use_piwik_analytics' in request.registry.settings:
    if str(request.registry.settings['lmkp.use_piwik_analytics']).lower() == "true":
        use_piwik_analytics = True
%>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta name="content-language" content="${selectedlanguage[0]}" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>${_('Land Observatory')}</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">

        <link rel="stylesheet" href="/custom/css/bootstrap-combined.no-icons.min.css">
        <link rel="stylesheet" href="/custom/css/font-awesome/css/font-awesome.min.css">

        <link rel="stylesheet" href="/custom/css/bootstrap-responsive.min.css">
        <link rel="stylesheet" href="/custom/css/bootstrap-lightbox.min.css">
        <link rel="stylesheet" href="/custom/css/main.css">

        <link rel="stylesheet" href="/custom/css/custom.css">

        <!--[if IE 7]>

            <link rel="stylesheet" href="/custom/css/ie7.css">
            <link rel="stylesheet" href="/custom/css/font-awesome/css/font-awesome-ie7.css">

        <![endif]-->

        <!--[if IE 8]>

            <link rel="stylesheet" href="/custom/css/ie8.css')}">

        <![endif]-->

        <script src="/custom/js/vendor/modernizr-2.6.2-respond-1.1.0.min.js"></script>
        <script src="/custom/js/vendor/jquery-1.9.1.min.js"></script>

        <style type="text/css">
            .user {
                margin-top: -8px;
                padding-right: 0;
            }
            #main {
                padding-bottom: 50px;
            }
            .wrap {
                margin: 0 auto -50px;
            }
            .header_self {
                height: inherit;
                max-height: none;
            }
            .lo_logo {
                margin: 0 0 5px 5px;
            }
            a[title="read more"] {
                cursor: pointer;
            }
        </style>

        <script type="text/javascript">

            jQuery(document).bind('keyup', function(e) {

                if (e.keyCode == 39) {
                    jQuery('a.carousel-control.right').trigger('click');
                }

                else if (e.keyCode == 37) {
                    jQuery('a.carousel-control.left').trigger('click');
                }

            });

        </script>

    </head>
    <body>
        <!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->

        <div class="wrap">

            <!-- Header  -->

            <div id="main" class="clearfix">

                <div class="navbar header_self">
                    <div class="container">
                        <div class="row-fluid hidden-phone">
                            <div class="span3 text-right">
                                % if mode == 'demo':
                                <img src="/custom/img/logo_demo.png" class="lo_logo" alt="${_('Land Observatory')}" />
                                % else:
                                <img src="/custom/img/logo.png" class="lo_logo" alt="${_('Land Observatory')}" />
                                % endif
                            </div>

                            <div class="span6 landing-introduction">
                                <p>
                                    <strong>${_('The Land Observatory')} </strong>${_('is a pilot project by some partners of the')} <a href="http://www.landmatrix.org">${_('Land Matrix')}</a>, ${_('designed to provide greater context and deeper insight on land deals, from a more local perspective.')}
                                </p>
                            </div>
                            <div class="user">
                                <ul class="nav nav-pills">
                                    <li>
                                        <div class="dropdown">
                                            <a class="dropdown-toggle blacktemp" data-toggle="dropdown" href="#">
                                                ${selectedlanguage[1]}
                                                <b class="caret"></b>
                                            </a>
                                            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
                                                % for l in languages:
                                                <li class="cursor">
                                                    <a href="${getQueryString(request.url, add=[('_LOCALE_', l[0])])}">${l[1]}</a>
                                                </li>
                                                % endfor
                                            </ul>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="row-fluid visible-phone">
                            <div class="span3">
                                <a href="${request.route_url('index')}">
                                    <img src="custom/img/logo.png" class="lo_logo" />
                                </a>
                            </div>
                            <div class="span6 landing-introduction">
                                <p>
                                    <strong>${_('The Land Observatory')} </strong>${_('is a pilot project by some partners of the')} <a href="http://www.landmatrix.org">${_('Land Matrix')}</a>, ${_('designed to provide greater context and deeper insight on land deals, from a more local perspective.')}
                                </p>
                            </div>
                            <div class="span3">
                                <div class="user">
                                    <ul class="nav nav-pills">
                                        <li>
                                            <div class="dropdown">
                                                <a class="dropdown-toggle blacktemp" data-toggle="dropdown" href="#">
                                                    ${selectedlanguage[1]}
                                                    <b class="caret"></b>
                                                </a>
                                                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
                                                    % for l in languages:
                                                    <li class="cursor">
                                                        <a href="${getQueryString(request.url, add=[('_LOCALE_', l[0])])}">${l[1]}</a>
                                                    </li>
                                                    % endfor
                                                </ul>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- content -->

                <div class="container">
                    <div class="content no-border">

                        <div class="row-fluid">
                            <div class="span10 offset1">
                                <h3>Context matters: linking land deals to socioeconomic and environmental characteristics of places</h3>
                            </div>
                        </div>

                        <div class="row-fluid">
                            <div class="span10 offset1">

                                <!-- slider -->
                                <div id="se-carousel" class="carousel slide">
                                    <ol class="carousel-indicators">
                                        <li data-target="#se-carousel" data-slide-to="0" class="active"></li>
                                        <li data-target="#se-carousel" data-slide-to="1"></li>
                                        <li data-target="#se-carousel" data-slide-to="2"></li>
                                        <li data-target="#se-carousel" data-slide-to="3"></li>
                                    </ol>

                                    <!-- Carousel items -->
                                    <div class="carousel-inner">
                                        <div class="item active">
                                            <img class="slide" src="/custom/img/slides/phin_accessibility_prvw.jpg" alt="Accessibility in Phin district">
                                            <div class="carousel-caption">
                                                <p>${_('Users in select pilot countries gather, explore and analyze spatial data on large-scale land acquisitions. Data is managed and reviewed locally by partners.')}</p>
                                            </div>
                                        </div>

                                        <div class="item">
                                            <img class="slide" src="/custom/img/slides/phin_landcover_prvw.jpg" alt="">
                                            <div class="carousel-caption">
                                                <p>${_('Users can see deals in full geographical context, learn more about investors and the kinds of investments in question.')}</p>
                                            </div>
                                        </div>

                                        <div class="item">
                                            <img class="slide" src="/custom/img/slides/phin_popdensity_prvw.jpg" alt="">
                                            <div class="carousel-caption">
                                                <p>${_('You can also select a specific land deal to see more: "who" (investors and other stakeholders) and "what" the land will be used for.')}</p>
                                            </div>
                                        </div>

                                        <div class="item">
                                            <img class="slide" src="/custom/img/slides/phin_poverty_prvw.jpg" alt="">
                                            <div class="carousel-caption">
                                                <p>${_('You can go further and learn more about an investor, seeing the same investor''s other land deals.')}</p>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Carousel nav -->
                                    <div class="carousel-controls">
                                        <a class="carousel-control left" href="#se-carousel" data-slide="prev">&lsaquo;</a>
                                        <a class="carousel-control right" href="#se-carousel" data-slide="next">&rsaquo;</a>
                                    </div>

                                </div>
                            </div>

                        </div>

                        <div class="row-fluid">
                            <div class="span10 offset1">
                                As opposed to traditional tabular databases, the Land Observatory can be used to perform in-depth contextual
                                analysis of the areas in which the land deals are taking place, and therefore provide a better insight on the
                                socioeconomic and environmental conditions of places and the characteristics of the affected population.
                            </div>
                        </div>
                        <div class="row-fluid">
                            <div class="span10 offset1">
                                <a data-toggle="tooltip" title="read more" class="read-more">Read more&nbsp;<i class="icon-double-angle-right"></i></a>
                            </div>
                        </div>
                        <div class="row-fluid blog-content hidden">
                            <div class="span10 offset1">
                                <h4>Accessing background information</h4>
                                Looking at all documents and comments posted by users about the Paksong District in the Land Observatory,
                                we learn that in 2009, the Lao Government granted a 30 years land concession to Outspan, a subsidiary of
                                international agribusiness company Olam International. Reports indicate that in total, 4 villages and 275 households
                                were affected by the expansion of coffee plantations. Due to the lack of prior consultation, low financial
                                compensation offered, and clearing of land far beyond the limits of the granted area, a grassroots contestation
                                movement emerged amongst the villagers, who seized the company’s trucks, threatened to cut down the trees, and
                                sent delegations to Vientiane to get back their lands.
                            </div>
                        </div>
                        <div class="row-fluid hidden blog-content">
                            <div class="span10 offset1">
                                <h4>Going further: looking at social and environmental context</h4>
                                But thanks to its powerful mapping capacities, the Land Observatory allows much more than just looking at documents
                                and background information.<br/>
                                In the Paksong case, for instance, displaying the density population layer shows that the concession has been granted
                                in villages with very different population patterns, from very low to high density.  While this gives an indication of
                                the size of the population affected, far more interesting is to look at the socioeconomic characteristics of this
                                population. Indeed, another geographic layer available shows that the proportion of households being farming households
                                stands above 90%. This most likely means that the population’s livelihoods are strongly dependent upon land-related
                                resources, and that their level of vulnerability to the loss of productive land is high if no appropriate coping mechanism
                                is set-up.<br/>
                                To better understand land deals and their impacts on local population, it is also critical to see their how they interact
                                with surrounding or overlapping initiatives, land use types and geographic or environmental units such as national
                                protected areas, river basins and watersheds, or regeneration forests. In Paksong, performing this type of analysis shows
                                that while the area granted is not taking over on protected areas, it is surrounded by many other large-scale coffee concessions. 
                                Moreover, the land use layer, crosschecked with satellite images, shows that most of the area was initially covered by forests
                                and small-scale croplands.<br/>
                                Potential impacts that can be suspected based on these elements include a reduced access to non-timber forest products
                                as a source of complementary income; a generalized increase in pressure over land resources; and, overall, a significant
                                threat to the social and economic resilience of the local population, may the investors and the government fail to offer
                                appropriate compensations and job opportunities.
                            </div>
                        </div>
                        <div class="row-fluid hidden blog-content">
                            <div class="span10 offset1">
                                <h4>Beyond the specific cases</h4>
                                Beyond the specific cases, the observatory also helps getting the bigger picture of large-scale land acquisitions at the
                                national level. One can display all deals matching a certain set of criteria (sector, country of origin, area, etc.) and
                                analyze trends and patterns by overlaying contextual layers. One can for instance look at all Chinese investments and see
                                if tend to be located in poor and remote areas. Equally, one can see on which type of land use agricultural concessions
                                are located. User can perform limitless tailored-made analysis that responds to their specific needs and interests. 
                                By linking actors with the location of their interventions and claims, and the contextual information, the observatory
                                provides the public, researchers and government agencies with a powerful tool for bottom-up monitoring and enhanced
                                transparency in large-scale land acquisitions.
                            </div>
                        </div>
                        <div class="row-fluid">
                            <div class="span10 offset1">
                                <h3>
                                    Bottom-up monitoring of rubber plantations in Phine District
                                </h3>
                            </div>
                        </div>
                        <div class="row-fluid">
                            <div class="span10 offset1">
                                <!-- slider -->
                                <div id="areacomparison-carousel" class="carousel slide">
                                    <ol class="carousel-indicators">
                                        <li data-target="#areacomparison-carousel" data-slide-to="0" class="active"></li>
                                        <li data-target="#areacomparison-carousel" data-slide-to="1"></li>
                                    </ol>
                                    <!-- Carousel items -->
                                    <div class="carousel-inner">
                                        <div class="item active">
                                            <img class="slide" src="/custom/img/slides/quasa_grantedarea_prvw.jpg" alt="Granted concession area to Quasa Gueruco">
                                            <div class="carousel-caption">
                                                <p>${_('Concession area granted to Quasa Gueruco for rubber plantations')}</p>
                                            </div>
                                        </div>
                                        <div class="item">
                                            <img class="slide" src="/custom/img/slides/quasa_currentarea_prvw.jpg" alt="Current used area by Quasa Gueruco">
                                            <div class="carousel-caption">
                                                <p>${_('Currently used area compared to the granted area')}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Carousel nav -->
                                    <div class="carousel-controls">
                                        <a class="carousel-control left" href="#areacomparison-carousel" data-slide="prev">&lsaquo;</a>
                                        <a class="carousel-control right" href="#areacomparison-carousel" data-slide="next">&rsaquo;</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row-fluid blog-content">
                            <div class="span10 offset1">
                                In Phine District, Savannakhet Province, the Vietnamese state-owned group Quasa Gueruco was granted 10’000 hectares for
                                rubber plantations. In Nakanong village, villagers and officials started complaining when they saw that the company
                                was clearing lands beyond the granted area. Supported by an international NGO, the villagers used satellite images
                                overlaid to the districts land allocation maps to demonstrate the illegal expansion of the concession.
                            </div>
                        </div>
                        <div class="row-fluid">
                            <div class="span10 offset1">
                                <a data-toggle="tooltip" title="read more" class="read-more">Read more&nbsp;<i class="icon-double-angle-right"></i></a>
                            </div>
                        </div>
                        <div class="row-fluid blog-content hidden">
                            <div class="span10 offset1">
                                These information were uploaded by users on the Land Observatory, one of which then submitted an updated version based
                                on the newer satellite images available on the web, showing that despite all the complains of the communities on the ground,
                                the expansion of the cleared area beyond the allocated land had not stopped. In the Phine district case, the LO provides
                                valuable information for researchers, local stakeholders, decision-makers. Less powerful actors are empowered by an easy
                                access to critical information and the possibility to contribute to knowledge creation and dissemination of their own
                                perspectives and claims. They are given a voice to raise their concerns, and a space to foster linkages with the global
                                civil society through international platforms such as the land matrix or other similar networks and mechanisms. 
                            </div>
                        </div>
                        <div class="row-fluid">
                            <div class="span10 offset1">
                                <h3 class="showcase-title">Golden Triangle turns into gambling paradise</h3>
                            </div>
                        </div>
                        <div class="row-fluid">
                            <div class="span10 offset1">
                                <a data-toggle="lightbox" href="#gt-casino">
                                    <img src="/custom/img/showcases/gt_casino_prvw.jpg" width="871" height="469" alt="The Golden Triangle SEZ on satellite images"></img>
                                </a>
                            </div>
                        </div>
                        <div class="row-fluid">
                            <div class="span10 offset1">
                                In the case of the well-known Golden Triangle Special Economic Zone granted for 99 years to the Chinese company Kings Roman,
                                a number of Land Observatory users came together to enter, compare and crosscheck information. Facing some challenges to
                                access certain data, they showed a level creativity that would probably not have happened as part a government-led data
                                collection campaign.
                            </div>
                        </div>
                        <div class="row-fluid">
                            <div class="span10 offset1">
                                <a data-toggle="tooltip" title="read more" class="read-more">Read more&nbsp;<i class="icon-double-angle-right"></i></a>
                            </div>
                        </div>
                        <div class="row-fluid hidden blog-content">
                            <div class="span10 offset1">
                                As users could not find a map of the area allocated, they started a discussion thread via the comments section. At the
                                beginning of the discussion, the latest Google and Bing satellite images available were 2008, and neither the huge casino
                                nor the extensive surrounding infrastructures were visible. At this stage, the best that could be done was to approximately
                                drop a point somewhere in the area.  When eventually Google maps were upgraded and displayed images from 2012,
                                the constructions became clearly visible, giving a good indication of the location and extent of the concession.
                                When one of the contributors posted a comment to inform that new images from 2012 were available on Google maps, someone
                                with GIS skills almost immediately grasped the opportunity to digitize the concession area and share it via the Observatory.
                                In the meantime, other users had uploaded additional background documents on this case from a variety of different sources
                                and in a diversity of formats including reports, press articles, documentaries and promotional videos.
                            </div>
                        </div>
                        <div class="row-fluid hidden blog-content">
                            <div class="span10 offset1">
                                <a data-toggle="lightbox" href="#gt-details">
                                    <img src="/custom/img/showcases/gt_details_prvw.jpg" width="871" alt="Collected details and data sources about the Golden Triangle SEZ"></img>
                                </a>
                            </div>
                        </div>
                        <div class="row-fluid hidden blog-content">
                            <div class="span10 offset1">
                                End of 2013, national and international media reported villagers strongly opposing police forces assisting a team sent out
                                to survey the land for the construction of an international airport in the area. The lack of prior consultation and the 
                                threat of being deprived of additional land pushed the villagers to take the risk to protest against a government decision.
                                LO users, who were following the case tried to find out the location of the future airport. Once again facing a lack of
                                information, a first contributor used Decide Info (another open access web mapping application in Lao that provides hundreds
                                of geographic layers) to locate all the villages that were mentioned in the media. Simultaneously, the ongoing debate was
                                disseminated in LaoFab, a thematic discussion group on land issues in Lao that connects over 3,000 registered members
                                interested the topic. Finally, the location of the airport was identified based on a 3D map showed by a representative of
                                the company to a journalist in a Youtube video documentary unveiled by LO user.<br/>
                                Thanks to all these debates, sources and ideas, this specific deal is now much better documented, includes over 15 different
                                sources such as press articles, reports and videos, and has significantly gained in spatial and thematic accuracy,
                                despite the probably intentional retention of information
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="gt-casino" class="lightbox hide fade"  tabindex="-1" role="dialog" aria-hidden="true">
                <div class="lightbox-header">
                    <button type="button" class="close" data-dismiss="lightbox" aria-hidden="true"><i class="icon-remove-sign">&nbsp;</i></button>
                    <h4 class="lightbox-title">Modal title</h4>
                </div>
                <div class='lightbox-content'>
                    <img src="/custom/img/showcases/gt_casino.jpg" alt="The Golden Triangle SEZ on publicly accessible satellite images"></img>
                    <div class="lightbox-caption"><p>The Golden Triangle SEZ on publicly accessible satellite images</p></div>
                </div>
            </div>

            <div id="gt-details" class="lightbox hide fade"  tabindex="-1" role="dialog" aria-hidden="true">
                <div class="lightbox-header">
                    <button type="button" class="close" data-dismiss="lightbox" aria-hidden="true"><i class="icon-remove-sign">&nbsp;</i></button>
                    <h4 class="lightbox-title">Modal title</h4>
                </div>
                <div class='lightbox-content'>
                    <img src="/custom/img/showcases/gt_details.jpg" alt="Crowd-sourced details and data sources about the Golden Triangle SEZ"></img>
                    <div class="lightbox-caption"><p>Crowd-sourced details and data sources about the Golden Triangle SEZ</p></div>
                </div>
            </div>

            <div class="landing-page-push">
            </div>

        </div>

        <div class="navbar footer landing-page-footer">
            <ul class="nav pull-right">
                <%
                # The entries of the footer as arrays with
                # - url
                # - name
                footer = [
                [request.route_url('faq_view'), _('FAQ')],
                [request.route_url('about_view'), _('About')],
                [request.route_url('partners_view'), _('Partners & Donors')]
                ]
                %>

                % for f in footer:
                <li
                    % if request.current_route_url() == f[0]:
                    class="active"
                    % endif
                    >
                    <a href="${f[0]}">${f[1]}</a>
                </li>
                % endfor
            </ul>
        </div>

        <script type="text/javascript">
            /* <![CDATA[ */
            document.write(unescape("%3Cscript src='" + (("https:" == document.location.protocol) ? "https://" : "http://") + "www.google.com/jsapi' type='text/javascript'%3E%3C/script%3E"));
            /* ]]> */
        </script>

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="/custom/js/vendor/jquery-1.9.1.min.js"><\/script>')</script>

        <script src="/custom/js/vendor/bootstrap.min.js"></script>
        <script src="/custom/js/vendor/bootstrap-lightbox.min.js"></script>

        <script src="/custom/js/main.js"></script>

        % if use_piwik_analytics==True:
        <!-- Piwik -->
        <script type="text/javascript">
            var _paq = _paq || [];
            _paq.push(["trackPageView"]);
            _paq.push(["enableLinkTracking"]);

            (function() {
                var u = (("https:" == document.location.protocol) ? "https" : "http") + "://webstats.landobservatory.org/";
                _paq.push(["setTrackerUrl", u + "piwik.php"]);
                _paq.push(["setSiteId", "1"]);
                var d = document, g = d.createElement("script"), s = d.getElementsByTagName("script")[0];
                g.type = "text/javascript";
                g.defer = true;
                g.async = true;
                g.src = u + "piwik.js";
                s.parentNode.insertBefore(g, s);
            })();
        </script>
        <!-- End Piwik Code -->
        % endif
    </body>
</html>
