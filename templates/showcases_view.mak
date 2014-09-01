<%inherit file="lmkp:customization/lo/templates/base_no_menu.mak" />
<%page expression_filter="h"/>

<%def name="title()">${_('Show cases')}</%def>

<%def name="head_tags()">
<link rel="stylesheet" href="custom/css/bootstrap-lightbox.min.css"/>
<style type="text/css">
    a.read-more {
        cursor: pointer;
    }
    .blog-content {
        padding: 5px 0px;
    }
    .paragraph-header {
        padding-top: 10px;
        padding-bottom: 0px;
    }
    .showcase-header-row > div > h3 {
        padding: 15px 0px;
    }
</style>
</%def>

<%def name="body()">
<div class="row-fluid showcase-header-row">
    <div class="span10 offset1">
        <i class="icon-double-angle-left"></i>
        <a href="${request.route_url('index')}">${_('Back')}</a>
    </div>
</div>
<div class="row-fluid showcase-header-row">
    <div class="span10 offset1">
        <h3>${_('Context matters: linking land deals to socioeconomic and environmental characteristics of places')}</h3>
    </div>
</div>

<div class="row-fluid blog-content">
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
                    <img class="slide" src="/custom/img/slides/phin_accessibility_prvw.jpg" alt="${_('Accessibility in Phin district')}">
                    <div class="carousel-caption">
                        <p>${_('Analyze the accessibility of deals to the province capital')}</p>
                    </div>
                </div>

                <div class="item">
                    <img class="slide" src="/custom/img/slides/phin_landcover_prvw.jpg" alt="${_('See the land cover where current deals are located')}">
                    <div class="carousel-caption">
                        <p>${_('See the land cover where current deals are located')}</p>
                    </div>
                </div>

                <div class="item">
                    <img class="slide" src="/custom/img/slides/phin_popdensity_prvw.jpg" alt="${_('Compare deals with population density')}">
                    <div class="carousel-caption">
                        <p>${_('Compare deals with population density')}</p>
                    </div>
                </div>

                <div class="item">
                    <img class="slide" src="/custom/img/slides/phin_poverty_prvw.jpg" alt="${_('See the incidence of poverty where current land deals are located')}">
                    <div class="carousel-caption">
                        <p>${_('See the incidence of poverty where current land deals are located')}</p>
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

<div class="row-fluid blog-content">
    <div class="span10 offset1">
        ${_('As opposed to traditional tabular databases, the Land Observatory can be used to perform in-depth contextual analysis of the areas in which the land deals are taking place, and therefore provide a better insight on the socioeconomic and environmental conditions of places and the characteristics of the affected population.')}
    </div>
</div>
<div class="row-fluid">
    <div class="span10 offset1">
        <a data-toggle="tooltip" title="read more" class="read-more">
            ${_('Read more')}&nbsp;<i class="icon-double-angle-right"></i>
        </a>
    </div>
</div>
<div class="row-fluid blog-content hidden paragraph-header">
    <div class="span10 offset1">
        <h4>${_('Accessing background information')}</h4>
    </div>
</div>
<div class="row-fluid blog-content hidden">
    <div class="span10 offset1">
        <%
            link = '<a href="%s">Olam International</a>' % request.route_url('stakeholders_read_one', output='html', uid='f3360f25-a9a7-4b5a-862f-97b3e419ab1a')
        %>
        ${_("Looking at all documents and comments posted by users about the Paksong District in the Land Observatory, we learn that in 2009, the Lao Government granted a 30 years land concession to Outspan, a subsidiary of international agribusiness company %s. Reports indicate that in total, 4 villages and 275 households were affected by the expansion of coffee plantations. Due to the lack of prior consultation, low financial compensation offered, and clearing of land far beyond the limits of the granted area, a grassroots contestation movement emerged amongst the villagers, who seized the company's trucks, threatened to cut down the trees, and sent delegations to Vientiane to get back their lands.") % link|n}
    </div>
</div>
<div class="row-fluid blog-content hidden paragraph-header">
    <div class="span10 offset1">
        <h4>${_('Going further: looking at social and environmental context')}</h4>
    </div>
</div>
<div class="row-fluid blog-content hidden">
    <div class="span10 offset1">
        <%
            link = '<a href="%s">%s</a>' % (request.route_url('activities_read_one', output='html', uid='9b2891e8-159d-48b6-8828-c9666231253b'), _("Paksong case"))
        %>
        ${_("But thanks to its powerful mapping capacities, the Land Observatory allows much more than just looking at documents and background information. In the %s, for instance, displaying the density population layer shows that the concession has been granted in villages with very different population patterns, from very low to high density. While this gives an indication of the size of the population affected, far more interesting is to look at the socioeconomic characteristics of this population. Indeed, another geographic layer available shows that the proportion of households being farming households stands above 90%%. This most likely means that the population's livelihoods are strongly dependent upon land-related resources, and that their level of vulnerability to the loss of productive land is high if no appropriate coping mechanism is set-up.") % link|n}
    </div>
