<%inherit file="lmkp:customization/lo/templates/base.mak" />

<%def name="title()">${_('Areal Statistics')} ${shortuid}</%def>

<%def name="format_radius(r)">
<%
    if r > 1000:
        return "%skm" % int(r/1000)
    return "%sm" % int(r)
%>
</%def>

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
        <div class="row-fluid">
            <div class="span9">${_(u"Statistics are based on a sample radius of")} ${format_radius(r=layers[0]['bufferradius'])}.</div>
        </div>
        % for layer in layers:
        % if layer['layername'].lower() == "Population Density".lower():
        <!-- Landscan population density template -->
        <div class="row-fluid">
            <div class="span9">
                <h4>${_(u"Population Density")}</h4>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span9">${_(u"Landscan population density layer 2011 from the <a href=\"http://web.ornl.gov/sci/landscan/\">Oak Ridge National Laboratory</a>.") | n}</div>
        </div>
        % for stats in layer['statistics']:
        % if stats['name'].lower() == "Mean".lower():
        <div class="row-fluid">
            <div class="span9 grid-area">
                <div class="row-fluid">
                    <div class="span5">
                        <h5 class="green">${_(u"Average population density")}</h5>
                    </div>
                    <div class="span2 inactive"></div>
                    <div class="span4">
                        <p class="deal-detail">${stats['value']} pers / km<sup>2</sup></p>
                    </div>
                </div>
            </div>
        </div>
        % endif
        % if stats['name'].lower() == "Minimum".lower():
        <div class="row-fluid">
            <div class="span9 grid-area">
                <div class="row-fluid">
                    <div class="span5">
                        <h5 class="green">Minimum population density</h5>
                    </div>
                    <div class="span2 inactive"></div>
                    <div class="span4">${stats['value']} pers / km<sup>2</sup></div>
                </div>
            </div>
        </div>
        % endif
        % if stats['name'].lower() == "Maximum".lower():
        <div class="row-fluid">
            <div class="span9 grid-area">
                <div class="row-fluid">
                <div class="span5">
                    <h5 class="green">Maximum population density</h5>
                </div>
                <div class="span2 inactive"></div>
                <div class="span4">${stats['value']} pers / km<sup>2</sup></div>
            </div>
        </div>
        % endif
        % endfor
        % endif
        % if layer['layername'].lower() == "Accessibility".lower():
        <!-- Accessibility template -->
        <div class="row-fluid">
            <div class="span9">
                <h4>${_(u"Accessibility")}</h4>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span9">${_(u"Travel time to major cities: A global map of accessibility from the <a href=\"http://bioval.jrc.ec.europa.eu/products/gam/index.htm\">Joint Research Centre of the European Commission</a>.") | n}</div>
        </div>
        % for cls in layer['classes']:
        <div class="row-fluid">
            <div class="span9 grid-area">
                <div class="row-fluid">
                    <div class="span5">
                        <h5 class="green">${'%.2f' % round(cls['areashare'], 2)} % accessible within</h5>
                    </div>
                    <div class="span2 inactive"></div>
                    <div class="span4">${cls['name']}</div>
                </div>
            </div>
        </div>
        % endfor
        % endif
        % if layer['layername'].lower() == "Land Cover".lower():
        <!-- Land cover template -->
        <div class="row-fluid">
            <div class="span9">
                <h4>${_(u"Land Cover")}</h4>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span9">
                ${_(u"Global Land Cover Map 2009 from the <a href=\"http://due.esrin.esa.int/globcover/\">European Space Agency</a>.") | n}
            </div>
        </div>
        % for cls in sorted(layer['classes'], key= lambda cls: cls['areashare'], reverse=True):
        <div class="row-fluid">
            <div class="span9 grid-area">
                <div class="row-fluid">
                    <div class="span3">
                        <h5 class="green">${'%.2f' % round(cls['areashare'], 2)} % area share:</h5>
                    </div>
                    <div class="span2 inactive"></div>
                    <div class="span6">${cls['name']}</div>
                </div>
            </div>
        </div>
        % endfor
        % endif
        % endfor
        <div class="row-fluid">
            <div class="span9 text-right deal-bottom-toolbar">
                <a href="${request.route_url('activities_read_one', output='html', uid=uid)}"><i class="icon-chevron-sign-left"></i>&nbsp;Go back</a>
            </div>
        </div>
    </div>
</div>