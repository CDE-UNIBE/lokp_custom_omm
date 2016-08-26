<%
from lmkp.utils import handle_query_string
from lmkp.views.translation import get_languages
languages = get_languages()
selectedlanguage = languages[0]
for l in languages:
    if locale == l[0]:
        selectedlanguage = l
mode = None
if 'lmkp.mode' in request.registry.settings:
    if str(request.registry.settings['lmkp.mode']).lower() == 'demo':
        mode = 'demo'

use_piwik_analytics = False
if 'lmkp.use_piwik_analytics' in request.registry.settings:
    if str(request.registry.settings['lmkp.use_piwik_analytics']).lower() == "true":
        use_piwik_analytics = True
%>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta name="content-language" content="${selectedlanguage[0]}" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <link rel="icon" type="image/ico" href="/custom/img/favicon.ico"/>
        <title>
            <%
                try:
                    context.write("%s - %s" % (self.title(), _("Land Observatory")))
                except AttributeError:
                    context.write(_("Land Observatory"))
            %>
        </title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">

        <link rel="stylesheet" href="/custom/css/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="/custom/css/main.css">


        <!--[if IE 7]>

            <link rel="stylesheet" href="/custom/css/ie7.css">
            <link rel="stylesheet" href="/custom/css/font-awesome/css/font-awesome-ie7.css">

        <![endif]-->

        <!--[if IE 8]>

            <link rel="stylesheet" href="/custom/css/ie8.css')}">

        <![endif]-->

        <script src="/custom/js/vendor/modernizr-2.6.2-respond-1.1.0.min.js"></script>
        <script src="http://hammerjs.github.io/dist/hammer.min.js"></script>

        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="/custom/js/vendor/jquery-2.1.1.min.js"></script>
        <script type="text/javascript" src="/custom/js/vendor/materialize.min.js"></script>




        ## Include the head tags of the child template if available.
        <%
            try:
                self.head_tags()
            except AttributeError:
                pass
        %>




        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <link type="text/css" rel="stylesheet" href="/custom/css/materialize.min.css"  media="screen,projection"/>

        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    </head>
    <body>

        <!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->


        <!-- Header  -->

        <!-- Dropdown Structure -->
        <ul id="dropdown1" class="dropdown-content">
            % for l in languages:
                <li><a href="${handle_query_string(request.url, add=[('_LOCALE_', l[0])])}" class="text-accent-color">${l[1]}</a></li>
            % endfor
        </ul>
        <nav class="grey lighten-2">
            <div class="nav-wrapper">
                <div class="row">
                    <div class="col s10 offset-s1">
                        <a href="${request.route_url('index')}" class="brand-logo">
                            % if mode == 'demo':
                                <img src="/custom/img/logo_demo.png" class="lo_logo" alt="${_('Land Observatory')}" />
                            % else:
                                <img src="/custom/img/logo_new.png" alt="${_('Land Observatory')}"/>
                            % endif
                        </a>
                        <ul class="right hide-on-med-and-down">
                            <li><a class="dropdown-button text-accent-color" href="#!" data-activates="dropdown1">${selectedlanguage[1]}<i class="material-icons right">arrow_drop_down</i></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>

        <script type="text/javascript">
            $(".dropdown-button").dropdown();
        </script>

        <main>
            <div class="row">
              <div class="col s10 offset-s1 col-main-page">
                  <br>
                  <div class="card-panel accent-color">
                      <span class="white-text"><strong>${_('The Land Observatory')} </strong>${_('is a pilot project by some partners of the')} <a href="http://www.landmatrix.org">${_('Land Matrix')}</a>, ${_('designed to provide greater context and deeper insight on land deals, from a more local perspective.')}</span>
                  </div>
                  ${self.body()}
              </div>
            </div>
        </main>

        <footer class="grey lighten-2" style="height: 40px; width: 100%; left: 10%;">
            <div class="row" style="margin: 0; padding: 0;">
                <div class="col s10 offset-s1" style="line-height: 40px;">
                    <ul>
                        <%
                            # The entries of the footer as arrays with
                            # - url
                            # - name
                            footer = [
                                [request.route_url('faq_view'), _('FAQ')],
                                [request.route_url('about_view'), _('About')],
                                [request.route_url('partners_view'), _('Partners & Donors')]
                            ]
                        %>

                        % for f in footer:
                        <li class="right"
                            % if request.current_route_url() == f[0]:
                                class="active"
                            % endif
                            >
                            <a class="text-accent-color" href="${f[0]}">${f[1]}</a>
                        </li>
                        % endfor
                    </ul>
                </div>
            </div>
        </footer>
        <style>
            footer li {
                display: inline;
                padding-left: 15px;
                margin-bottom: 0px;
            }
            main {
              min-height: calc(100% - 64px - 40px); // 1000% - navbar - footer
            }
        </style>

        <script type="text/javascript">
         /* <![CDATA[ */
         document.write(unescape("%3Cscript src='" + (("https:" == document.location.protocol) ? "https://" : "http://") + "www.google.com/jsapi' type='text/javascript'%3E%3C/script%3E"));
         /* ]]> */
        </script>



        <script src="/custom/js/main.js"></script>
        <link rel="stylesheet" href="/custom/css/custom.css">

        % if use_piwik_analytics==True:
        <!-- Piwik -->
        <script type="text/javascript">
          var _paq = _paq || [];
          _paq.push(["trackPageView"]);
          _paq.push(["enableLinkTracking"]);

          (function() {
            var u=(("https:" == document.location.protocol) ? "https" : "http") + "://webstats.landobservatory.org/";
            _paq.push(["setTrackerUrl", u+"piwik.php"]);
            _paq.push(["setSiteId", "1"]);
            var d=document, g=d.createElement("script"), s=d.getElementsByTagName("script")[0]; g.type="text/javascript";
            g.defer=true; g.async=true; g.src=u+"piwik.js"; s.parentNode.insertBefore(g,s);
          })();
        </script>
        <!-- End Piwik Code -->
        % endif

        ## Include the bottom tags of the child template if available.
        <%
            try:
                self.bottom_tags()
            except AttributeError:
                pass
        %>

    </body>
</html>