</div>
<div class="row-fluid blog-content hidden">
    <div class="span10 offset1">
        ${_("To better understand land deals and their impacts on local population, it is also critical to see their how they interact with surrounding or overlapping initiatives, land use types and geographic or environmental units such as national protected areas, river basins and watersheds, or regeneration forests. In Paksong, performing this type of analysis shows that while the area granted is not taking over on protected areas, it is surrounded by many other large-scale coffee concessions. Moreover, the land use layer, crosschecked with satellite images, shows that most of the area was initially covered by forests and small-scale croplands.")}
    </div>
</div>
<div class="row-fluid blog-content hidden">
    <div class="span10 offset1">
        ${_("Potential impacts that can be suspected based on these elements include a reduced access to non-timber forest products as a source of complementary income; a generalized increase in pressure over land resources; and, overall, a significant threat to the social and economic resilience of the local population, may the investors and the government fail to offer appropriate compensations and job opportunities.")}
    </div>
</div>
<div class="row-fluid blog-content hidden paragraph-header">
    <div class="span10 offset1">
        <h4>${_("Beyond the specific cases")}</h4>
    </div>
</div>
<div class="row-fluid blog-content hidden">
    <div class="span10 offset1">
        ${_("Beyond the specific cases, the observatory also helps getting the bigger picture of large-scale land acquisitions at the national level. One can display all deals matching a certain set of criteria (sector, country of origin, area, etc.) and analyze trends and patterns by overlaying contextual layers. One can for instance look at all Chinese investments and see if tend to be located in poor and remote areas. Equally, one can see on which type of land use agricultural concessions are located. User can perform limitless tailored-made analysis that responds to their specific needs and interests. By linking actors with the location of their interventions and claims, and the contextual information, the observatory provides the public, researchers and government agencies with a powerful tool for bottom-up monitoring and enhanced transparency in large-scale land acquisitions.")}
    </div>
</div>
<div class="row-fluid showcase-header-row">
    <div class="span10 offset1">
        <h3>
            ${_("Bottom-up monitoring of rubber plantations in Phine District")}
        </h3>
    </div>
</div>
<div class="row-fluid blog-content">
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
                    <img class="slide" src="/custom/img/slides/quasa_grantedarea_prvw.jpg" alt="${_("Granted concession area to Quasa Gueruco")}">
                    <div class="carousel-caption">
                        <p>${_('Concession area granted to Quasa Gueruco for rubber plantations')}</p>
                    </div>
                </div>
                <div class="item">
                    <img class="slide" src="/custom/img/slides/quasa_currentarea_prvw.jpg" alt="${_("Current used area by Quasa Gueruco")}">
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
        <%
            link = '<a href="%s">Quasa Gueruco</a>' % request.route_url('stakeholders_read_one', output='html', uid='50d23b89-253a-4562-b155-524a6e5e9921')
        %>
        ${_("In Phine District, Savannakhet Province, the Vietnamese state-owned group %s was granted 10'000 hectares for rubber plantations. In Nakanong village, villagers and officials started complaining when they saw that the company was clearing lands beyond the granted area. Supported by an international NGO, the villagers used satellite images overlaid to the districts land allocation maps to demonstrate the illegal expansion of the concession.") % link|n}
    </div>
</div>
<div class="row-fluid">
    <div class="span10 offset1">
        <a data-toggle="tooltip" title="read more" class="read-more">${_("Read more")}&nbsp;<i class="icon-double-angle-right"></i></a>
    </div>
</div>
<div class="row-fluid blog-content hidden">
    <div class="span10 offset1">
        <%
            link = '<a href="%s">%s</a>' % (request.route_url('activities_read_one', output='html', uid='b385975a-393c-4127-9cfc-f7957afd4897'), _("Phine district case"))
        %>
        ${_("These information were uploaded by users on the Land Observatory, one of which then submitted an updated version based on the newer satellite images available on the web, showing that despite all the complains of the communities on the ground, the expansion of the cleared area beyond the allocated land had not stopped. In the %s, the LO provides valuable information for researchers, local stakeholders, decision-makers. Less powerful actors are empowered by an easy access to critical information and the possibility to contribute to knowledge creation and dissemination of their own perspectives and claims. They are given a voice to raise their concerns, and a space to foster linkages with the global civil society through international platforms such as the land matrix or other similar networks and mechanisms.") % link|n}
    </div>
</div>
<div class="row-fluid showcase-header-row">
    <div class="span10 offset1">
        <h3 class="showcase-title">${_("Golden Triangle turns into gambling paradise")}</h3>
    </div>
</div>
<div class="row-fluid blog-content">
    <div class="span10 offset1">
        <a data-toggle="lightbox" href="#gt-casino">
            <img src="/custom/img/showcases/gt_casino_prvw.jpg" width="871" height="469" alt="${_("The Golden Triangle SEZ on satellite images")}"></img>
        </a>
    </div>
</div>
<div class="row-fluid blog-content">
    <div class="span10 offset1">
        <%
            link = '<a href="%s">%s</a>' % (request.route_url('activities_read_one', output='html', uid='6a5b9560-63b9-43e5-8637-168deee4e75f'), _("Golden Triangle Special Economic Zone"))
        %>
        ${_("In the case of the well-known %s granted for 99 years to the Chinese company Kings Roman, a number of Land Observatory users came together to enter, compare and crosscheck information. Facing some challenges to access certain data, they showed a level creativity that would probably not have happened as part a government-led data collection campaign.") % link|n}
    </div>
