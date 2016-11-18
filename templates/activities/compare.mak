<%
    errorMsg = error if error else None
%>

<%inherit file="lmkp:customization/omm/templates/base.mak" />

<%def name="title()">${_('Version Compare')}</%def>

<div class="container deal-moderate-content">
    <div class="content no-border">
        
        % if errorMsg:
            ${errorMsg | n}
        % else:
            ${self.topOfForm()}
            
            <div class="row-fluid">
                ${form | n}
            </div>

            <%
                try:
                    self.moderate_buttons()
                except AttributeError:
                    pass
            %>
        % endif
    </div>
</div>

<%def name="topOfForm()">
        
    <h3>${_('Version Compare')}</h3>
    <p class="id">${identifier}</p>

    <div class="row compareviewcontainer">
        <div class="col s6">
            <div class="row">
                <ul class="">
                    <li class="active">
                        <a class="btn disabled" href="" onclick="javascript:return false;">
                            % if refMetadata:
                                ${refMetadata['status']}
                            % else:
                                -
                            % endif
                        </a>
                    </li>
                </ul>
            </div>
            % if refMetadata:
            <div class="row">
                <div class="col s12 grid-area border-bottom deal-data">
                    <div class="row">
                        <div class="col s5">
                            <div class="text-accent-color versioncomparetitle">
                                ${_('Version')}
                            </div>
                        </div>
                        <div class="col s7">
                            ${refVersion}
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s5">
                            <div class="text-accent-color versioncomparetitle">
                                ${_('Timestamp')}
                            </div>
                        </div>
                        <div class="col s7">
                            ${refMetadata['timestamp']}
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s5">
                            <div class="text-accent-color versioncomparetitle">
                                ${_('User')}
                            </div>
                        </div>
                        <div class="col s7">
                            ${refMetadata['username']}
                        </div>
                    </div>
                </div>
            </div>
            % else:
            <div class="row">
                <div class="col s12 grid-area deal-data">
                    ${_('There is no previous version available.')}
                </div>
            </div>
            % endif
        </div>
        <div class="col s6">
            <div class="row">
                <div class="col s7">
                    <ul>
                        <li class="active">
                            <a class="btn disabled" href="" onclick="javascript:return false;">
                                ${newMetadata['status']}
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="col s5">
                    <ul>
                        <li>
                            <a class="waves-effect waves-light btn" href="${request.route_url('activities_read_one_history', output='html', uid=identifier)}">${_('History')}</a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="row">
                <div class="col s12 grid-area border-bottom deal-data">
                    <div class="row">
                        <div class="col s5">
                            <h5 class="text-accent-color versioncomparetitle">
                                ${_('Version')}
                            </h5>
                        </div>
                        <div class="col s7">
                            ${newVersion}
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s5">
                            <h5 class="text-accent-color versioncomparetitle">
                                ${_('Timestamp')}
                            </h5>
                        </div>
                        <div class="col s7">
                            ${newMetadata['timestamp']}
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s5">
                            <h5 class="text-accent-color versioncomparetitle">
                                ${_('User')}
                            </h5>
                        </div>
                        <div class="col s7">
                            ${newMetadata['username']}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</%def>

<%def name="bottom_tags()">
    <%include file="lmkp:templates/map/mapform.mak" args="readonly=True, compare=True" />
    <script>
        
        var identifier = '${identifier}';
        var refVersion = ${refVersion};
        var newVersion = ${newVersion};

        $(document).ready(function(){
            
            % if refVersion and refMetadata:
                $('#refMapLegendEntry').html('${_("Version")} ${refVersion} (${refMetadata["status"]})');
                $('#refMapLegend').show();
            % endif
            % if newVersion and newMetadata:
                $('#newMapLegendEntry').html('${_("Version")} ${newVersion} (${newMetadata["status"]})');
                $('#newMapLegend').show();
            % endif
            
            $('.accordion').on('hidden', function() {
                $(this).find('.icon-chevron-up')
                    .removeClass("icon-chevron-up")
                    .addClass("icon-chevron-down");
            });

            $('.accordion').on('shown', function() {
                $(this).find('.icon-chevron-down')
                    .removeClass("icon-chevron-down")
                    .addClass("icon-chevron-up");
            });
        });
    </script>
</%def>