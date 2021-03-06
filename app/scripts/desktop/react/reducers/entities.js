import { Map, fromJS } from 'immutable';
import {
  COMMENT_POST_SUCCESS,
  COMMENT_DELETE_SUCCESS,
} from '../actions/CommentActions';
import {
  ENTRY_FAVORITE_SUCCESS,
  ENTRY_UNFAVORITE_SUCCESS,
  ENTRY_WATCH_SUCCESS,
  ENTRY_UNWATCH_SUCCESS,
} from '../actions/EntryActions';
import {
  STAFF_DELETE_SUCCESS,
} from '../actions/StaffActions';
import {
  CURRENT_USER_USERPIC,
} from '../actions/CurrentUserActions';
import {
  DESIGN_SAVE_SUCCESS,
} from '../actions/DesignActions';
import {
  MSG_CONVERSATION_DELETE_SUCCESS,
  MSG_CONVERSATION_LEAVE_SUCCESS,
  MSG_CONVERSATION_MARK_ALL_READ_REQUEST,
} from '../messaging/actions/ConversationActions';
import {
  MSG_GROUP_SAVE_SUCCESS,
} from '../messaging/actions/GroupSettingsActions';
import {
  MSG_PUSHER_PUSH_CONVERSATION,
  MSG_PUSHER_DELETE_MSGS,
} from '../messaging/actions/PusherActions';
import {
  MSG_MESSAGE_SUBMIT,
} from '../messaging/actions/MessageActions';
import {
  INIT_SET_TLOG,
} from '../actions/InitActions';

const initialState = fromJS({
  ads: {},
  tlog: {},
  rel: {},
  calendar: {},
  calendarPeriod: {},
  marker: {},
  flow: {},
  flowCollItem: {},
  staff: {},
  comment: {},
  entry: {},
  rating: {},
  permission: {},
  entryCollItem: {},
  message: {},
  notification: {},
  conversation: {},
  conversationEntry: {},
});

/**
 * @param {Immutable.Map} state
 * @param {Object} action
 * @return {Immutable.Map}
 */

function handleEntities(state = initialState, action) {
  if (action.response && action.response.entities) {
    return state.mergeDeep(action.response.entities);
  }

  return state;
}

/**
 * @param {Immutable.Map} state
 * @param {Object} action
 * @param {String} action.type
 * @return {Immutable.Map}
 */

function handleExtra(state, action) {
  switch (action.type) {
  case COMMENT_DELETE_SUCCESS:
    if (action.commentId) {
      const comment = state.getIn(['comment', String(action.commentId)]);

      if (comment) {
        return state
          .deleteIn(['comment', String(action.commentId)])
          .updateIn([
            'entry',
            String(comment.get('entryId', '')),
            'commentsCount',
          ], (val) => val - 1);
      }
    }
    break;
  case COMMENT_POST_SUCCESS:
    if (action.entryId) {
      return state.updateIn(['entry', String(action.entryId), 'commentsCount'],
        (val) => val + 1);
    }
    break;
  case ENTRY_FAVORITE_SUCCESS:
    if (action.entryId) {
      return state.setIn(['permission', String(action.entryId), 'isFavorited'],
        true);
    }
    break;
  case ENTRY_UNFAVORITE_SUCCESS:
    if (action.entryId) {
      return state.setIn(['permission', String(action.entryId), 'isFavorited'],
        false);
    }
    break;
  case ENTRY_WATCH_SUCCESS:
    if (action.entryId) {
      return state.setIn(['permission', String(action.entryId), 'isWatching'],
        true);
    }
    break;
  case ENTRY_UNWATCH_SUCCESS:
    if (action.entryId) {
      return state.setIn(['permission', String(action.entryId), 'isWatching'],
        false);
    }
    break;
  case STAFF_DELETE_SUCCESS:
    if (action.response && action.response.result) {
      return state.deleteIn(['staff', String(action.response.result)]);
    }
    break;
  case CURRENT_USER_USERPIC:
    return state.mergeIn(['tlog', String(action.tlogId)], {
      userpic: action.response.result,
    });
  case DESIGN_SAVE_SUCCESS:
    return state.mergeIn(['tlog', String(action.tlogId)], {
      design: action.response.result,
    });
  case MSG_CONVERSATION_DELETE_SUCCESS:
  case MSG_CONVERSATION_LEAVE_SUCCESS:
    return state.deleteIn(['conversation', String(action.conversationId)]);
  case MSG_PUSHER_PUSH_CONVERSATION:
  case MSG_GROUP_SAVE_SUCCESS:
    const {
      response: {
        result,
        entities,
      },
    } = action;

    // prevents dull behavior when merging arrays
    return state.mergeIn(['conversation'], {
      [String(result)]: entities.conversation[result],
    });
  case MSG_MESSAGE_SUBMIT:
    const lastSubmit = state
      .get('message')
      .filter((m) => m.has('submitNr'))
      .sortBy((m) => m.get('submitNr'))
      .last();
    const lastSubmitNr = lastSubmit ?
      (lastSubmit.get('submitNr', 0) + 1) :
      1;

    return state.setIn(
      ['message', action.response.result, 'submitNr'],
      lastSubmitNr
    );
  case MSG_PUSHER_DELETE_MSGS:
    return state
      .update(
        'message',
        Map(),
        (messages) => messages.filterNot(
          (m) => action.deletedUuids.includes(m.get('uuid'))
        )
      );
  case MSG_CONVERSATION_MARK_ALL_READ_REQUEST:
    return state
      .setIn([
        'conversation',
        String(action.conversationId),
        'unreadMessagesCount',
      ], 0);
  }

  return state;
}

export default function entities(state, action) {
  return handleExtra(handleEntities(state, action), action);
}
