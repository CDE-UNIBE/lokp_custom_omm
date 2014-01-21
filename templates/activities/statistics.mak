<%inherit file="lmkp:customization/lo/templates/base.mak" />

<%def name="title()">${_('Areal Statistics')}</%def>

<%def name="head_tags()">
</%def>

<div class="container">
    <div class="content no-border">

        <div class="row-fluid">
            <div class="span9 text-right">
                <a href="${request.route_url('activities_read_one', output='html', uid=uid)}"><i class="icon-chevron-sign-left"></i>&nbsp;Go back</a>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span12">
                <h3>${_('Areal Statistics')}</h3>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span9">
                <p class="id">${uid}</p>
            </div>
        </div>
        % for layer in layers:
        <div class="row-fluid">
            <div class="span9">
                <h4>${layer["layername"]}</h4>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span9">${layer["description"]}</div>
        </div>
        % if "statistics" in layer:
        <div class="row-fluid">
            <div class="span9 grid-area">
                <div class="span12">
                    <h5 class="green">${_(u"Statistical value")}</h5>
                </div>
                % for s in layer["statistics"]:
                <div class="row-fluid">
                    <div class="span5"><h5 class="green">${s['name']}</h5></div>
                    <div class="span2 inactive"></div>
                    <div class="span4"><p class="deal-detail">${round(s['value'], 2)}</p></div>
                </div>
                % endfor
            </div>
        </div>
        % endif
        % if "classes" in layer:
        % for c in layer["classes"]:
        <div class="row-fluid">
            <div class="span9 grid-area">
                <div class="span12">
                    <h5 class="green">${c['name']}</h5>
                </div>
                <div class="row-fluid">
                    <div class="span5"><h5 class="green">${_(u'Frequency')}</h5></div>
                    <div class="span2 inactive"></div>
                    <div class="span4"><p class="deal-detail">${c['frequency']}</p></div>
                </div>
                <div class="row-fluid">
                    <div class="span5"><h5 class="green">${_(u'Area share in %')}</h5></div>
                    <div class="span2 inactive"></div>
                    <div class="span4"><p class="deal-detail">${round(c['areashare'], 2)}</p></div>
                </div>
            </div>
        </div>
        % endfor
        % endif
        % endfor
    </div>
</div>