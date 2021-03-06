Spinner = require '../../../../../shared/react/components/common/Spinner'
{ PropTypes } = React

AuthEmailSubmitButton = React.createClass
  displayName: 'AuthEmailSubmitButton'

  propTypes:
    loading: PropTypes.bool.isRequired

  render: ->
    <button className="outline-auth-button">
      { @renderSpinner() } { i18n.t('buttons.auth_email_submit') }
    </button>

  renderSpinner: ->
    if @props.loading
      <Spinner size={ 14 } />

module.exports = AuthEmailSubmitButton