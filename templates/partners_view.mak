<%inherit file="lmkp:customization/omm/templates/base.mak" />

<%def name="title()">${_('Partners & Donors')}</%def>

<div class="container">
    <div class="content no-border">
        <h3>
            ${_('Partners & Donors')}
        </h3>

        <p>${_('The pilot project is coordinated by the International Land Coalition and the Centre for Development and Environment at the University of Bern, Switzerland. It is funded by the Swiss Agency for Development Cooperation, with co-funding from other ILC and CDE programs.')}</p>

        <div class="row" style="margin-top: 20px;">
             <a href="http://www.landcoalition.org/" target="_blank">
                 <div class="col s6">
                     <div class="valign-wrapper partnersimgdiv">
                        <img class="valign center-align partnersimg" src="/custom/img/logos/ilc.png" style="width: auto;" />
                    </div>
                 </div>
             </a>

            <a href="http://www.cde.unibe.ch/" target="_blank">
                <div class="col s6">
                     <div class="valign-wrapper partnersimgdiv">
                        <img class="valign center-align partnersimg" src="/custom/img/logos/cde.jpg" style="width: auto;"/>
                    </div>
                 </div>
            </a>

            <a href="http://www.sdc.admin.ch/" target="_blank">
                <div class="col s6">
                     <div class="valign-wrapper partnersimgdiv">
                        <img class="valign center-align partnersimg" src="/custom/img/logos/sdc.jpg" style="width: auto;" />
                     </div>
                </div>
            </a>

            <a href="http://www.fordfoundation.org/" target="_blank">
                <div class="col s6">
                     <div class="valign-wrapper partnersimgdiv">
                        <img class="valign center-align partnersimg" src="/custom/img/logos/fordfoundation.png" style="width: auto;" />
                     </div>
                </div>
            </a>
        </div>
    </div>
</div>

