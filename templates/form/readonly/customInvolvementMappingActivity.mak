% for child in field:
    % if child.name == 'role_name':
        <div class="row-fluid">
            <h5 class="dealview_titel_investor text-accent-color">
                ${_('Involvement as')} ${child.cstruct}
            </h5>
        </div>
        <div class="row-fluid">
            <div class="offset5 span7">
                <a class="waves-effect waves-light btn right" href="${request.route_url('activities_read_one', output='html', uid=cstruct['id'])}">
                    ${_('View Deal')}
                </a>
            </div>
        </div>
    % elif child.name != 'role_id':
        <div class="row-fluid">
            ${child.render_template(field.widget.readonly_item_template)}
        </div>
    % endif
% endfor

