<?xml version="1.0" encoding="utf-8"?>
<%
from datetime import datetime
%>
<rss version="2.0">

    <channel>
        <title>Version history of deal #${versions[0]['identifier'].split('-')[0]}</title>
        <link></link>
        ## <description>description</description>
        <language>en-US</language>
        ## <copyright>Autor des Feeds</copyright>
        <pubDate>Sat, 5 Apr 2014 22:11:29</pubDate>
        <image>
            <url>/custom/img/logo.png</url>
            <title>Land Observatory</title>
            <link>${request.route_url('index')}</link>
        </image>

        % for v in versions:
        <item>
            <title>Version ${v['version']}: ${v['statusName']}</title>
            <description><![CDATA[
                <span>Last change on ${v['timestamp']} by user "${v['username']}"</span><br/>
                % if isModerator and v['statusId'] == 1:
                <span>
                    <a href="${request.route_url('activities_read_one', output='review', uid=v['identifier'], _query=(('new', v['version']),))}">
                        ${_('Review this version')}
                    </a>
                </span><br/>
                % endif
                % if v['statusId'] != 2:
                <span>
                    <a href="${request.route_url('activities_read_one', output='compare', uid=v['identifier'], _query=(('ref', v['version']),('new', activeVersion)))}">
                        Compare this version with the active version
                    </a>
                </span>
                <br/>
                % endif
                <span>
                    <a href="${request.route_url('activities_read_one', output='html', uid=v['identifier'], _query=(('v', v['version']),))}">
                        View this version
                    </a>
                </span>

                ]]></description>
            <link>${request.route_url('activities_read_one', output='html', uid=v['identifier'], _query=(('v', v['version']),))}</link>
            <author>${v['username']}</author>
            <guid>${"%s?v=%s" % (v['identifier'], v['version'])}</guid>
            <pubDate>${datetime.strptime(v['timestamp'], '%Y-%m-%d %H:%M:%S').strftime("%a, %d %b %Y %H:%m:%S %Z")}</pubDate>
        </item>
        % endfor

    </channel>

</rss>