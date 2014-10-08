require './settings'
require './libs'
require './routes'
require './shared/api-routes'
require './shared/dmodel'
require './shared/is_mobile'

require './aapp/application'

require './aapp/filters/timeAgo.js.coffee'
require './aapp/controllers/infiniteFeedController.coffee'
require './aapp/application.coffee'

require './react/entities/normalized_entry'

require './react/services/positions'
require './react/services/entry_store'
require './react/services/entry_normalizer'
require './react/services/thumbor'
require './react/services/uuid'

require './react/mixins/unmount'
require './react/mixins/dom_manipulations'
require './react/mixins/component_manipulations'
require './react/mixins/positions'
require './react/mixins/shake'
require './react/mixins/grammar'
require './react/mixins/error_timer'
require './react/mixins/activities'
require './react/mixins/requester'
require './react/mixins/scroller'
require './react/mixins/touch'

require './react/dispatchers/current_user'
require './react/stores/current_user'

# /*============================================
# =            Messaging resourses            =
# ============================================*/

# /*==========  Dispatchers  ==========*/

require './react/messaging/dispatchers/messaging'

# /*==========  Stores  ==========*/

require './react/messaging/stores/messaging_status'
require './react/messaging/stores/connection_state'
require './react/messaging/stores/messages_popup_state'
require './react/messaging/stores/conversations'
require './react/messaging/stores/messages'
require './react/messaging/stores/notifications'

# /*==========  Control structures  ==========*/

require './react/messaging/messaging_service'
require './react/messaging/messaging_requester'
require './react/messaging/messaging_testing'
require './react/messaging/models'

# /*==========  Actions  ==========*/

require './react/messaging/actions/popup'
require './react/messaging/actions/conversation'
require './react/messaging/actions/message'

# /*==========  Mocks  ==========*/

require './react/messaging/mocks/mocks'
require './react/messaging/mocks/messaging_requester'
require './react/messaging/mocks/messaging_service'

# /*==========  Components  ==========*/

require './react/messaging/components/toolbars/indicators/indicators'
require './react/messaging/components/toolbars/indicators/messages'
require './react/messaging/components/toolbars/indicators/notifications'
require './react/messaging/components/messages_popup/ui/back_button'
require './react/messaging/components/messages_popup/ui/create_new_conversation_button'
require './react/messaging/components/messages_popup/messages_popup'
require './react/messaging/components/messages_popup/loading_message'
require './react/messaging/components/messages_popup/conversations/conversations'
require './react/messaging/components/messages_popup/conversations/list/list'
require './react/messaging/components/messages_popup/conversations/list/list_item'
require './react/messaging/components/messages_popup/conversations/list/empty'
require './react/messaging/components/messages_popup/create_new_conversation/create_new_conversation'
require './react/messaging/components/messages_popup/create_new_conversation/chooser/chooser'
require './react/messaging/components/messages_popup/create_new_conversation/chooser/chooser_button'
require './react/messaging/components/messages_popup/create_new_conversation/chooser/chooser_dropdown'
require './react/messaging/components/messages_popup/create_new_conversation/chooser/chooser_results'
require './react/messaging/components/messages_popup/create_new_conversation/chooser/chooser_results_item'
require './react/messaging/components/messages_popup/thread/thread'
require './react/messaging/components/messages_popup/thread/message_form/message_form'
require './react/messaging/components/messages_popup/thread/message_list/message_list'
require './react/messaging/components/messages_popup/thread/message_list/message_list_item'
require './react/messaging/components/messages_popup/thread/message_list/message_list_item_manager'
require './react/messaging/components/messages_popup/thread/message_list/empty'
require './react/messaging/components/notifications_popup/notifications_popup'
require './react/messaging/components/notifications_popup/notifications/notifications'
require './react/messaging/components/notifications_popup/notifications/notification'
require './react/messaging/components/notifications_popup/notifications/empty'

# /*-----  End of Messaging resources  ------*/

require './react/components/avatars/avatar'
require './react/components/avatars/user_avatar'

require './react/components/shellbox/authorization/authorization'
require './react/components/shellbox/authorization/vk'

require './react/components/shellbox/buttons/vk_auth_button'

require './react/components/shellbox/email_signin_shellbox'
require './react/components/shellbox/email_signup_shellbox'
require './react/components/shellbox/recovery_shellbox'
require './react/components/shellbox/select_signin_shellbox'
require './react/components/shellbox/inviter_shellbox'

