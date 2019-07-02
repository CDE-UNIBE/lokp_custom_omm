<%inherit file="lokp:customization/omm/templates/base.mak" />

<%def name="title()">${_('Deal Details')} ${shortuid}</%def>

<link rel="stylesheet" href="${request.static_url('lokp:static/css/leaflet.css')}">

<%def name="head_tags()">
    <link rel="stylesheet" href="/custom/css/details.css"></link>
</%def>

<div class="container">
    <div class="content no-border">
        ${form | n}
        %if site_key is not None:
            <div class="row-fluid">
                <div id="comments-div" class="comments-div">
                    ${_('Loading comments ...')}
                </div>
            </div>
        %endif
    </div>
    <div id="disqus_thread"></div>
</div>

<%def name="bottom_tags()">

<script type="text/javascript">
    var identifier = '${uid}';
    var version = ${version};
</script>
<%include file="lokp:templates/map/mapform.mak" args="readonly=True" />
% if site_key is not None:
<script type="text/javascript" class="juvia">
    (function() {
        var options = {
            container: "#comments-div",
            site_key: "${site_key}",
            topic_key   : "${uid}",
            topic_url   : location.href,
            topic_title : document.title || location.href,
            include_base: !window.Juvia,
            include_css : !window.Juvia
        };

        function makeQueryString(options) {
            var key, params = [];
            for (key in options) {
                params.push(
                encodeURIComponent(key) +
                    '=' +
                    encodeURIComponent(options[key]));
            }
            return params.join('&');
        }

        function makeApiUrl(options) {
            // Makes sure that each call generates a unique URL, otherwise
            // the browser may not actually perform the request.
            if (!('_juviaRequestCounter' in window)) {
                window._juviaRequestCounter = 0;
            }

            var result =
                "${comments_url}/api/show_topic.js" +
                '?_c=' + window._juviaRequestCounter +
                '&' + makeQueryString(options);
            window._juviaRequestCounter++;
            return result;
        }

        var s       = document.createElement('script');
        s.async     = true;
        s.type      = 'text/javascript';
        s.className = 'juvia';
        s.src       = makeApiUrl(options);
        (document.getElementsByTagName('head')[0] ||
            document.getElementsByTagName('body')[0]).appendChild(s);
    })();
</script>
%endif

</%def>


<script>

/**
*  Enable comment system
*  see https://disqus.com/admin/universalcode/#configuration-variables*/

var disqus_config = function () {
this.page.url = "https://www.mmlandreporting.info/${shortuid}";  // Replace PAGE_URL with your page's canonical URL variable
this.page.identifier = "${shortuid}"; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
};

##  https://help.disqus.com/en/articles/1717138-why-are-the-same-comments-showing-up-on-multiple-pages


(function() { // DON'T EDIT BELOW THIS LINE
var d = document, s = d.createElement('script');
s.src = 'https://mmlandreporting.disqus.com/embed.js';
s.setAttribute('data-timestamp', +new Date());
(d.head || d.body).appendChild(s);
})();
</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
