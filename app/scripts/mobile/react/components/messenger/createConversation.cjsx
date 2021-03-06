CreateConversationHeader = require './createConversation/header'
MessengerChooser         = require './createConversation/chooser'
{ PropTypes } = React

MessengerCreateConversation = React.createClass
  displayName: 'MessengerCreateConversation'

  propTypes:
    onCreate: PropTypes.func.isRequired

  render: ->
    <div className="messages__section messages__section--recipients">
      <CreateConversationHeader />
      <div className="messages__body">
        <MessengerChooser onItemSelect={ @props.onCreate } />
      </div>
    </div>

module.exports = MessengerCreateConversation