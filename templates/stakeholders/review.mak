<%inherit file="lmkp:customization/omm/templates/stakeholders/compare.mak" />

<%def name="title()">${_('Investor Moderation')}</%def>

<%def name="topOfForm()">

    ## Session messages
    <%include file="lmkp:templates/parts/sessionmessage.mak"/>

    <h3>${_('Investor Moderation')}</h3>
    <p class="id">${identifier}</p>

    <div class="row compareviewcontainer">
        <div class="col s6">
            <div class="row">
                <ul>
                    <li class="active">
                        <a class="btn disabled" href="" onclick="javascript:return false;" class="btn teal">
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
                <div class="col s12 grid-area deal-data">
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
                <div class="col s4">
                    <ul>
                        <li class="active">
                            <a class="btn disabled" href="" onclick="javascript:return false;" class="btn teal">
                                ${newMetadata['status']}
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="col s8 right-align">
                    % if len(pendingVersions) > 1:
                      <a class='dropdown-button btn' href='#' data-activates='version_dropdown'>${_('Version')} ${newVersion}</a>
                      <ul id='version_dropdown' class='dropdown-content'>
                        % for pV in pendingVersions:
                          <li><a href="?new=${pV}">${_('Version')} ${pV}</a></li>
                        % endfor
                      </ul>
                    % endif
                    <a class="waves-effect waves-light btn" href="${request.route_url('stakeholders_read_one_history', output='html', uid=identifier)}">${_('History')}</a>
                </div>
            </div>
            <div class="row">
                <div class="col s12 grid-area deal-data">
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

<%def name="moderate_buttons()">
    <form class="moderate-form" action="${request.route_url('stakeholders_review')}" method="POST">
        <div class="row">
            <div class="col s4">
                % if reviewable is True:
                    <button name="review_decision" value="approve" class="btn btn-large deal-moderate-button" style="width: 100%;">
                        ${_('Approve')}
                    </button>
                % else:
                    <button name="review_decision" value="approve" class="btn btn-large disabled" onclick="javascript:return false;" style="width: 100%;">
                        [ ${_('Approve')} ]
                    </button>
                % endif
            </div>
            <div class="col s4">
                <button name="review_decision" value="reject" class="btn btn-large deal-moderate-button" style="width: 100%;">
                    ${_('Deny')}
                </button>
            </div>
            <div class="col s4">
                <a class="btn btn-large deal-moderate-button" style="width: 100%;" href="${request.route_url('stakeholders_read_one', output='form', uid=identifier, _query=(('v', newVersion),))}">
                    ${_('Edit')} (${_('Version')} ${newVersion})
                </a>
            </div>
            <input type="hidden" name="identifier" value="${identifier}">
            <input type="hidden" name="version" value="${newVersion}">
            <input type="hidden" name="camefrom" value="${camefrom}">
        </div>
        % if len(missingKeys) > 0:
            <div class="alert alert-error alert-block alert-missing-mandatory-keys">
                <p><strong>${_('Warning')}</strong></p>
                <p>${_('There are some mandatory keys missing. The item cannot be approved without these keys. Please click the "edit" button to add the missing keys.')}</p>
                <p>${_('The following keys are missing:')}</p>
                <ul class="bullets">
                % for m in missingKeys:
                    <li>${m}</li>
                % endfor
                </ul>
            </div>
        % endif
        % if reviewableMessage:
            <div class="alert alert-error alert-block alert-missing-mandatory-keys">
                <p><strong>${_('Warning')}</strong></p>
                <p>${reviewableMessage}</p>
            </div>
        % endif
        % if recalculated:
            <div class="alert alert-info alert-block alert-recalculated-version">
                <p><strong>${_('Notice')}</strong></p>
                <p>${_('The two versions are not based directly on each other. The new version is calculated to display only the changes made to this version. Approving it will create a new version.')}</p>
            </div>
        % endif
        <div class="row comments">
            <div class="col s12">
                <div class="col s5">
                    <h5>${_('Additional comments')}</h5>
                </div>
                <div class="col s7">
                    <textarea name="review_comment" class="input-style materialize-textarea" rows="4"></textarea>
                </div>
            </div>
        </div>
    </form>
</%def>

${parent.body()}
