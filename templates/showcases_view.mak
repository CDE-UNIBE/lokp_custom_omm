<%inherit file="lmkp:customization/lo/templates/base_no_menu.mak" />
<%page expression_filter="h"/>

<%def name="title()">${_('Show cases')}</%def>

<%def name="head_tags()">



</%def>


<%def name="body()">


    <a class="btn-floating btn-large waves-effect waves-light btn btn-back" href="${request.route_url('index')}">
        <i class="material-icons">arrow_back</i>${_('Back')}
    </a>



    ## Showcase 1

    <h3>${_('Context matters: linking land deals to socioeconomic and environmental characteristics of places')}</h3>
    <div class="slider slider-showcases">
        <ul class="slides slides-showcases">
            <li>
                <img src="/custom/img/slides/phin_accessibility_prvw.jpg">
            </li>
            <li>
                <img src="/custom/img/slides/phin_landcover_prvw.jpg">
            </li>
            <li>
                <img src="/custom/img/slides/phin_popdensity_prvw.jpg">
            </li>
            <li>
                <img src="/custom/img/slides/phin_poverty_prvw.jpg">
            </li>
        </ul>
    </div>

    <p class="main-text">
        ${_('As opposed to traditional tabular databases, the Land Observatory can be used to perform in-depth contextual analysis of the areas in which the land deals are taking place, and therefore provide a better insight on the socioeconomic and environmental conditions of places and the characteristics of the affected population.')}
    </p>

    <a class="waves-effect waves-light btn btn-read-more" onclick="$('#showcase1').fadeIn(); $(this).hide();">${_('Read more')}</a>
    <div class="showcase" id="showcase1">
        <h4>${_('Accessing background information')}</h4>
        <%
            link = '<a href="%s">Olam International</a>' % request.route_url('stakeholders_read_one', output='html', uid='f3360f25-a9a7-4b5a-862f-97b3e419ab1a')
        %>
        <p>
            ${_("Looking at all documents and comments posted by users about the Paksong District in the Land Observatory, we learn that in 2009, the Lao Government granted a 30 years land concession to Outspan, a subsidiary of international agribusiness company %s. Reports indicate that in total, 4 villages and 275 households were affected by the expansion of coffee plantations. Due to the lack of prior consultation, low financial compensation offered, and clearing of land far beyond the limits of the granted area, a grassroots contestation movement emerged amongst the villagers, who seized the company's trucks, threatened to cut down the trees, and sent delegations to Vientiane to get back their lands.") % link|n}
        </p>

        <h4>${_('Going further: looking at social and environmental context')}</h4>
        <%
            link = '<a href="%s">%s</a>' % (request.route_url('activities_read_one', output='html', uid='9b2891e8-159d-48b6-8828-c9666231253b'), _("Paksong case"))
        %>
        <p>
            ${_("But thanks to its powerful mapping capacities, the Land Observatory allows much more than just looking at documents and background information. In the %s, for instance, displaying the density population layer shows that the concession has been granted in villages with very different population patterns, from very low to high density. While this gives an indication of the size of the population affected, far more interesting is to look at the socioeconomic characteristics of this population. Indeed, another geographic layer available shows that the proportion of households being farming households stands above 90%%. This most likely means that the population's livelihoods are strongly dependent upon land-related resources, and that their level of vulnerability to the loss of productive land is high if no appropriate coping mechanism is set-up.") % link|n}
        </p>

        <p>
            ${_("To better understand land deals and their impacts on local population, it is also critical to see their how they interact with surrounding or overlapping initiatives, land use types and geographic or environmental units such as national protected areas, river basins and watersheds, or regeneration forests. In Paksong, performing this type of analysis shows that while the area granted is not taking over on protected areas, it is surrounded by many other large-scale coffee concessions. Moreover, the land use layer, crosschecked with satellite images, shows that most of the area was initially covered by forests and small-scale croplands.")}
        </p>
        <p>
            ${_("Potential impacts that can be suspected based on these elements include a reduced access to non-timber forest products as a source of complementary income; a generalized increase in pressure over land resources; and, overall, a significant threat to the social and economic resilience of the local population, may the investors and the government fail to offer appropriate compensations and job opportunities.")}
        </p>

        <h4>
            ${_("Beyond the specific cases")}
        </h4>
        <p>
            ${_("Beyond the specific cases, the observatory also helps getting the bigger picture of large-scale land acquisitions at the national level. One can display all deals matching a certain set of criteria (sector, country of origin, area, etc.) and analyze trends and patterns by overlaying contextual layers. One can for instance look at all Chinese investments and see if tend to be located in poor and remote areas. Equally, one can see on which type of land use agricultural concessions are located. User can perform limitless tailored-made analysis that responds to their specific needs and interests. By linking actors with the location of their interventions and claims, and the contextual information, the observatory provides the public, researchers and government agencies with a powerful tool for bottom-up monitoring and enhanced transparency in large-scale land acquisitions.")}
        </p>
    </div>

    ## End showcase 1







    ## Showcase 2

    <h3 class="title-showcase">${_("Golden Triangle turns into gambling paradise")}</h3>

    <a class="modal-trigger modal-trigger-showcases" href="#modal1"><img src="/custom/img/showcases/gt_casino_prvw.jpg" alt="${_("The Golden Triangle SEZ on satellite images")}"/></a>
    <div id="modal1" class="modal modal-showcases">
        <div class="modal-content">
          <img src="/custom/img/showcases/gt_casino.jpg" alt="${_("The Golden Triangle SEZ on satellite images")}" class="img-popup-showcases "/>
        </div>
    </div>

    <%
        link = '<a href="%s">%s</a>' % (request.route_url('activities_read_one', output='html', uid='6a5b9560-63b9-43e5-8637-168deee4e75f'), _("Golden Triangle Special Economic Zone"))
    %>
    <p class="main-text">
        ${_("In the case of the well-known %s granted for 99 years to the Chinese company Kings Roman, a number of Land Observatory users came together to enter, compare and crosscheck information. Facing some challenges to access certain data, they showed a level creativity that would probably not have happened as part a government-led data collection campaign.") % link|n}
    </p>

    <a class="waves-effect waves-light btn btn-read-more" onclick="$('#showcase2').fadeIn(); $(this).hide();">${_('Read more')}</a>

    <div class="showcase" id="showcase2">
        <br>
        <%
            link = '<a href="https://www.google.com/maps/@20.3420757,100.0993729,1855m/data=!3m1!1e3!4m2!5m1!1b1">%s</a>' % _("constructions")
        %>
        <p>
            ${_("As users could not find a map of the area allocated, they started a discussion thread via the comments section. At the beginning of the discussion, the latest Google and Bing satellite images available were 2008, and neither the huge casino nor the extensive surrounding infrastructures were visible. At this stage, the best that could be done was to approximately drop a point somewhere in the area. When eventually Google maps were upgraded and displayed images from 2012, the %s became clearly visible, giving a good indication of the location and extent of the concession. When one of the contributors posted a comment to inform that new images from 2012 were available on Google maps, someone with GIS skills almost immediately grasped the opportunity to digitize the concession area and share it via the Observatory. In the meantime, other users had uploaded additional background documents on this case from a variety of different sources and in a diversity of formats including reports, press articles, documentaries and promotional videos.") % link|n}
        </p>
        <br><br>
        <a class="modal-trigger modal-trigger-showcases" href="#modal2"><img src="/custom/img/showcases/gt_details_prvw.jpg" alt="${_("Collected details and data sources about the Golden Triangle SEZ")}"/></a>
        <br><br><br>
        <div id="modal2" class="modal modal-showcases">
            <div class="modal-content">
              <img src="/custom/img/showcases/gt_details.jpg" alt="${_("Collected details and data sources about the Golden Triangle SEZ")}" class="img-popup-showcases "/>
            </div>
        </div>
        <%
            link_1 = '<a href="http://www.rfa.org/english/news/laos/farmers-04112014180934.html">%s</a>' % _("villagers")
            link_2 = '<a href="http://www.decide.la">DECIDE Info</a>'
            link_3 = '<a href="http://www.laofab.org/">LaoFab</a>'
            link_4 = '<a href="https://www.youtube.com/watch?feature=player_detailpage&v=DrDoXSPxkAc#t=26">%s</a>' % _("Youtube video documentary")
        %>
        <p>
            ${_("End of 2013, national and international media reported %s strongly opposing police forces assisting a team sent out to survey the land for the construction of an international airport in the area. The lack of prior consultation and the threat of being deprived of additional land pushed the villagers to take the risk to protest against a government decision. LO users, who were following the case tried to find out the location of the future airport. Once again facing a lack of information, a first contributor used %s (another open access web mapping application in Lao that provides hundreds of geographic layers) to locate all the villages that were mentioned in the media. Simultaneously, the ongoing debate was disseminated in %s, a thematic discussion group on land issues in Lao that connects over 3,000 registered members interested the topic. Finally, the location of the airport was identified based on a 3D map showed by a representative of the company to a journalist in a %s unveiled by LO user.") % (link_1, link_2, link_3, link_4)|n}
        </p>
        <br>
        <p>
            ${_("Thanks to all these debates, sources and ideas, this specific deal is now much better documented, includes over 15 different sources such as press articles, reports and videos, and has significantly gained in spatial and thematic accuracy, despite the probably intentional retention of information.")}
        </p>
    </div>

    ## End showcase 2





    ## Showcase 3

    <h3 class="title-showcase">${_("Bottom-up monitoring of rubber plantations in Phine District")}</h3>
    <div class="slider slider-showcases">
        <ul class="slides slides-showcases">
            <li>
                <img src="/custom/img/slides/quasa_grantedarea_prvw.jpg" alt="${_("Granted concession area to Quasa Gueruco")}">
            </li>
            <li>
                <img src="custom/img/slides/quasa_currentarea_prvw.jpg" alt="${_("Current used area by Quasa Gueruco")}">
            </li>
        </ul>
    </div>
    <%
            link = '<a href="%s">Quasa Gueruco</a>' % request.route_url('stakeholders_read_one', output='html', uid='50d23b89-253a-4562-b155-524a6e5e9921')
    %>
    <p class="main-text">
        ${_("In Phine District, Savannakhet Province, the Vietnamese state-owned group %s was granted 10'000 hectares for rubber plantations. In Nakanong village, villagers and officials started complaining when they saw that the company was clearing lands beyond the granted area. Supported by an international NGO, the villagers used satellite images overlaid to the districts land allocation maps to demonstrate the illegal expansion of the concession.") % link|n}
    </p>

    <a class="waves-effect waves-light btn btn-read-more" onclick="$('#showcase3').fadeIn(); $(this).hide();">${_('Read more')}</a>

    <div class="showcase" id="showcase3">
        <%
            link = '<a href="%s">%s</a>' % (request.route_url('activities_read_one', output='html', uid='b385975a-393c-4127-9cfc-f7957afd4897'), _("Phine district case"))
        %>
        <br>
        <p>
            ${_("These information were uploaded by users on the Land Observatory, one of which then submitted an updated version based on the newer satellite images available on the web, showing that despite all the complains of the communities on the ground, the expansion of the cleared area beyond the allocated land had not stopped. In the %s, the LO provides valuable information for researchers, local stakeholders, decision-makers. Less powerful actors are empowered by an easy access to critical information and the possibility to contribute to knowledge creation and dissemination of their own perspectives and claims. They are given a voice to raise their concerns, and a space to foster linkages with the global civil society through international platforms such as the land matrix or other similar networks and mechanisms.") % link|n}
        </p>
    </div>

    ## End showcase 3






    ## Showcase number 5 by Joan, added on Oct, 7 2014

    <h3 class="title-showcase">${_('A locally owned tool to engage actors in situ')}</h3>

    <%
        link = '<a href="http://www.landmatrix.org">Land Matrix</a>'
    %>
    <p class="main-text">
        ${_(u"The Land Observatory is a sister project to the %s, a global and independent land monitoring initiative that promotes transparency and accountability in decisions over land and investments. As a local extension of the system, the Land Observatory aims at providing a greater insight on land related deals and processes at the national and subnational level, by further engaging stakeholders in situ, and linking to relevant local networks and initiatives. The Land Observatory is not just a technical solution; it is a process, though which increased coordination and empowerment is made possible by the activity of people on the ground, and their respective contributions to the crowd sourcing web-portal.") % link|n}
    </p>

    <br><br>
    <a class="modal-trigger modal-trigger-showcases" href="#modal3"><img src="/custom/img/showcases/locally_owned_prvw.jpg" alt="${_("A locally owned tool to coordinate and empower local activities")}"/></a>
    <br><br><br>
    <div id="modal3" class="modal modal-showcases">
        <div class="modal-content">
          <img src="/custom/img/showcases/locally_owned.jpg" alt="${_("The Golden Triangle SEZ on satellite images")}" class="img-popup-showcases "/>
        </div>
    </div>


    <a class="waves-effect waves-light btn btn-read-more" onclick="$('#showcase4').fadeIn(); $(this).hide();">${_('Read more')}</a>
    <div class="showcase" id="showcase4">
        <p>
            ${_('In the fast development context of the Lao PDR, land related issues are currently amongst the most critical topics, mobilizing attention from a high diversity of actors, networks and institutions locally. By handing over the keys of the system to local actors in Laos, the Observatory is now fully integrated in the national landscape of land governance through partnerships and dynamic links to other ongoing initiatives, networks and knowledge management systems.')}
        </p>

        <h4>${_('LaoFAB')}</h4>
        <%
            link = '<a href="http://laofab.org">LaoFAB</a>'
        %>
        <p>
            ${_("%s is an online discussion group and document repository launched in 2006, and which now contains about 2,000 reports, and links a community of over 3,600 members with various interests in, and expertise on, land related issues. Thanks to a productive collaboration established locally, discussions often bounce back and forth between the observatory and LaoFAB, offering users a chance to benefit of both the instantaneity and dynamic of the discussions threads, and the more in-depth and spatial analysis capacities of the observatory.") % link|n}
        </p>

        <h4>${_('Lao DECIDE Info')}</h4>
        <%
            link1 = '<a href="http://www.decide.la">Lao DECIDE Info</a>'
            link2 = '<a href="#context-matters">%s</a>' % _("contextual analysis of specific land deals")
        %>
        <p>
            ${_("%s is an online mapping portal, which aims at providing policy-makers in Laos with tools and data to support better-informed decision making processes. Local partnership with the Decide Info initiative resulted in the addition of multiple context layers in the observatory, such as poverty incidence or accessibility, thereby allowing users to perform in depth %s.") % (link1, link2) | n}
        </p>
    </div>

    ## End showcase number 5



    ## Showcase number 4 by Joan, added on Oct, 6 2014

    <h3 class="title-showcase">${_('All in one place: a geocoded data repository on land deals')}</h3>
    <p class="main-text">
        ${_('When available, information on specific land deal cases is often fragmented and hard to find. Building on a flexible database structure, the Land Observatory offers the possibility to link all types of documents (reports, pictures, web links, GIS files, etc.) to their geographic location on the dynamic map, and allows any user to contribute indefinitely by adding and commenting information.')}
    </p>

    <br><br><br>
    <a class="modal-trigger modal-trigger-showcases" href="#modal4"><img src="/custom/img/showcases/comments_comp_prvw.jpg" alt="${_("Comments and attached documents on an existing land deal")}"/></a>
    <br><br><br>
    <div id="modal4" class="modal modal-showcases">
        <div class="modal-content">
          <img src="/custom/img/showcases/comments_comp.jpg" alt="${_("Comments and attached documents on an existing land deal")}" class="img-popup-showcases "/>
        </div>
    </div>


    <%
        link1 = '<a href="%s">%s</a>' % (request.route_url('activities_read_one', output='html', uid='6a5b9560-63b9-43e5-8637-168deee4e75f'), _(u"Golden Triangle casino paradise"))
        link2 = '<a href="%s">Outspan</a>' % (request.route_url('stakeholders_read_one', output='html', uid='f3360f25-a9a7-4b5a-862f-97b3e419ab1a'))
    %>
    <p class="main-text">
        ${_("In cases such as coffee plantations granted to the Singapore based food company %s in Paksong District or the %s leased to the Chinese company Kings Roman, users of the Land Observatory came together to populate the database with dozens of documents including academic papers, Youtube videos, media articles, cross comments observations from the field and official statements by the company. Building on a joint effort by a diversity of users with various expertise and access to information, the crowd sourcing process generated a unique library on these deals, which showcases the different perspectives and claims of stakeholders involved, and can be analyzed, complemented or cross-checked by virtually anybody who has interest in the topic.") % (link1, link2)|n}
    </p>
    <br><br><br>

    ## End showcase number 4

</%def>
