<%inherit file="lmkp:customization/omm/templates/base.mak" />

<%def name="title()">${_('Password Reset')}</%def>

<div class="container">
    <div class="content no-border">
        <div class="row-fluid">
            <div class="span4 offset4">
                <h3>${_('Password Reset')}</h3>
            </div>
        </div>
        % if warning is not None:
        <div class="row-fluid">
            <div class="span4 offset4">
                <div class="alert alert-error">
                    ${warning | n}
                </div>
            </div>
        </div>
        % endif
        <div class="row">
            <form class="col s12" action="/reset" method="POST">
                <fieldset class="simple_login row">
                    <div class="input-field col s12">
                        <i class="material-icons prefix">account_circle</i><input id="username-input" name="username" class="validate" type="text">
                        <label for="username-input">${_(u"Username")}:</label>
                        <input type="hidden" name="came_from" value="${came_from}"/><br />
                    </div>
                    <button id="passwordresetbutton" class="btn waves-effect waves-light" type="submit" name="form.submitted" value="${_('Reset')}">${_('Reset')}
                        <i class="material-icons right">send</i>
                    </button>
                </fieldset>
            </form>
        </div>
    </div>
</div>




