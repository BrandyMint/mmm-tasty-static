_ = require 'lodash'
Constants = require '../constants/constants'
CurrentUserStore = require '../stores/current_user'

# TIMEOUT = 50000
_pendingRequests = {}

prepareData = (sourceData) ->
  data = {}

  Object.keys(sourceData).forEach (key, idx) ->
    data[key] = sourceData[key] if sourceData[key]?

  return data

abortPendingRequests = (key) ->
  if _pendingRequests[key]
    _pendingRequests[key].abort()
    _pendingRequests[key] = null

userToken = ->
  CurrentUserStore.getAccessToken()

csrfToken = ->
  tokenNode = document.querySelector '[name="csrf-token"]'

  if tokenNode? then tokenNode.getAttribute('content') else null

request = (_method, url, data = {}) ->
  headers =
    'X-Requested-With': 'XMLHttpRequest'
    'X-Tasty-Client-Name': 'web_desktop'
    'X-Tasty-Client-Version': gon.version

  headers['X-User-Token'] = userToken() if userToken()
  headers['X-CSRF-Token'] = csrfToken() if csrfToken()

  method = switch _method
    when 'GET'                   then 'GET'
    when 'POST', 'PUT', 'DELETE' then 'POST'
    else 'GET'

  if data instanceof FormData
    contentType = false
    processData = false
    data.append('_method', _method)
  else
    contentType = 'application/x-www-form-urlencoded'
    processData = true
    data = _.extend {}, data, {_method}

  $.ajax
    url: url
    method: method
    data: data
    contentType: contentType
    processData: processData
    headers: headers
    # timeout: TIMEOUT
    xhrFields:
      withCredentials: true
      crossDomain:     true

getRequest = (url, data) -> request 'GET', url, data
postRequest = (url, data) -> request 'POST', url, data
putRequest = (url, data) -> request 'PUT', url, data
deleteRequest = (url, data) -> request 'DELETE', url, data

