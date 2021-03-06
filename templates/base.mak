<%
from lokp.utils.views import handle_query_string
from lokp.views.translation import get_languages
from lokp.views.translation import get_profiles
from urllib.parse import quote_plus
languages = get_languages()
selectedlanguage = languages[0]
for l in languages:
    if locale == l[0]:
        selectedlanguage = l
profiles = get_profiles()
selectedprofile = None
for p in profiles:
   if profile == p[0]:
       selectedprofile = p
mode = None
if 'lokp.mode' in request.registry.settings:
    if str(request.registry.settings['lokp.mode']).lower() == 'demo':
        mode = 'demo'

use_piwik_analytics = False
if 'lokp.use_piwik_analytics' in request.registry.settings:
    if str(request.registry.settings['lokp.use_piwik_analytics']).lower() == "true":
        use_piwik_analytics = True
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!--[if lt IE 7]>      <html xmlns="http://www.w3.org/1999/xhtml" class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html xmlns="http://www.w3.org/1999/xhtml" class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html xmlns="http://www.w3.org/1999/xhtml" class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html xmlns="http://www.w3.org/1999/xhtml" class="no-js"> <!--<![endif]-->
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="content-language" content="${selectedlanguage[0]}" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <link rel="icon" type="image/ico" href="/custom/img/favicon.ico"/>
        <title>
            <%
                try:
                    context.write("%s - %s" % (self.title(), _("Myanmar land reporting")))
                except AttributeError:
                    context.write(_("Myanmar land reporting"))
            %>
        </title>
        <meta name="description" content="" />
        <meta name="viewport" content="width=device-width" />


        <link rel="stylesheet" href="/custom/css/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="/custom/css/main.css">


        <link rel="stylesheet" href="/custom/css/custom.css">

        <!--[if IE 7]>

            <link rel="stylesheet" href="/custom/css/ie7.css">
            <link rel="stylesheet" href="/custom/css/font-awesome/css/font-awesome-ie7.css">

        <![endif]-->
        <!--[if IE 8]>

            <link rel="stylesheet" href="/custom/css/ie8.css"></link>

        <![endif]-->

        <script type="text/javascript" src="/custom/js/vendor/modernizr-2.6.2-respond-1.1.0.min.js"></script>

        <link href="//fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <link type="text/css" rel="stylesheet" href="/custom/css/materialize.min.css"  media="screen,projection"/>

        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <script type="text/javascript" src="/custom/js/vendor/jquery-2.1.1.min.js"></script>

        ## Include the head tags of the child template if available.
        <%
            try:
                self.head_tags()
            except AttributeError:
                pass
        %>

    </head>

    <body onload="whenPageLoaded();">

        <!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->

        <div class="wrap">
            <div id="main" class="clearfix">
                ## Header
                <ul id="dropdown-languages" class="dropdown-content">
                    % for l in languages:
                        <li><a href="${handle_query_string(request.url, add=[('_LOCALE_', l[0])])}" class="text-accent-color">${l[1]}</a></li>
                    % endfor
                </ul>
                <nav class="grey lighten-2" style="z-index: 1001;">
                    <div class="nav-wrapper">
                        <div class="row">
                            <div class="col s10 offset-s1">
                                <a href="#" data-activates="mobile-menu" class="button-collapse text-accent-color"><i class="material-icons">menu</i></a>
                                <a href="${request.route_url('index')}" class="brand-logo" style="float: left !important;">
                                    % if mode == 'demo':
                                        <img src="/custom/img/logo_demo.png" class="lo_logo" alt="${_('Myanmar land reporting')}" />
                                    % else:
                                        <img src="/custom/img/logo_new.png" alt="${_('Myanmar land reporting')}"/>
                                    % endif
                                </a>

                                <ul class="right hide-on-med-and-down">

                                    <%
                                        # The entries of the top menus as arrays
                                        # with
                                        # - an array of urls (the first one being used for the link)
                                        # - icon (li class)
                                        # - name
                                        topmenu = [
                                            [
                                                [request.route_url('map_view')],
                                                'public',
                                                _('Map')
                                            ], [
                                                [
                                                    request.route_url('grid_view'),
                                                    request.route_url('activities_read_many', output='html'),
                                                    request.route_url('stakeholders_read_many', output='html'),
                                                    request.route_url('stakeholders_byactivities_all', output='html')
                                                ],
                                                'list',
                                                _('List')
                                            ], [
                                                [
                                                    request.route_url('charts_overview')
                                                ],
                                                'insert_chart',
                                                _('Charts')
                                            ]
                                        ]
                                    %>
                                    % for t in topmenu:
                                        <li
                                            % if request.current_route_url() in t[0]:
                                                class="active"
                                            % endif
                                            >
                                            <a href="${t[0][0]}${handle_query_string(request.url, return_value='query_string', remove=['bbox', 'order_by', 'dir'])}" class="text-accent-color">
                                                <i class="material-icons left ">${t[1]}</i><span>&nbsp;&nbsp;${t[2]}</span>
                                            </a>
                                        </li>
                                    % endfor



                                    <li class="divider-menu">&nbsp;</li>



                                    ## If the user is logged in, show link to add a new deal
                                    % if request.user:
                                        <li
                                            % if request.current_route_url() == request.route_url('activities_read_many', output='form'):
                                                class="active"
                                            % endif
                                            >
                                            <div>
                                                <a class="text-accent-color" href="${request.route_url('activities_read_many', output='form')}">
                                                    <i class="material-icons left" style="font-size: 20px;">mode_edit</i>${_('New Deal')}
                                                </a>
                                            </div>
                                        </li>
                                    % endif
                                    <li>
                                        <a class="dropdown-button text-accent-color" href="#!" data-activates="dropdown-languages">
                                            <i class="material-icons left" style="font-size: 20px;">language</i>${selectedlanguage[1]}<i class="material-icons right">arrow_drop_down</i>
                                        </a>
                                    </li>
                                    % if request.user is None:
                                        <li>
                                            <div>
                                                <a class="text-accent-color" href="${request.route_url('login_form')}">
                                                    <i class="material-icons left" style="font-size: 20px;">account_circle</i>${_('Login')}
                                                </a>
                                            </div>
                                        </li>
                                    % if mode != 'demo':
                                        <li>
                                            <div>
                                                <a class="text-accent-color" href="${request.route_url('user_self_registration')}">
                                                    <i class="material-icons left" style="font-size: 20px;">person_add</i>${_('Register')}
                                                </a>
                                            </div>
                                        </li>
                                    % endif
                                    % else:
                                        <li>
                                            <div>
                                                <a class="text-accent-color" href="${request.route_url('user_account')}">
                                                    <i class="material-icons left" style="font-size: 20px;">account_circle</i>${request.user.username}
                                                </a>
                                            </div>
                                        </li>
                                        <li>
                                            <div>
                                                <a class="text-accent-color" href="${request.route_url('logout')}">
                                                    <i class="material-icons left" style="font-size: 20px;">exit_to_app</i>${_('Logout')}
                                                </a>
                                            </div>
                                        </li>
                                    % endif
                                </ul>
                            </div>
                        </div>
                    </div>
                </nav>

                <ul id="dropdown-languages-mobile" class="dropdown-content">
                    % for l in languages:
                        <li><a href="${handle_query_string(request.url, add=[('_LOCALE_', l[0])])}" class="text-accent-color">${l[1]}</a></li>
                    % endfor
                </ul>
                <ul class="side-nav" id="mobile-menu">
                    % for t in topmenu:
                        <li>
                            <a class="text-accent-color" href="${t[0][0]}${handle_query_string(request.url, return_value='query_string', remove=['bbox', 'order_by', 'dir'])}">
                                <i class="material-icons left">${t[1]}</i>${t[2]}
                            </a>
                        </li>
                    % endfor

                    <li class="divider-menu">&nbsp;</li>

                    ## If the user is logged in, show link to add a new deal
                    % if request.user:
                        <li
                            % if request.current_route_url() == request.route_url('activities_read_many', output='form'):
                                class="active"
                            % endif
                            >
                            <a class="text-accent-color" href="${request.route_url('activities_read_many', output='form')}">
                                <i class="material-icons left" style="font-size: 20px;">mode_edit</i>${_('New Deal')}
                            </a>
                        </li>
                    % endif
                    % if request.user is None:
                        <li>
                            <a class="text-accent-color" href="${request.route_url('login_form')}">
                                <i class="material-icons left" style="font-size: 20px;">account_circle</i>${_('Login')}
                            </a>
                        </li>
                    % if mode != 'demo':
                        <li>
                            <a class="text-accent-color" href="${request.route_url('user_self_registration')}">
                                    <i class="material-icons left" style="font-size: 20px;">person_add</i>${_('Register')}
                            </a>
                        </li>
                    % endif
                    % else:
                        <li>
                            <a class="text-accent-color" href="${request.route_url('user_account')}">
                                <i class="material-icons left" style="font-size: 20px;">account_circle</i>${request.user.username}
                            </a>
                            <a href="${request.route_url('logout')}" class="blacklink">
                                <i class="material-icons left" style="font-size: 20px;">exit_to_app</i>${_('Logout')}
                            </a>
                        </li>
                    % endif
                    <li>
                        <a class="dropdown-button text-accent-color" href="#!" data-activates="dropdown-languages-mobile">
                            <i class="material-icons left" style="font-size: 20px;">language</i>${selectedlanguage[1]}<i class="material-icons right">arrow_drop_down</i>
                        </a>
                    </li>
                </ul>

                ## End of Header

                ## Content

                ## Use the body of the child template
                <div id="content" style="background-color: white;">
                ${self.body()}
                </div>
                ## End of Content

            </div>
        </div>

        ## Footer
        <footer>
            <div class="row" style="margin: 0;">
                <div class="col s10 offset-s1">
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
                            <li
                                % if request.current_route_url() == f[0]:
                                    class="active"
                                % endif
                                >
                                <a href="${f[0]}">${f[1]}</a>
                            </li>
                        % endfor

                        <li>
                            <a href="https://www.facebook.com/sharer/sharer.php?u=${quote_plus(request.url)}" style="padding-right: 30px;"
                               onclick="javascript:window.open(this.href, '',
                                   'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=500,width=500');return false;">
                                <i class="icon-facebook" style="line-height: 0.5em;"></i>
                            </a>
                        </li>
                        <li>
                            <a href="https://twitter.com/intent/tweet?text=${quote_plus(request.url)}&via=LandObservatory"
                               onclick="javascript:window.open(this.href, '',
                                   'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=500,width=500');return false;">
                                <i class="icon-twitter" style="line-height: 0.5em;"></i>
                            </a>
                        </li>
                        <li>
                            <a href="https://plus.google.com/share?url=${quote_plus(request.url)}"
                               onclick="javascript:window.open(this.href, '',
                                   'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=500,width=500');return false;">
                                <i class="icon-google-plus" style="line-height: 0.5em;"></i>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </footer>

        ## End of Footer

        <script type="text/javascript">
         /* <![CDATA[ */
         document.write(unescape("%3Cscript src='" + (("https:" == document.location.protocol) ? "https://" : "http://") + "www.google.com/jsapi' type='text/javascript'%3E%3C/script%3E"));
         /* ]]> */
        </script>

        <script type="text/javascript" src="/custom/js/vendor/bootstrap.min.js"></script>
        <script type="text/javascript" src="/custom/js/vendor/materialize.min.js"></script>
        <script type="text/javascript" src="/custom/js/vendor/typeahead.js"></script>
        <script type="text/javascript" src="${request.static_url('lokp:static/js/main.js')}"></script>

        % if use_piwik_analytics==True:
        <!-- Piwik -->
        <script type="text/javascript">
          var _paq = _paq || [];
          % if selectedprofile is not None:
          _paq.push(["setCustomVariable", 1, "profile", "${selectedprofile[0]}", "page"])
          % else:
          _paq.push(["setCustomVariable", 1, "profile", "none", "page"])
          % endif
          _paq.push(["trackPageView"]);
          _paq.push(["enableLinkTracking"]);

          (function() {
            var u=(("https:" == document.location.protocol) ? "https" : "http") + "://webstats.landobservatory.org/";
            _paq.push(["setTrackerUrl", u+"piwik.php"]);
            _paq.push(["setSiteId", "2"]);
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

        ## load the side navs (see in map_view) after loading the page, otherwise they dont open
        ## hide load sign
        <script>
            function getPotwTextHeight() {
                return document.getElementById("window-right-bottom").clientHeight-90-$('#bottom-tab1 .potw-text').height();
            }

            function whenPageLoaded() {
                $(".button-collapse").sideNav();
                $('.modal-trigger').leanModal();
                initializeDropdown();
                if ($('#bottom-tab1').length > 0) {
                    document.getElementById("bottom-tab1").style.height = String($('#window-right-bottom').height()-50) + "px";
                    document.getElementById("img-weekpicture").style.width = String($('#window-right-bottom').width()-20) + "px";
                    document.getElementById("img-weekpicture").style.height = "auto";
                    if (document.getElementById("img-weekpicture").clientHeight > (getPotwTextHeight())) {
                        document.getElementById("img-weekpicture").style.height = String(getPotwTextHeight()) + "px";
                        document.getElementById("img-weekpicture").style.width = "auto";
                    }
                }
                $('select').material_select();
            }
            $(window).on( 'resize', function () {
                setTimeout(function(){
                if ($('#bottom-tab1').length > 0) {
                    var picofweek = document.getElementById("img-weekpicture");
                    if (picofweek) {
                        picofweek.style.width = String($('#window-right-bottom').width()-20) + "px";
                        picofweek.style.height = "auto";
                        if (picofweek.clientHeight > (getPotwTextHeight())) {
                            picofweek.style.height = String(getPotwTextHeight()) + "px";
                            picofweek.style.width = "auto";
                        }
                    }
                    document.getElementById("bottom-tab1").style.height = String($('#window-right-bottom').height()-50) + "px";
                    if ($(window).width() > 982) {
                        document.getElementById("window-right-top").style.marginTop = "0px";
                        document.getElementById("main-map-id").style.width = "66.7%";
                        document.getElementById("content").style.height = String(Math.max($('#main-map-id').height(),$('#window_right').height())) + "px";
                        $('#window_right').height(
                                $('#main-map-id').height()
                        );
                    }
                    else {
                        document.getElementById("window-right-top").style.marginTop = "25px";
                        document.getElementById("main-map-id").style.width = "100%";
                        document.getElementById("content").style.height = String($('#main-map-id').height() + $('#window_right').height()) + "px";
                    }
                }
                },250);
            }).resize();
            function initializeDropdown() {
                $('.dropdown-button').dropdown({
                            inDuration: 300,
                            outDuration: 225,
                            constrain_width: false, // Does not change width of dropdown to that of the activator
                            hover: true, // Activate on hover
                            gutter: 0, // Spacing from edge
                            belowOrigin: false, // Displays dropdown below the button
                            alignment: 'left' // Displays dropdown with edge aligned to the left of button
                        }
                );
            }

        </script>

    </body>

</html>
