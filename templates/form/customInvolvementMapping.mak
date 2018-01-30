${field.start_mapping()}

% for child in field.children:
    ${child.render_template(field.widget.item_template)}
% endfor

${field.end_mapping()}

<%
    import colander
    import json
    newForm = 'id' in cstruct and cstruct['id'] == colander.null
    _ = request.translate
%>

<p>
    <a
        id="remove-involvement-${field.oid}"
        href=""
        class="btn btn-small btn-warning remove-involvement"
        onclick="return removeInvolvement(this);"
        % if newForm:
            style="display:none;"
        % endif
        >
        <i class="icon-remove"></i>
        ${_('Remove the Investor')}
    </a>
</p>

<div>
    <div class="accordion add-involvement" id="accordion-${field.oid}">


        <ul class="collapsible">
            <li>
                <div class="collapsible-header">
                    <a class="accordion-toggle collapsed text-accent-color" data-toggle="collapse" data-parent="#accordion-${field.oid}" href="#accordion-content-${field.oid}">
                        <i class="icon-plus text-accent-color"></i> ${_('Select an Investor')}
                    </a>
                </div>

            <div id="accordion-content-${field.oid}" class="collapsible-body collapse">
                <div class="accordion-inner">
                    <p>
                        ${_('Search the database to find an existing Investor. Start typing (at least 4 characters) to search an Investor and select it.')}
                    </p>

                    <div class="input-prepend span10">
                      <!--<span class="add-on"><i class="icon-search"></i></span>-->
                      <input class="span12 searchinvestor" id="searchinvinput-${field.oid}" type="text" placeholder="${_('Search an Investor')}"/>
                    </div>

                </div>
            </div>
            </li>
        </ul>
        <div class="row-fluid">
            <p>
                ${_('Nothing found? Maybe the Investor is not yet in the database. You can create a new Investor.')}
            </p>
            <button id="create_involvement"
                    class="btn btn-small btn-primary"
                    value="createinvolvement"
                    name="createinvolvement_${field.name}">
                <i class="icon-pencil"></i>&nbsp;&nbsp;${_('Create a new Investor')}
            </button>
        </div>
    </div>
</div>

<%
    import json
    from lokp.config.customization import getOverviewKeys, getOverviewRawKeys
    aKeys, shKeys = getOverviewKeys(request)
    aRawKeys, shRawKeys = getOverviewRawKeys(request)
%>

<script type="text/javascript">
    var tForUnknown = "${_('Unknown')}";
    var tForNothingfound = "${_('No results found.')}";
    var tForToomanyresults = "${_('Too many results to display. Try to enter more characters')}";

    var searchPrefix = 'sh';
    var queryUrl = "${request.route_url('stakeholders_read_many', output='json')}";
    var shKeys = ${json.dumps(shKeys) | n};
    var shRawKeys = ${json.dumps(shRawKeys) | n};

    deform.addCallback(
        'searchinvinput-${field.oid}',
        function(oid) {
            createSearch(oid, tForUnknown, tForToomanyresults, tForNothingfound,
                queryUrl, searchPrefix, shKeys, shRawKeys);
        }
    );
</script>
