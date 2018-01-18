<%inherit file="lokp:customization/omm/templates/base.mak" />

<%def name="title()">${_('Login')}</%def>

<%def name="head_tags()">
    <style type="text/css" >
        p.login-info {
            margin-left: 30px;
        }
    </style>
</%def>

<%
mode = None
if 'lokp.mode' in request.registry.settings:
    if str(request.registry.settings['lokp.mode']).lower() == 'demo':
        mode = 'demo'
%>

<div class="container">
    <div class="content no-border">
        <div class="row-fluid">
            <div class="span4 offset4">
                <h3>${_('Login')}</h3>

                % if warning is not None:
                    <div class="alert alert-error">
                        ${warning | n}
                    </div>
                % endif
                <!--<form action="/login" method="POST">
                    <fieldset class="simple_login">
                        <label for="login">${_(u"Username")}:</label>
                        <input class="input-style span12" type="text" id="login" name="login" /><br />
                        <label for="password">${_(u"Password")}:</label>
                        <input class="input-style span12" type="password" id="password" name="password" /><br/>
                        <input type="hidden" name="came_from" value="${came_from}"/><br />
                        <input class="btn btn-primary" type="submit" name="form.submitted" value="${_('Login')}"/>
                    </fieldset>
                </form>-->

                  <div class="row">
                    <form action="/login" method="POST" class="col s12">
                        <div class="row">
                            <div class="input-field col s12">
                                <i class="material-icons prefix">account_circle</i>
                                <input id="login" name="login" type="text" class="validate">
                                <label for="login">${_(u"Username")}:</label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="input-field col s12">
                                <i class="material-icons prefix">lock_outline</i>
                                <input id="password" name="password" type="password" class="validate">
                                <label for="password">${_(u"Password")}:</label>
                                <input type="hidden" name="came_from" value="${came_from}"/><br />
                            </div>
                        </div>

                        <div class="row">
                            <div class="input-field col s12">
                                <button class="btn waves-effect waves-light" type="submit" name="form.submitted" value="${_('Login')}">Submit
                                    <i class="material-icons right">send</i>
                                </button>
                            </div>
                        </div>
                    </form>
                  </div>

                % if mode != 'demo':
                <p>
                    <a href="/reset">${_(u"Forgot Password?")}</a>
                </p>
                <br>
                <p>
                    ${_('You dot not have a password yet?')}<br/><a href="${request.route_url('user_self_registration')}">${_('Register now!')}</a>
                </p>
            </div>
        </div>

                % else:
            </div>
        </div>
        <div class="row-fluid">
            <div class="span8 offset2">
                <h3>
                    ${_(u"Demo Version")}
                </h3>
                <p class="lead">${_('This is the demonstration version of the')} <a href="http://www.landobservatory.org">${_('Myanmar land reporting')}</a>.</p>
                <p>${_(u"Any member of the public can log-in as an Editor or a Moderator.")}</p>

                <p><strong>${_('Editor')}</strong> ${_('has the permission to create or edit new Deals or Investors.')}</p>
                <p class="login-info">
                    ${_('Username')}: editor<br/>
                    ${_('Password')}: editor
                </p>

                <p><strong>${_('Moderator')}</strong> ${_('has the additional permission to review pending changes.')}</p>
                <p class="login-info">
                    ${_('Username')} moderator<br/>
                    ${_('Password')} moderator
                </p>

                <p>
                    ${_(u"This demo version is for learning and experimentation purposes, so first-time users can get a feel for the Observatory and its functions.")}
                </p>
                <p>
                    ${_(u"New data added by users to the demo has not been verified in any way. It will be visible to the public, but the database will be reset regularly.")}
                </p>
                <p>
                    ${_(u"Please send your questions and feedback on the Observatory to: ")}<a href="mailto:info_landobservatory@cde.unibe.ch">info_landobservatory@cde.unibe.ch</a>
                </p>
            </div>
        </div>
            % endif
    </div>
</div>
