_             = require 'lodash'
assign        = require 'react/lib/Object.assign'
BaseStore     = require './_base'
Constants     = require '../constants/constants'
AppDispatcher = require '../dispatcher/dispatcher'

_currentID = null
_conversations = {}

ConversationStore = assign new BaseStore(),

  initSingular: (conversation) ->
    # При пререндере, стор общий для всех пользователей. Чтобы не показывать чужие беседы
    # очистим их.
    _conversations = {}
    _currentID = conversation.id
    _conversations[conversation.id] = conversation
    ConversationStore.emitChange()

  initPlural: (conversations) ->
    # При пререндере, стор общий для всех пользователей. Чтобы не показывать чужие беседы
    # очистим их.
    _conversations = {}
    _.forEach conversations, (item) ->
      _conversations[item.id] = item
    ConversationStore.emitChange()

  get: (id) ->
    _conversations[id]

  getByUserId: (userId) ->
    conversations = Object.keys(_conversations).filter((id) ->
      conv = _conversations[id];
      conv && conv.recipient_id == userId && id
    );

    conversations.length and _conversations[conversations[0]];

  getAll: ->
    _conversations

  setCurrentID: (id) ->
    _currentID = id
    @emitChange()

  getAllChrono: ->
    orderedConversations = []

    _.forEach _conversations, (item) ->
      orderedConversations.push(item) if item.last_message?

    orderedConversations = _.sortBy orderedConversations, (item) ->
      -item.last_message?.id

    orderedConversations

  getCurrentID: ->
    _currentID

  getCurrent: ->
    @get @getCurrentID()

  unreadCountByUserId: (userId) ->
    conversation = this.getByUserId(userId);

    conversation && conversation.unread_messages_count


module.exports = ConversationStore

ConversationStore.dispatchToken = AppDispatcher.register (payload) ->
  action = payload.action

  switch action.type
    when Constants.messenger.INIT_CONVERSATIONS
      ConversationStore.initPlural(action.conversations)

    when Constants.messenger.CREATE_CONVERSATION
      _currentID = action.conversation.id
      _conversations[action.conversation.id] = action.conversation
      ConversationStore.emitChange()

    when Constants.messenger.OPEN_CONVERSATION
      _currentID = action.convID
      ConversationStore.emitChange()

    when Constants.messaging.UPDATE_CONVERSATION
      _conversations[action.conversation.id] = action.conversation
      ConversationStore.emitChange()
