import React, { PropTypes } from 'react';
import * as ProjectTypes from '../../../../shared/react/ProjectTypes';
import EntryBrickMetabar from './EntryBrickMetabar';
import EntryBrickActions from './EntryBrickActions';
import { Link } from 'react-router';
import uri from 'urijs';

function EntryBrickLinkType({ entry, hasModeration, host_tlog_id, onEntryAccept, onEntryDecline }) {
  function renderBrickTitle() {
    return window.SPA
      ? <Link
          className="brick__link"
          title={entry.title}
          to={{ pathname: uri(entry.url).path(), state: { id: entry.id }}}
        >
          <h2 className="brick__title">{entry.title}</h2>
        </Link>
      : <a
          className="brick__link"
          href={entry.url}
          title={entry.title}
        >
          <h2 className="brick__title">{entry.title}</h2>
        </a>;
  }

  return (
    <span>
      <div className="brick__body">
        {entry.title && renderBrickTitle()}
      </div>
      <div className="brick__meta">
        <EntryBrickMetabar
          entry={entry}
          host_tlog_id={host_tlog_id}
        />
      </div>
      <EntryBrickActions
        hasModeration={hasModeration}
        onAccept={onEntryAccept}
        onDecline={onEntryDecline}
      />
    </span>
  );
}

EntryBrickLinkType.propTypes = {
  entry: ProjectTypes.tlogEntry.isRequired,
  hasModeration: PropTypes.bool.isRequired,
  host_tlog_id: PropTypes.number,
  onEntryAccept: PropTypes.func.isRequired,
  onEntryDecline: PropTypes.func.isRequired,
};

export default EntryBrickLinkType;