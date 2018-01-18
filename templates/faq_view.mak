<%inherit file="lokp:customization/omm/templates/base.mak" />

<%def name="title()">${_('FAQ')}</%def>

<%
    from lokp.config.form import getCategoryList
    cList = getCategoryList(request, 'activities')
    desiredKeys = cList.getDesiredKeyNames(translated=True)
%>

<div class="container">
    <div class="content no-border">
        <h3>
            ${_('FAQ')}
        </h3>

        <ul class="collapsible popout" data-collapsible="accordion" id="faqcollapsible">
            <li>
              <div class="collapsible-header active text-accent-color"><i class="material-icons">question_answer</i>${_('Why are there observatories in only five countries?')}</div>
              <div class="collapsible-body">
                <p>${_('We are piloting this project in five countries. More than just testing software, this requires partners to design crowdsourcing campaigns and organise multi-stakeholder platforms to manage the observatories. These are all very intensive processes and need time. We plan to scale, and seed observatories in other countries in the near future.')}</p>
              </div>
            </li>
            <li>
              <div class="collapsible-header text-accent-color"><i class="material-icons">question_answer</i>${_('Who "owns" each observatory in the five pilot countries?')}</div>
              <div class="collapsible-body">
                  <p>${_('We have co-developed this software with partners in country, and we are still firming up formal arrangements with partner organisations, and where possible with governments. Generally speaking, each observatory will have its own governance structure and moderation team and procedures. More information will be made available soon about each country.')}</p>
              </div>
            </li>
            <li>
              <div class="collapsible-header text-accent-color"><i class="material-icons">question_answer</i>${_('Can I comment on a land deal?')}</div>
              <div class="collapsible-body">
                  <p>${_('Anybody, even anonymous, non-logged in users can comment on a land deal. These comments will be subject to the rules of moderation, unique to each observatory.')}</p>
              </div>
            </li>


            <li>
              <div class="collapsible-header text-accent-color"><i class="material-icons">question_answer</i>${_('Who can submit information on a land deal?')}</div>
              <div class="collapsible-body">
                 <p>${_('If you have information about a land deal in one of the five pilot countries, you can submit information about one or more attributes of this deal. You can also submit a new land deal if the one you are concerned with does not appear on the map.')}
                ${_('You will need to')} <a href="${request.route_url('user_self_registration')}">${_('register')}</a> ${_('(giving us your email) and')} <a href="${request.route_url('login')}">${_('log-in')}</a>.</p>
              </div>
            </li>
            <li>
              <div class="collapsible-header text-accent-color"><i class="material-icons">question_answer</i>${_('How do I submit information on a land deal?')}</div>
              <div class="collapsible-body">
                  <p>${_('Once you are logged in, you can fill out the form to add a new deal or edit an existing one. Do you need help filling out the form? We created some manuals to help you get started.')}</p>
                    <p><a class="btn btn-primary" href="/custom/docs/howto_addnewdeal.pdf">${_('How to add a new deal')}</a>&nbsp;<a class="btn btn-primary" href="/custom/docs/howto_editexistingdeal.pdf">${_('How to edit an existing deal')}</a></p>
                    <p>${_('After you submit, moderators will review and approve your report. New deals will not be approved until all of the mandatory attributes are completed.')}</p>
                    <ul class="bullets">
                        % for k in desiredKeys:
                        <li>${k}</li>
                        % endfor
                    </ul>
                  <p>${_('Once your report is reviewed and approved, it is public for the whole world to see.')}</p>
              </div>
            </li>
            <li>
              <div class="collapsible-header text-accent-color"><i class="material-icons">question_answer</i>${_('Can I submit information on a land deal even if I am in a different country?')}</div>
              <div class="collapsible-body">
                  <p>${_('Yes, but it will be reviewed and approved by moderators. At the moment, we ask that your account is connected to a particular country.')}</p>
             </div>
            </li>


            <li>
              <div class="collapsible-header text-accent-color"><i class="material-icons">question_answer</i>${_('What about polygons and land areas?')}</div>
              <div class="collapsible-body">
                <p>${_('You can view polygons and land areas on the map by activating the appropriate layers in the map legend. To add new polygons or edit the shape of existing areas, we wrote a plugin for QGIS which you can use.')} <a href="http://lokp.readthedocs.org/en/latest/qgis.html" target="_blank">${_('Please refer to the documentation of the QGIS plugin for more information.')}</a></p>
              </div>
            </li>
            <li>
              <div class="collapsible-header text-accent-color"><i class="material-icons">question_answer</i>${_('How can I download data?')}</div>
              <div class="collapsible-body">
                  <p>${_('You can download data in the "Grid" view using the button at the top right corner of the grid. Both deals and investors can be downloaded and you can customize your download to include only selected attributes.')}</p>
                  <p><a href="${request.route_url('download')}">${_('You can also use this link to access the download page.')}</a></p>
              </div>
            </li>
            <li>
              <div class="collapsible-header text-accent-color"><i class="material-icons">question_answer</i>${_('Do you protect my privacy?')}</div>
              <div class="collapsible-body">
                  <p>${_('All defaults are set to safeguard user privacy. To comment, you need not give any personal information, although providing it may enhance your credibility. To log-in and submit data, all you need to provide is an email address. Currently, metadata about your submissions is stored on the servers of the Centre for Development and Environment - University of Bern and are only kept for reference: your personal information will not be shared with others or re-used for any purposes except for possible verification of submitted information.')}</p>
              </div>
            </li>
      </ul>
    </div>
    <script type="text/javascript">
        $(document).ready(function(){
            $('.collapsible').collapsible();
        });
    </script>
</div>

