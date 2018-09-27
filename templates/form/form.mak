<%
    """
    This is the main form view which is rendered for both Activities and
    Stakeholders, embedded or not.
    A switch decides which form to render.
    """

    from mako.template import Template
    from pyramid.path import AssetResolver
    lokpAssetResolver = AssetResolver('lokp')

    if cstruct['itemType'] == 'stakeholders':
        # Stakeholders
        if 'embedded' in cstruct:
            # Embedded
            templateName = 'form_stakeholder_embedded.mak'
        else:
            templateName = 'form_stakeholder.mak'
    else:
        # Activities
        templateName = 'form_activity.mak'

    resolver = lokpAssetResolver.resolve('customization/omm/templates/form/%s' % templateName)
    template = Template(filename=resolver.abspath())
%>

${template.render(request=request, field=field, cstruct=cstruct)}


<div id="formModal" class="modal modal-fixed-footer">
    <div class="modal-content">
        <!-- Placeholder for the content of the modal window -->
    </div>
    <div class="modal-footer">
      <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat ">${_('Close')}</a>
    </div>
</div>
