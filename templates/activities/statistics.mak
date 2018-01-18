<%inherit file="lokp:customization/omm/templates/base.mak" />

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
    .row-fluid > .span12 > h4 {
      margin-top: 20px;
    }
    .stat-description {
      font-size: 0.9em;
      font-style: italic;
    }
    .toolbar-bottom {
      margin-top: 30px;
    }
</style>

</%def>

<div class="container">
    <div class="content no-border">

        ${toolbar('top')}

        <div class="row-fluid">
            <div class="span12">
                <h3>${_('Areal Statistics')}</h3>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span12">
                <p class="id">${uid}</p>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span12">${_(u"Statistics are based on a sample radius of")} ${format_radius(r=layers[0]['bufferradius'])}.</div>
        </div>
        % for layer in layers:
          % if layer['layername'].lower() == "Population Density".lower():
            <!-- Landscan population density template -->
            <div class="row-fluid">
              <div class="span12">
                <h4>${_(u"Population Density")}</h4>
              </div>
            </div>
            <div class="row-fluid">
              <div class="span12 stat-description">
                <%
                  link = '<a href="http://web.ornl.gov/sci/landscan/">%s</a>' % _("Oak Ridge National Laboratory")
                %>
                ${_(u"Landscan population density layer 2011 from %s.") % link|n}
              </div>
            </div>
            <table class="striped">
            % for stats in layer['statistics']:
              <%
                if stats['name'].lower() == "Mean".lower():
                  attribute = _(u"Average population density")
                  value = '%.2f' % round(stats['value'], 2)
                elif stats['name'].lower() == "Minimum".lower():
                  attribute = _("Minimum population density")
                  value = int(stats['value'])
                elif stats['name'].lower() == "Maximum".lower():
                  attribute = _("Maximum population density")
                  value = int(stats['value'])
                else:
                  continue
              %>
                <tr>
                  <th width="40%">${attribute}</th>
                  <td>${value} pers / km<sup>2</sup></td>
                </tr>
            % endfor
            </table>
          % elif layer['layername'].lower() == "Accessibility".lower():
            <!-- Accessibility template -->
            <div class="row-fluid">
              <div class="span12">
                <h4>${_(u"Accessibility")}</h4>
              </div>
            </div>
            <div class="row-fluid">
              <div class="span12 stat-description">
                <%
                  link = '<a href="http://bioval.jrc.ec.europa.eu/products/gam/index.htm">%s</a>' % _("Joint Research Centre of the European Commission")
                %>
                ${_(u"Travel time to major cities: A global map of accessibility from %s.") % link|n}
              </div>
            </div>
            <table class="striped">
            % for cls in layer['classes']:
              <tr>
                <th width="40%">${'%.2f' % round(cls['areashare'], 2)} % accessible within</th>
                <td>${cls['name']}</td>
              </tr>
            % endfor
            </table>
          % elif layer['layername'].lower() == "Land Cover".lower():
            <!-- Land cover template -->
            <div class="row-fluid">
              <div class="span12">
                <h4>${_(u"Land Cover")}</h4>
              </div>
            </div>
            <div class="row-fluid">
              <div class="span12 stat-description">
                <%
                  link = '<a href="http://due.esrin.esa.int/globcover/">%s</a>' % _("European Space Agency")
                %>
                ${_(u"Global Land Cover Map 2009 from %s.") % link|n}
              </div>
            </div>
            <table class="striped">
            % for cls in sorted(layer['classes'], key= lambda cls: cls['areashare'], reverse=True):
              <tr>
                <th width="40%">${'%.2f' % round(cls['areashare'], 2)} % area share:</th>
                <td>${cls['name']}</td>
              </tr>
            % endfor
            </table>
          % endif
        % endfor

        ${toolbar('bottom')}

    </div>
</div>

<%def name="toolbar(position)">
  <div class="row-fluid">
    <div class="span12 text-right toolbar-${position}">
      <ul class="inline item-toolbar">
        <li>
          <a href="${request.route_url('activities_read_one', output='html', uid=uid)}"><i class="icon-chevron-sign-left"></i><span class="link-with-icon">${_("Back")}</span></a>
        </li>
      </ul>
    </div>
  </div>
</%def>
