import React, { PropTypes } from 'react';
import { Map } from 'immutable';
import { connect } from 'react-redux';
import ActivityItemDefault from './ActivityItemDefault';
import ActivityItemEntry from './ActivityItemEntry';
import ActivityItemRel from './ActivityItemRel';
import {
  getTlogEntry,
} from '../../actions/TlogEntryActions';
import {
  NOTIFICATION_FRIEND,
} from '../../actions/NotificationsActions';

const emptyUser = Map();
const emptyEntry = Map();
const emptyRel = Map();

const ENTITY_TYPE_ENTRY = 'Entry';
const ENTITY_TYPE_RELATIONSHIP = 'Relationship';
const ENTITY_TYPE_COMMENT = 'Comment';
const ENTITY_TYPE_ORDER = 'Order';
const ENTITY_TYPE_AUTHENTICATION = 'Authentication';

function ActivityItemContainer(props) {
  const {
    entry,
    entryAuthor,
    entityType,
    getTlogEntry,
    isFetchingEntry,
    item,
    relUser,
    user,
  } = props;

  if (entityType === ENTITY_TYPE_ENTRY) {
    return (
      <ActivityItemEntry
        entry={entry}
        entryAuthor={entryAuthor}
        getTlogEntry={getTlogEntry}
        isFetchingEntry={isFetchingEntry}
        item={item}
        user={user}
      />
    );
  } else if (entityType === ENTITY_TYPE_RELATIONSHIP &&
      item.get('type') === NOTIFICATION_FRIEND) {
    return (
      <ActivityItemRel
        item={item}
        relUser={relUser}
        user={user}
      />
    );
  } else {
    return (
      <ActivityItemDefault
        item={item}
        user={user}
      />
    );
  }
}

ActivityItemContainer.propTypes = {
  entityType: PropTypes.string.isRequired,
  entry: PropTypes.object,
  entryAuthor: PropTypes.object,
  getTlogEntry: PropTypes.func.isRequired,
  isFetchingEntry: PropTypes.bool,
  item: PropTypes.object.isRequired,
  relUser: PropTypes.object,
  user: PropTypes.object.isRequired,
};

export default connect(
  (state, { item }) => {
    const entityType = item.get('entityType');
    const entityId = item.get('entityId');
    const user = state
      .entities
      .getIn(['tlog', String(item.get('sender'))], emptyUser);
    let entry, entryAuthor, isFetchingEntry, relUser;

    if (entityType === ENTITY_TYPE_ENTRY) {
      const entryState = state.entryState[entityId];
      entry = state
        .entities
        .getIn(['entry', String(entityId)], emptyEntry);
      isFetchingEntry = !!entryState && entryState.isFetching;
      entryAuthor = state
        .entities
        .getIn(['tlog', String(entry.get('author'))], emptyUser);
    } else if (entityType === ENTITY_TYPE_RELATIONSHIP) {
      const rel = state
        .entities
        .get('rel')
        .find((r) => r.get('id') === entityId, null, emptyRel);
      relUser = state
        .entities
        .getIn(['tlog', String(rel.get('userId'))], emptyUser);
    }

    return {
      entry,
      entryAuthor,
      entityType,
      isFetchingEntry,
      relUser,
      user,
    };
  },
  {
    getTlogEntry,
  }
)(ActivityItemContainer);
