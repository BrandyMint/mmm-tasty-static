###* @jsx React.DOM ###

window.PersonsPopup_RequestsPanel = React.createClass
  mixins: ['PersonsPopup_PanelMixin']

  relationUrl: -> ApiRoutes.relationships_by_url 'requested'
  itemClass: PersonsPopup_RequestRelationship

  getStateFromStore: ->
    relationships: RelationshipsStore.getRequests()