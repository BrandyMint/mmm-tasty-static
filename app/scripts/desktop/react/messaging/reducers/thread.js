import createReducer from '../../reducers/createReducer';
import {
  MSG_THREAD_START_SELECT,
  MSG_THREAD_STOP_SELECT,
  MSG_THREAD_RESET_SELECTION,
  MSG_THREAD_TOGGLE_SELECTION,
  MSG_THREAD_SET_REPLY_TO,
  MSG_THREAD_CANCEL_REPLY_TO,
  MSG_THREAD_SET_MESSAGE_TEXT,
  MSG_THREAD_ADD_MESSAGE_FILES,
  MSG_THREAD_REMOVE_MESSAGE_FILE,
  MSG_THREAD_RESET_FORM,
} from '../actions/ThreadActions';
import { Set, fromJS } from 'immutable';

const initialState = fromJS({
  isSelectState: false,
  selectedUuids: Set(),
  replyToUuid: null,
  messageText: '',
  messageFiles: [],
});

const actionMap = {
  [MSG_THREAD_START_SELECT](state) {
    return state.set('isSelectState', true);
  },

  [MSG_THREAD_STOP_SELECT](state) {
    return state.set('isSelectState', false);
  },

  [MSG_THREAD_RESET_SELECTION](state) {
    return state.set('selectedUuids', Set());
  },

  [MSG_THREAD_TOGGLE_SELECTION](state, { uuid }) {
    return state.update(
      'selectedUuids',
      (s) => s.includes(uuid) ? s.delete(uuid) : s.add(uuid)
    );
  },

  [MSG_THREAD_SET_REPLY_TO](state, { uuid }) {
    return state.set('replyToUuid', uuid);
  },

  [MSG_THREAD_CANCEL_REPLY_TO](state) {
    return state.set('replyToUuid', null);
  },

  [MSG_THREAD_SET_MESSAGE_TEXT](state, { text }) {
    return state.set('messageText', text || '');
  },

  [MSG_THREAD_ADD_MESSAGE_FILES](state, { files }) {
    const arrFiles = [].slice.call(files); // convert to Array

    return state.update('messageFiles', (arr) => arr.concat(arrFiles));
  },

  [MSG_THREAD_REMOVE_MESSAGE_FILE](state, { file }) {
    return state.update('messageFiles', (arr) => arr.filter((f) => f !== file));
  },

  [MSG_THREAD_RESET_FORM](state) {
    return state.merge({
      messageText: '',
      messageFiles: [],
    });
  },
};

export default createReducer(initialState, actionMap);


/*
    updateMessage(conversationId, data) {
      const messages = _messages[conversationId] || [];

      messages.forEach((message) => {
        if (message.uuid === data.uuid) {
          if (message.read_at && !data.read_at) { //FIXME temporal fix for race condition
            delete(data.read_at);
          }
          Object.assign(message, data);
        }
      });
    },

    deleteMessages(conversationId, deleted) {
      const messages = _messages[conversationId] || [];

      _selectedIds = _selectedIds.filter((id) => deleted.indexOf(id) < 0);
      _messages[conversationId] = messages.filter((msg) => deleted.indexOf(
        msg.id) < 0);
    },

    deleteUserMessages(conversationId, deleted) {
      const messages = _messages[conversationId] || [];
      const deletedHash = deleted.reduce((acc, { id, content, ...rest }) => {
        return acc[id] = {...rest, content_html: content }, acc;
      }, {});
      const deletedIds = Object.keys(deletedHash)
        .map((id) => parseInt(id, 10));

      _selectedIds = _selectedIds.filter((id) => deletedIds.indexOf(id) < 0);
      messages.forEach((msg) => {
        if (deletedHash[msg.id]) {
          Object.assign(msg, deletedHash[msg.id]);
        }
      });
    },
  }
);

MessagesStore.dispatchToken = MessagingDispatcher.register(({ action }) => {
  switch (action.type) {
  case 'messageSubmitted':
    MessagesStore.pushMessages(action.conversationId, [action.message]);
    MessagesStore.cancelReplyTo();
    MessagesStore.emitChange();
    break;
  case 'messageSendingError':
    MessagesStore.updateMessage(action.conversationId, {
      uuid: action.uuid,
      sendingState: 'error',
    });
    MessagesStore.emitChange();
    break;
  case 'messagesToggleSelection':
    MessagesStore.toggleSelection(action.id);
    MessagesStore.emitChange();
    break;
  case 'closeMessagesPopup':
  case 'openConversation':
  case 'openConversationList':
    MessagesStore.cancelReplyTo();
  case 'messagesResetSelection':
  case 'startSelect':
  case 'stopSelect':
    MessagesStore.resetSelection();
    MessagesStore.emitChange();
    break;
  case 'setReplyTo':
    MessagesStore.setReplyTo();
    MessagesStore.resetSelection();
    MessagesStore.emitChange();
    break;
  case 'cancelReplyTo':
    MessagesStore.cancelReplyTo();
    MessagesStore.emitChange();
  case 'deleteMessages':
    MessagesStore.deleteMessages(action.conversationId, action.messages);
    MessagesStore.emitChange();
    break;
  case 'deleteUserMessages':
    MessagesStore.deleteUserMessages(action.conversationId, action.messages);
    MessagesStore.emitChange();
    break;
  };
});

export default MessagesStore;
*/
