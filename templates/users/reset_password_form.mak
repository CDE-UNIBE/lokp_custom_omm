<%doc>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>${_("Land Observatory")} - ${_(u"Login")}</title>
        <link rel="stylesheet" type="text/css" href="${request.static_url('lmkp:static/style.css')}"></link>
        <!--link rel="stylesheet" type="text/css" href="${request.static_url('lmkp:static/lib/extjs-4.1.1/resources/css/ext-standard.css')}"></link-->
        <script type="text/javascript" src="${request.static_url('lmkp:static/lib/extjs-4.1.1/ext.js')}"></script>
        <script type="text/javascript" src="${request.static_url('lmkp:static/lib/extjs-4.1.1/src/Ajax.js')}"></script>
        <script type="text/javascript">
            Ext.ns('Ext.ux');
            Ext.ux.process = function(){

                if(Ext.fly('reset-response-div')){
                    Ext.fly('reset-response-div').remove();
                }

                Ext.fly("body").createChild({
                    cls: 'login',
                    html: "Loading ...",
                    id: 'reset-loading-div',
                    tag: 'div'
                }, Ext.fly('reset-form-div'));

                //Ext.ux.loading(true);
                Ext.Ajax.request({
                    params: {
                        email: Ext.fly("email").getValue()
                    },
                    callback: function(options, success, response){
                        var r = Ext.decode(response.responseText);
                        Ext.fly("body").createChild({
                            cls: r.success ? 'login' : 'login login-warning',
                            html: r.msg,
                            id: 'reset-response-div',
                            tag: 'div'
                        }, Ext.fly('reset-form-div'));
                        if(Ext.fly('reset-loading-div')){
                            Ext.fly('reset-loading-div').remove();
                        }
                    },
                    url: '/reset'
                });
            }
        </script>
    </head>
    <body id="body">
        <div id="reset-header-div" class="login">
            <img src="/custom/img/logo_short.png" alt="Land Observatory"/><br/>
            ${_(u"Reset password")}
        </div>
        <div id="reset-form-div">
            <form id="reset-form" action="javascript:Ext.ux.process();" method="POST">
                <fieldset class="simple_login">
                    <label for="email">${_(u"Email Address")}:</label>
                    <input class="simple_login" type="text" id="email" name="email" /><br />
                    <input type="hidden" name="came_from" value="${came_from}"/><br />
                    <input type="submit" name="form.submitted" value="Reset"/>
                </fieldset>
            </form>
        </div>
    </body>
</html>
</%doc>

<%inherit file="lmkp:customization/lo/templates/base.mak" />

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
        <div class="row-fluid">
            <div class="span4 offset4">
                <form action="/reset" method="POST">
                    <fieldset class="simple_login">
                        <label for="login">${_(u"Username")}:</label>
                        <input class="input-style span12" type="text" id="username-input" name="username" /><br />
                        <input type="hidden" name="came_from" value="${came_from}"/><br />
                        <input class="btn btn-primary" type="submit" name="form.submitted" value="${_('Reset')}"/>
                    </fieldset>
                </form>
            </div>

        </div>
    </div>
</div>