## Form to CREATE or EDIT an activity.

<%
    import colander
    new_form = 'id' not in cstruct or cstruct['id'] == colander.null
    _ = request.translate
%>

## load google map api
<script type="text/javascript"
        src="//maps.googleapis.com/maps/api/js?v=3&key=${str(request.registry.settings.get('lokp.google_maps_api_key'))}&libraries=places"></script>


<h3>${_('Deal Editor')}</h3>

% if new_form is True:
    <p class="id">${_('New Deal')}</p>
% else:
    <p class="id">${cstruct['id']}</p>
% endif

<form
    id="${field.formid}"
    class="item-form"
    action="${field.action}"
    method="${field.method}"
    enctype="multipart/form-data"
    accept-charset="utf-8">

    <input type="hidden"
           name="_charset_"
    />
    <input type="hidden"
           name="__formid__"
           value="${field.formid}"
    />

    <div class="row">
        <div class="deal-editor-menu-bar col l3 pull-right">
            <div id="menu-affix" data-clampedwidth=".deal-editor-menu-bar">
                % for button in field.buttons:
                    <ul>
                        % if button.css_class == 'formstepactive':
                            <div class="active-wrapper">
                        % endif

                        <li
                            % if button.name == 'submit':
                                style="background-color:teal;"
                            % endif
                            >
                            % if button.name == 'submit':
                                <button
                                    id="${field.formid + button.name}"
                                    name="${button.name}"
                                    value="${button.value}"
                                    style="width: 100%"
                                    class="btnText ${button.css_class}">
                                    ${button.title}
                                    <i class="material-icons right">send</i>
                                </button>
                            % else:
                                <button
                                    id="${field.formid + button.name}"
                                    name="${button.name}"
                                    value="${button.value}"
                                    style="width: 100%"
                                    class="btnText ${button.css_class}">
                                    ${button.title}
                                </button>
                            % endif

                            % if button.css_class == 'formstepvisited':
                                <span class="form-button-visited"><i class="icon-ok-sign"></i></span>
                            % endif
                        </li>

                        % if button.css_class == 'formstepactive':
                            </div>
                        % endif
                    </ul>
                % endfor
            </div>
        </div>
        <div class="col l9">
            % if field.error:
                <div class="alert alert-error">
                    <h5>${_("There was a problem with your submission")}</h5>
                    ${_("Errors have been highlighted below")}
                </div>
            % endif
            % for child in field.children:
                ${child.render_template(field.widget.item_template)}
            % endfor
        </div>
    </div>

    % if field.use_ajax:
        <script type="text/javascript">
            deform.addCallback(
                '${field.formid}',
                function(oid) {
                    var target = '#' + oid;
                    var options = {
                        target: target,
                        replaceTarget: true,
                        success: function() {
                            deform.processCallbacks();
                            deform.focusFirstInput(target);
                        }
                   };
                   var extra_options = ${field.ajax_options} || {};
                   $('#' + oid).ajaxForm($.extend(options, extra_options));
                }
            );
        </script>
    % endif

</form>