require './react/components/settings_popup/settings_email/settings_email'
require './react/components/settings_popup/settings_email/edit'
require './react/components/settings_popup/settings_email/show'
require './react/components/settings_popup/settings_email/confirmation'

require './react/components/settings_popup/settings_email/establish/establish'
require './react/components/settings_popup/settings_email/establish/edit'
require './react/components/settings_popup/settings_email/establish/show'

require './react/components/settings_popup/settings_avatar'
require './react/components/settings_popup/settings_name'
require './react/components/settings_popup/settings_title'
require './react/components/settings_popup/settings_accounts_item'
require './react/components/settings_popup/settings_header'
require './react/components/settings_popup/settings_password_input'
require './react/components/settings_popup/settings_radio_item'
require './react/components/settings_popup/settings_vkontakte'
require './react/components/settings_popup/toolbar_settings'

require './react/components/toolbars/user/user'
require './react/components/toolbars/feed/feed'
require './react/components/toolbars/close/close'
require './react/components/toolbars/toolbar_item'

require './react/components/voting'
require './react/components/shellbox_layer'
require './react/components/buttons/load_more'
require './react/components/follow_status'
require './react/components/smart_follow_status'

require './react/components/relationship_buttons/mixins/relationship'
require './react/components/relationship_buttons/follow_button'
require './react/components/relationship_buttons/ignore_button'
require './react/components/relationship_buttons/request_button'
require './react/components/relationship_buttons/guess_button'

# Не работает на странице редактирования постов
# require './shared/jquery.maxlength'
require './react/components/editable_field'

require './react/components/popup_box'
require './react/components/popup/popup'
require './react/components/popup/layout'
require './react/components/popup/spinner'
require './react/components/popup/header'

require './react/components/calendar/calendar'
require './react/components/calendar/calendar_timeline'
require './react/components/calendar/calendar_header'
require './react/components/calendar/calendar_period'
require './react/components/calendar/calendar_marker'

require './react/components/search/search'
require './react/components/search/button'
require './react/components/search/field'

require './react/components/design_settings_popup/design_settings_popup'
require './react/components/design_settings_popup/controls'
require './react/components/design_settings_popup/controls_items/background_item'
require './react/components/design_settings_popup/controls_items/align_item'
require './react/components/design_settings_popup/controls_items/header_color_item'
require './react/components/design_settings_popup/controls_items/feed_color_item'
require './react/components/design_settings_popup/controls_items/font_type_item'
require './react/components/design_settings_popup/controls_items/opacity_item'
require './react/components/design_settings_popup/controls_items/_radiobutton'
require './react/components/design_settings_popup/controls_items/_progressbar'

require './react/components/persons_popup/mixins/panel_mixin'
require './react/components/persons_popup/persons_popup'
require './react/components/persons_popup/menu'
require './react/components/persons_popup/menu_item'

require './react/components/persons_popup/items/item'
require './react/components/persons_popup/items/following_relationship'
require './react/components/persons_popup/items/follower_relationship'
require './react/components/persons_popup/items/request_relationship'
require './react/components/persons_popup/items/guess_relationship'
require './react/components/persons_popup/items/ignored_relationship'

require './react/components/persons_popup/panels/followings_panel'
require './react/components/persons_popup/panels/followers_panel'
require './react/components/persons_popup/panels/guesses_panel'
require './react/components/persons_popup/panels/requests_panel'
require './react/components/persons_popup/panels/ignores_panel'

require './react/components/people/item'

require './react/components/post_editor/mixins/dragging'
require './react/components/post_editor/mixins/persistence'
require './react/components/post_editor/mixins/images_form'
require './react/components/post_editor/mixins/layout'
require './react/components/post_editor/mixins/video'

require './react/components/post_editor/welcome_messages/instagram'
require './react/components/post_editor/welcome_messages/image'
require './react/components/post_editor/welcome_messages/music'
require './react/components/post_editor/welcome_messages/video'

require './react/components/post_editor/video_mediabox/video_mediabox'
require './react/components/post_editor/video_mediabox/loading'
require './react/components/post_editor/video_mediabox/url_insert'
require './react/components/post_editor/video_mediabox/embeded'

require './react/components/post_editor/images_mediabox/loaded'
require './react/components/post_editor/images_mediabox/url_insert'

require './react/components/post_editor/mediabox/actions'
require './react/components/post_editor/mediabox/layout'
require './react/components/post_editor/mediabox/loading_progress'

