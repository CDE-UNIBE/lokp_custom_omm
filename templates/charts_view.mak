<%inherit file="lmkp:customization/omm/templates/base.mak" />

<%def name="title()">${_("Charts")}</%def>

<%def name="head_tags()">
  <link rel="stylesheet" href="/custom/css/charts.css"></link>
</%def>

<div class="container">
    <div class="content no-border">

        <h3>${_("Charts")}</h3>

          <div class="row">

            <div class="col s12 m6">
              <div class="card hoverable">
                <div class="card-image">
                 <img alt="${_('Deal bar charts')}" src="/custom/img/charts/barchart_a.png">
                  <span class="card-title">${_('Deal bar charts')}</span>
                </div>
                <div class="card-action">
                  <a class="text-accent-color" href="${request.route_url('charts', type='bars', params=(u'a',))}">${_('Deal bar charts')}</a>
                </div>
              </div>
            </div>

              <div class="col s12 m6">
                  <div class="card hoverable">
                    <div class="card-image">
                     <img alt="${_('Deal stacked bar charts')}" src="/custom/img/charts/stackedbarchart_a.png">
                      <span class="card-title">${_('Deal stacked bar charts')}</span>
                    </div>
                    <div class="card-action">
                      <a class="text-accent-color" href="${request.route_url('charts', type='stackedbars', params=())}">${_('Deal stacked bar charts')}</a>
                    </div>
                  </div>
              </div>

              <div class="col s12 m6">
                  <div class="card hoverable">
                    <div class="card-image">
                     <img alt="${_('Investor bar charts')}" src="/custom/img/charts/barchart_sh.png">
                      <span class="card-title">${_('Investor bar charts')}</span>
                    </div>
                    <div class="card-action">
                      <a class="text-accent-color" href="${request.route_url('charts', type='bars', params=(u'sh',))}">${_('Investor bar charts')}</a>
                    </div>
                  </div>
              </div>

              <div class="col s12 m6">
                  <div class="card hoverable">
                    <div class="card-image">
                     <img alt="${_('Investor map charts')}" src="/custom/img/charts/mapchart_sh.png">
                      <span class="card-title">${_('Investor bar charts')}</span>
                    </div>
                    <div class="card-action">
                      <a class="text-accent-color" href="${request.route_url('charts', type='map', params=())}">${_('Investor map charts')}</a>
                    </div>
                  </div>
              </div>
          </div>
    </div>
</div>