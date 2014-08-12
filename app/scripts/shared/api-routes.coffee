ApiRoutes =
  omniauth_url:                       (provider) -> TastySettings.host + 'auth/' + provider

  calendar_url:                         (tlogId) -> TastySettings.api_host + 'v1/tlog/' + tlogId + '/calendar'
  votes_url:                           (entryId) -> TastySettings.api_host + 'v1/entries/' + entryId + '/votes'
  embed_url:                                     -> TastySettings.api_host + 'v1/embed'
  design_settings_url:                    (slug) -> TastySettings.api_host + 'v1/design_settings/' + slug
  design_settings_cover_url:              (slug) -> TastySettings.api_host + 'v1/design_settings/' + slug + '/cover'
  signin_url:                                    -> TastySettings.api_host + 'v1/sessions'
  signup_url:                                    -> TastySettings.api_host + 'v1/users'
  update_profile_url:                            -> TastySettings.api_host + 'v1/users' # method put
  recovery_url:                                  -> TastySettings.api_host + 'v1/users/password/recovery'
  request_confirm_url:                           -> TastySettings.api_host + 'v1/users/confirmation'
  userpic_url:                                   -> TastySettings.api_host + 'v1/users/userpic'

  create_entry_url:                       (type) -> TastySettings.api_host + 'v1/entries/' + type
  update_entry_url:                      (entry) -> TastySettings.api_host + 'v1/entries/' + entry.type + '/' +entry.id
  update_images_url:                   (entryId) -> TastySettings.api_host + 'v1/entries/image/' +entryId+ '/images'

  entry_url:                           (entryId) -> TastySettings.api_host + 'v1/entries/' + entryId
  favorites_url:                                 -> TastySettings.api_host + 'v1/favorites'
  watching_url:                                  -> TastySettings.api_host + 'v1/watching'
  report_url:                          (entryId) -> TastySettings.api_host + '/v1/entries/' + entryId + '/report'

  iframely_url:                                  -> TastySettings.api_host + 'v1/embeding/iframely.json'

  # Relationships
  relationships_summary_url:                     -> TastySettings.api_host + 'v1/relationships/summary'
  relationships_to_url:                  (state) -> TastySettings.api_host + 'v1/relationships/to/' + state
  relationships_by_url:                  (state) -> TastySettings.api_host + 'v1/relationships/by/' + state
  relationships_by_tlog_approve_url:    (tlogId) -> TastySettings.api_host + 'v1/relationships/by/tlog/' + tlogId + '/approve'
  relationships_by_tlog_disapprove_url: (tlogId) -> TastySettings.api_host + 'v1/relationships/by/tlog/' + tlogId + '/disapprove'

  tlog_followers:                       (tlogId) -> TastySettings.api_host + 'v1/tlog/' + tlogId + '/followers'
  tlog_followings:                      (tlogId) -> TastySettings.api_host + 'v1/tlog/' + tlogId + '/followings'
  tlog_tags:                            (tlogId) -> TastySettings.api_host + 'v1/tlog/' + tlogId + '/tags'
  get_my_relationship_url:              (tlogId) -> TastySettings.api_host + 'v1/relationships/to/tlog/' + tlogId

  # Comments
  comments_url:                        (entryId) -> TastySettings.api_host + 'v1/comments'

  # follow, ignore, unfollow, cancel
  change_my_relationship_url:    (tlogId, state) ->
    TastySettings.api_host + 'v1/relationships/to/tlog/' + tlogId + '/' + state

window.Routes.api = ApiRoutes