Api =
  search:
    loadNextPage: (searchUrl) ->
      key = Constants.api.SEARCH_LOAD_NEXT_PAGE

      abortPendingRequests key
      _pendingRequests[key] = getRequest searchUrl

  design:
    saveCurrent: (design, userID) ->
      url  = ApiRoutes.design_settings_url userID
      key  = Constants.api.DESIGN_SAVE
      data = design

      abortPendingRequests key
      _pendingRequests[key] = putRequest url, data

    createBgImage: (formData) ->
      url = ApiRoutes.backgrounds()
      key = Constants.api.CREATE_BG_IMAGE

      abortPendingRequests key
      _pendingRequests[key] = postRequest url, formData

  editor:
    createImageAttachment: (formData) ->
      url = ApiRoutes.imageAttachments()
      key = Constants.api.EDITOR_CREATE_IMAGE_ATTACHMENT

      _pendingRequests[key] = postRequest url, formData

    deleteImageAttachment: (attachmentID) ->
      url = ApiRoutes.imageAttachmentsWithID attachmentID
      key = Constants.api.EDITOR_DELETE_IMAGE_ATTACHMENT

      _pendingRequests[key] = deleteRequest url

    createEmbed: (embedUrl) ->
      url  = ApiRoutes.iframely_url()
      key  = Constants.api.EDITOR_CREATE_EMBED
      data = url: embedUrl

      abortPendingRequests key
      _pendingRequests[key] = postRequest url, data

    createEntry: (url, data) ->
      key = Constants.api.EDITOR_CREATE_ENTRY

      abortPendingRequests key
      _pendingRequests[key] = postRequest url, data

    updateEntry: (url, data) ->
      key = Constants.api.EDITOR_UPDATE_ENTRY

      abortPendingRequests key
      _pendingRequests[key] = putRequest url, data

  notifications:
    load: (sinceID) ->
      url = ApiRoutes.notificationsUrl()
      key = Constants.api.LOAD_NOTIFICATIONS
      data =
        to_notification_id: sinceID

      abortPendingRequests key
      _pendingRequests[key] = getRequest url, data

    markAsRead: (notificationID) ->
      url = ApiRoutes.notifications_read_url(notificationID)
      key = Constants.api.READ_NOTIFICATION

      # 1 запрос = 1 прочитанному сообщению. При закрытии уведомлений может быть более
      # одного запроса на прочтение уведомления. Позволяем делать параллельные запросы.
      _pendingRequests[key] = putRequest url

  relationship:
    unfollow: (objectID, subjectID) ->
      url = ApiRoutes.tlogRelationshipsToTlog objectID, subjectID, 'unfollow'
      key = Constants.api.UNFOLLOW_TLOG

      abortPendingRequests key
      _pendingRequests[key] = postRequest url

    unfollowFromYourself: (objectID, subjectID) ->
      url = ApiRoutes.tlogRelationshipsByTlog objectID, subjectID
      key = Constants.api.UNFOLLOW_TLOG_FROM_YOURSELF

      abortPendingRequests key
      _pendingRequests[key] = deleteRequest url

    follow: (objectID, subjectID) ->
      url = ApiRoutes.tlogRelationshipsToTlog objectID, subjectID, 'follow'
      key = Constants.api.FOLLOW_TLOG

      abortPendingRequests key
      _pendingRequests[key] = postRequest url

    cancel: (objectID, subjectID) ->
      url = ApiRoutes.tlogRelationshipsToTlog objectID, subjectID, 'cancel'
      key = Constants.api.CANCEL_TLOG

      abortPendingRequests key
      _pendingRequests[key] = postRequest url

    ignore: (objectID, subjectID) ->
      url = ApiRoutes.tlogRelationshipsToTlog objectID, subjectID, 'ignore'
      key = Constants.api.IGNORE_TLOG

      abortPendingRequests key
      _pendingRequests[key] = postRequest url

    approve: (objectID, subjectID) ->
      url = ApiRoutes.tlogRelationshipsByApprove objectID, subjectID
      key = Constants.api.APPROVE_REQUEST_TLOG

      abortPendingRequests key
      _pendingRequests[key] = postRequest url

    decline: (objectID, subjectID) ->
      url = ApiRoutes.tlogRelationshipsByDisapprove objectID, subjectID
      key = Constants.api.DISAPPROVE_REQUEST_TLOG

      abortPendingRequests key
      _pendingRequests[key] = postRequest url

    load: (url, sincePosition, limit) ->
      key = Constants.api.LOAD_RELATIONSHIPS
      data = prepareData({
        limit: limit
        since_position: sincePosition
      })

      _pendingRequests[key] = getRequest url, data

  user:
    predict: (query, limit) ->
      url = ApiRoutes.users_predict()
      key = Constants.api.PREDICT_USERS
      data = {query, limit}

      abortPendingRequests key
      _pendingRequests[key] = getRequest url, data

  onboarding:
    load: (params) ->
      url = ApiRoutes.onboarding_url()
      key = Constants.api.USER_ONBOARDING_LOAD

      abortPendingRequests(key);
      _pendingRequests[key] = getRequest(url, params);

  sendSupportRequest: (email, text) ->
    url = ApiRoutes.supportRequest()
    key = Constants.api.SUPPORT_REQUEST
    data = {
      email,
      text
    }

    abortPendingRequests(key)
    _pendingRequests[key] = postRequest(url, data)

  flow:
    create: (formData) ->
      url = ApiRoutes.flows()
      key = Constants.api.CREATE_FLOW

      abortPendingRequests key
      _pendingRequests[key] = postRequest url, formData

    update: (flowID, formData) ->
      url = ApiRoutes.flow(flowID)
      key = Constants.api.UPDATE_FLOW

      abortPendingRequests key
      _pendingRequests[key] = putRequest url, formData

    addStaff: (flowID, userID) ->
      url = ApiRoutes.flowStaffs(flowID)
      key = Constants.api.ADD_STAFF_FLOW
      data = {user_id: userID}

      abortPendingRequests key
      _pendingRequests[key] = postRequest url, data

    removeStaff: (flowID, userID) ->
      url = ApiRoutes.flowStaffs(flowID)
      key = Constants.api.REMOVE_STAFF_FLOW
      data = {user_id: userID}

      abortPendingRequests key
      _pendingRequests[key] = deleteRequest url, data

    changeStaffRole: (flowID, userID, role) ->
      url = ApiRoutes.flowStaffs(flowID)
      key = Constants.api.CHANGE_STAFF_ROLE_FLOW
      data = {user_id: userID, role}

      abortPendingRequests key
      _pendingRequests[key] = putRequest url, data      

    load: (url, data) ->
      key = Constants.api.LOAD_FLOWS

      abortPendingRequests key
      _pendingRequests[key] = getRequest url, data

    loadMine: (data) ->
      url = ApiRoutes.flowsMine()
      key = Constants.api.LOAD_MY_FLOWS

      abortPendingRequests key
      _pendingRequests[key] = getRequest url, data

    loadAvailable: (data) ->
      url = ApiRoutes.flowsAvailable()
      key = Constants.api.LOAD_AVAILABLE_FLOWS

      abortPendingRequests key
      _pendingRequests[key] = getRequest url, data

module.exports = Api