require './react/components/entry_metabar/entry_metabar'
require './react/components/entry_metabar/author'
require './react/components/entry_metabar/comment'
require './react/components/entry_metabar/date'
require './react/components/entry_metabar/tags'
require './react/components/entry_metabar/tag'
require './react/components/entry_metabar/dropdown_menu'
require './react/components/entry_metabar/dropdown_menu_items/item'
require './react/components/entry_metabar/dropdown_menu_items/favorite_item'
require './react/components/entry_metabar/dropdown_menu_items/watch_item'
require './react/components/entry_metabar/dropdown_menu_items/report_item'
require './react/components/entry_metabar/dropdown_menu_items/delete_item'

require './react/components/entry_comment_box/mixins/comments'
require './react/components/entry_comment_box/entry_comment_box'
require './react/components/entry_comment_box/comment_list/comment_list'
require './react/components/entry_comment_box/comment_list/comment_manager'
require './react/components/entry_comment_box/comment_list/comment'
require './react/components/entry_comment_box/comment_metabar/comment_metabar'
require './react/components/entry_comment_box/comment_metabar/date'
require './react/components/entry_comment_box/comment_metabar/dropdown_menu'
require './react/components/entry_comment_box/comment_metabar/dropdown_menu_items/link_item'
require './react/components/entry_comment_box/comment_metabar/dropdown_menu_items/report_item'
require './react/components/entry_comment_box/comment_metabar/dropdown_menu_items/edit_item'
require './react/components/entry_comment_box/comment_metabar/dropdown_menu_items/delete_item'
require './react/components/entry_comment_box/comment_metabar/reply'
require './react/components/entry_comment_box/comment_form/comment_form'
require './react/components/entry_comment_box/comment_form/comment_create_form_manager'
require './react/components/entry_comment_box/comment_form/comment_edit_form_manager'
require './react/components/entry_comment_box/load_more'

require './react/components/post_editor/actions/actions'
require './react/components/post_editor/actions/buttons/vote'
require './react/components/post_editor/actions/buttons/privacy'

require './react/components/post_editor/editors/mixins/autosave'
require './react/components/post_editor/editors/_tasty'
require './react/components/post_editor/editors/anonymous'
require './react/components/post_editor/editors/text'
require './react/components/post_editor/editors/image'
require './react/components/post_editor/editors/instagram'
require './react/components/post_editor/editors/music'
require './react/components/post_editor/editors/video'
require './react/components/post_editor/editors/quote'

require './react/components/post_editor/choicer'
require './react/components/post_editor/layout'
require './react/components/post_editor/new_post'
require './react/components/post_editor/new_anonymous_post'
require './react/components/post_editor/edit_post'
require './react/components/post_editor/editor_container'
require './react/components/post_editor/demo'
# require './react/components/post_editor/images_container'

require './react/components/hero/profile/profile'
require './react/components/hero/profile/profile_avatar'
require './react/components/hero/profile/profile_head'
require './react/components/hero/profile/profile_stats'
require './react/components/hero/profile/profile_stats_item'

require './react/components/hero/profile/popup/popup'
require './react/components/hero/profile/popup/followers_popup'
require './react/components/hero/profile/popup/followings_popup'
require './react/components/hero/profile/popup/tags_popup'
require './react/components/hero/profile/popup/items/follower_item'
require './react/components/hero/profile/popup/items/following_item'
require './react/components/hero/profile/popup/items/tag_item'

require './shared/utils'
require './shared/fileReceiver'
require './shared/tasty'

require './react/components/images_collage'

require './react/components/spinner'

require './react/components/notifications/tasty_notify'
require './react/components/notifications/tasty_confirm'
require './react/components/notifications/tasty_alert'
require './react/components/notifications/tasty_locking_alert'

require './react/controllers/tasty_events'
require './react/controllers/tasty_notify'
require './react/controllers/tasty_confirm'
require './react/controllers/tasty_alert'
require './react/controllers/tasty_sound'
require './react/controllers/tasty_locking_alert'

require './react/controllers/shellbox'
require './react/controllers/popup'

require './react/mediators/comments'

require './react/utils'
require './react/application'

require './plugins/jquery.collage'

require './editors'

require './gon'

# React_ujs нужно подключать после того как все компоненты загружены
window.ReactUjs = require 'react_ujs'

$ ->
  if localStorage.getItem('userLogged') == "true"
    if localStorage.getItem('userToken')
      SomeUser.api_key.access_token = localStorage.getItem('userToken')

    if localStorage.getItem('userId')
      SomeUser.id = parseInt( localStorage.getItem('userId') )

    window.Tasty.start user: SomeUser
  else
    console.debug? 'Без пользователя'
    window.Tasty.start()
