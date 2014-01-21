<%
    import re
%>

<%def name="add_hyperlink(text)">
<%

    pattern = re.compile("(http|https)://[a-zA-Z0-9\/\.]*")
    m = pattern.search(text)
    if m is None:
        return text

    link = m.group(0)

    return re.sub(link, "<a href=\"%s\">%s</a>" % (link, link), text)

%>
</%def>

<%inherit file="lmkp:customization/lo/templates/base.mak" />

<%def name="title()">${_('Areal Statistics')} ${shortuid}</%def>

<%def name="head_tags()">

<style type="text/css">
.row-fluid > .span9 > h4 {
    margin: 15px 0px 0px;
}
</style>

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
            <div class="span9">${add_hyperlink(text=layer["description"]) | n}</div>
        </div>
        % if "statistics" in layer:
        <div class="row-fluid">
            <div class="span9 grid-area">
                <div class="span12">
                    <h5 class="green">${_(u"Statistical key values")}</h5>
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
        <!-- Unit -->
        <div class="row-fluid">
            <div class="span9 grid-area">
                <div class="row-fluid">
                    <div class="span5"><h5 class="green">${_(u'Unit')}</h5></div>
                    <div class="span2 inactive"></div>
                    <div class="span4"><p class="deal-detail">${str(layer['unit'])}</p></div>
                </div>
            </div>
        </div>
        <!-- number of pixels -->
        <div class="row-fluid">
            <div class="span9 grid-area">
                <div class="span12">
                    <h5 class="green">${_(u"Sample size")}</h5>
                </div>
                <div class="row-fluid">
                    <div class="span5"><h5 class="green">${_(u'Number of pixels')}</h5></div>
                    <div class="span2 inactive"></div>
                    <div class="span4"><p class="deal-detail">${int(layer['pixel'])}</p></div>
                </div>
                <div class="row-fluid">
                    <div class="span5"><h5 class="green">${_(u'Number of no data pixels')}</h5></div>
                    <div class="span2 inactive"></div>
                    <div class="span4"><p class="deal-detail">${int(layer['nodatapixel'])}</p></div>
                </div>
            </div>
        </div>
        % endif
        % if "classes" in layer:
        <!-- class description -->
        <div class="row-fluid">
            <div class="span9 grid-area">
                <div class="row-fluid">
                    <div class="span5"><h5 class="green">${_(u'Classes')}</h5></div>
                    <div class="span2 inactive"></div>
                    <div class="span4"><p class="deal-detail">${str(layer['unit'])}</p></div>
                </div>
            </div>
        </div>
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
        <!-- number of pixels -->
        <div class="row-fluid">
            <div class="span9 grid-area">
                <div class="span12">
                    <h5 class="green">${_(u"Sample size")}</h5>
                </div>
                <div class="row-fluid">
                    <div class="span5"><h5 class="green">${_(u'Number of pixels')}</h5></div>
                    <div class="span2 inactive"></div>
                    <div class="span4"><p class="deal-detail">${int(layer['pixel'])}</p></div>
                </div>
                <div class="row-fluid">
                    <div class="span5"><h5 class="green">${_(u'Number of no data pixels')}</h5></div>
                    <div class="span2 inactive"></div>
                    <div class="span4"><p class="deal-detail">${int(layer['nodatapixel'])}</p></div>
                </div>
            </div>
        </div>
        % endif
        % endfor
        <div class="row-fluid">
            <div class="span9 text-right deal-bottom-toolbar">
                <a href="${request.route_url('activities_read_one', output='html', uid=uid)}"><i class="icon-chevron-sign-left"></i>&nbsp;Go back</a>
            </div>
        </div>
    </div>
</div>