</div>
<div class="row-fluid blog-content">
    <div class="span10 offset1">
        <a data-toggle="tooltip" title="read more" class="read-more">${_("Read more")}&nbsp;<i class="icon-double-angle-right"></i></a>
    </div>
</div>
<div class="row-fluid blog-content hidden">
    <div class="span10 offset1">
        <%
            link = '<a href="https://www.google.com/maps/@20.3420757,100.0993729,1855m/data=!3m1!1e3!4m2!5m1!1b1">%s</a>' % _("constructions")
        %>
        ${_("As users could not find a map of the area allocated, they started a discussion thread via the comments section. At the beginning of the discussion, the latest Google and Bing satellite images available were 2008, and neither the huge casino nor the extensive surrounding infrastructures were visible. At this stage, the best that could be done was to approximately drop a point somewhere in the area. When eventually Google maps were upgraded and displayed images from 2012, the %s became clearly visible, giving a good indication of the location and extent of the concession. When one of the contributors posted a comment to inform that new images from 2012 were available on Google maps, someone with GIS skills almost immediately grasped the opportunity to digitize the concession area and share it via the Observatory. In the meantime, other users had uploaded additional background documents on this case from a variety of different sources and in a diversity of formats including reports, press articles, documentaries and promotional videos.") % link|n}
    </div>
</div>
<div class="row-fluid blog-content hidden">
    <div class="span10 offset1">
        <a data-toggle="lightbox" href="#gt-details">
            <img src="/custom/img/showcases/gt_details_prvw.jpg" width="871" alt="${_("Collected details and data sources about the Golden Triangle SEZ")}"></img>
        </a>
    </div>
</div>
<div class="row-fluid blog-content hidden">
    <div class="span10 offset1">
        <%
            link_1 = '<a href="http://www.rfa.org/english/news/laos/farmers-04112014180934.html">%s</a>' % _("villagers")
            link_2 = '<a href="http://www.decide.la">DECIDE Info</a>'
            link_3 = '<a href="http://www.laofab.org/">LaoFab</a>'
            link_4 = '<a href="https://www.youtube.com/watch?feature=player_detailpage&v=DrDoXSPxkAc#t=26">%s</a>' % _("Youtube video documentary")
        %>
        ${_("End of 2013, national and international media reported %s strongly opposing police forces assisting a team sent out to survey the land for the construction of an international airport in the area. The lack of prior consultation and the threat of being deprived of additional land pushed the villagers to take the risk to protest against a government decision. LO users, who were following the case tried to find out the location of the future airport. Once again facing a lack of information, a first contributor used %s (another open access web mapping application in Lao that provides hundreds of geographic layers) to locate all the villages that were mentioned in the media. Simultaneously, the ongoing debate was disseminated in %s, a thematic discussion group on land issues in Lao that connects over 3,000 registered members interested the topic. Finally, the location of the airport was identified based on a 3D map showed by a representative of the company to a journalist in a %s unveiled by LO user.") % (link_1, link_2, link_3, link_4)|n}
    </div>
</div>
<div class="row-fluid blog-content hidden">
    <div class="span10 offset1">
        ${_("Thanks to all these debates, sources and ideas, this specific deal is now much better documented, includes over 15 different sources such as press articles, reports and videos, and has significantly gained in spatial and thematic accuracy, despite the probably intentional retention of information.")}
    </div>
</div>
<div id="gt-casino" class="lightbox hide fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="lightbox-header">
        <button type="button" class="close" data-dismiss="lightbox" aria-hidden="true"><i class="icon-remove-sign">&nbsp;</i></button>
        <h4 class="lightbox-title">Modal title</h4>
    </div>
    <div class='lightbox-content'>
        <img src="/custom/img/showcases/gt_casino.jpg" alt="${_("The Golden Triangle SEZ on publicly accessible satellite images")}"></img>
        <div class="lightbox-caption"><p>${_("The Golden Triangle SEZ on publicly accessible satellite images")}</p></div>
    </div>
</div>

<div id="gt-details" class="lightbox hide fade"  tabindex="-1" role="dialog" aria-hidden="true">
    <div class="lightbox-header">
        <button type="button" class="close" data-dismiss="lightbox" aria-hidden="true"><i class="icon-remove-sign">&nbsp;</i></button>
        <h4 class="lightbox-title">Modal title</h4>
    </div>
    <div class='lightbox-content'>
        <img src="/custom/img/showcases/gt_details.jpg" alt="${_("Crowd-sourced details and data sources about the Golden Triangle SEZ")}"></img>
        <div class="lightbox-caption"><p>${_("Crowd-sourced details and data sources about the Golden Triangle SEZ")}</p></div>
    </div>
</div>

</%def>

<%def name="bottom_tags()">
    <script src="/custom/js/vendor/bootstrap-lightbox.min.js"></script>
</%def>
