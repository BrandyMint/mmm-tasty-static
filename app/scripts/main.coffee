jQuery = require 'jquery'
window.React = require('react/addons')
window.ReactUjs = require 'react_ujs'
window._ = require 'underscore'
window.MouseTrap = require 'mousetrap'
window.Routes = {}
window.Tasty = { user: null, host: '3000.vkontraste.ru' }

require './shared/api-routes'
require './react/mixins/shake'
require './react/components/avatar'
require './react/components/email_signin_shellbox'
require './react/components/email_signup_shellbox'
require './react/components/recovery_shellbox'
require './react/components/select_signin_shellbox'
require './react/components/settings_accounts_item'
require './react/components/settings_email_input'
require './react/components/settings_header'
require './react/components/settings_password_input'
require './react/components/settings_radio_item'
require './react/components/settings_vkontakte'
require './react/components/toolbar_settings'
require './react/components/voting'
require './react/components/inviter_shellbox'
require './react/components/popup_box'
require './react/components/shellbox_layer'
require './react/components/follow_button'
require './react/application'

ReactApp.start()
console.log 'main started'