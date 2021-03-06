/*global i18n */
import React, { Component, PropTypes } from 'react';
import classNames from 'classnames';
import moment from 'moment';
import EditorVoteButton from '../Button/Vote';
import EditorPrivacyButton from '../Button/Privacy';
import EditorPreviewButton from '../Button/Preview';
import EditorSaveButton from '../Button/Save';
import Spinner from '../../../../../shared/react/components/common/Spinner';
import {
  ENTRY_PINNED_STATE,
  ENTRY_AWAITING_PAYMENT_STATE,
} from '../../../constants/EntryConstants';
import {
  TLOG_TYPE_PRIVATE,
  TLOG_TYPE_ANONYMOUS,
  ENTRY_PRIVACY_PRIVATE,
  ENTRY_PRIVACY_PUBLIC,
  ENTRY_PRIVACY_LIVE,
 } from '../../../constants/EditorConstants';

class EditorActions extends Component {
  handleVoteButtonClick() {
    if (this.props.isSaving) {
      return;
    }
    const newEntryPrivacy = this.isEntryLive() ? ENTRY_PRIVACY_PUBLIC : ENTRY_PRIVACY_LIVE;
    this.props.onChangePrivacy(newEntryPrivacy);
  }
  handlePrivacyButtonClick() {
    if (this.props.isSaving) {
      return;
    }
    const newEntryPrivacy = this.isEntryPrivate() ? ENTRY_PRIVACY_PUBLIC : ENTRY_PRIVACY_PRIVATE;
    this.props.onChangePrivacy(newEntryPrivacy);
  }
  onPinEntryButtonClick() {
    const { isSaving, onPinEntry, pinOrderUrl } = this.props;

    if (isSaving || this.isPinned()) {
      return;
    }

    onPinEntry(pinOrderUrl);
  }
  isEntryLive() {
    return this.props.entryPrivacy === ENTRY_PRIVACY_LIVE;
  }
  isEntryPrivate() {
    return this.props.entryPrivacy === ENTRY_PRIVACY_PRIVATE;
  }
  isTlogPrivate() {
    return this.props.tlogType === TLOG_TYPE_PRIVATE;
  }
  isTlogAnonymous() {
    return this.props.tlogType === TLOG_TYPE_ANONYMOUS;
  }
  isVotable() {
    return (
      !(this.isTlogAnonymous() ||
      this.isEntryPrivate() ||
      this.isTlogPrivate()) ||
      !this.props.isEntryForCurrentUser
    );
  }
  isPinned() {
    return this.props.pinState === ENTRY_PINNED_STATE;
  }
  isAwaitingPayment() {
    return this.props.pinState === ENTRY_AWAITING_PAYMENT_STATE;
  }
  saveEntry() {
    if (this.props.isSaving) {
      return;
    }

    this.props.onSaveEntry();
  }
  renderPinEntryButton() {
    const { canPinEntry, pinnedTill } = this.props;
    const isPinned = this.isPinned();

    if (true || !((isPinned && pinnedTill) || canPinEntry) || !this.isVotable()) {
      return null;
    }

    const pinnedTillStr = moment(pinnedTill).format('H:mm D MMMM');
    const buttonClasses = classNames({
      'button': true,
      'post-settings-button': true,
      'post-settings-promotion-button': true,
      '__promoted': isPinned,
    });
    const buttonText = isPinned
      ? i18n.t('buttons.editor.pin_entry_promoted', { date: pinnedTillStr })
      : this.isAwaitingPayment()
        ? i18n.t('buttons.editor.pin_entry_awaiting_payment')
        : i18n.t('buttons.editor.pin_entry');

    return (
      <div className="post-action post-action--button" onClick={this.onPinEntryButtonClick.bind(this)}>
        <button className={buttonClasses}>
          {buttonText}
        </button>
      </div>
    );
  }
  renderVoteButton() {
    if (this.isVotable()) {
      return (
        <div className="post-action post-action--button">
          <EditorVoteButton enabled={this.isEntryLive()} onClick={this.handleVoteButtonClick.bind(this)} />
        </div>
      );
    }
  }
  renderPrivacyButton() {
    if (this.props.isEntryForCurrentUser && !this.isTlogAnonymous()) {
      return (
        <div className="post-action post-action--button">
          <EditorPrivacyButton
            isLive={this.isEntryLive()}
            isPrivate={this.isEntryPrivate()}
            onClick={this.handlePrivacyButtonClick.bind(this)}
          />
        </div>
      );
    }
  }
  renderSpinner() {
    return (
      <div className="post-action post-action--loader">
        <Spinner size={8} />
      </div>
    );
  }
  render() {
    const {
      isSaving,
      isEntryForCurrentUser,
      togglePreview,
      tlog,
    } = this.props;
    const actionsClasses = classNames({
      'post-actions': true,
      'state--loading': isSaving,
    });

    return (
      <div className={actionsClasses}>
        {isSaving && this.renderSpinner()}
        {this.renderPinEntryButton()}
        {this.renderVoteButton()}
        {this.renderPrivacyButton()}
        <div className="post-action post-action--button">
          <EditorPreviewButton onClick={togglePreview} />
        </div>
        <div className="post-action post-action--button">
          <div className="button-group">
            <EditorSaveButton
              isEntryForCurrentUser={isEntryForCurrentUser}
              isPrivate={this.isEntryPrivate()}
              onClick={this.saveEntry.bind(this)}
              tlog={tlog.get('tag', '')}
            />
          </div>
        </div>
      </div>
    );
  }
}

// <div className="post-action post-action--button">
//   <button className="button button--outline button--gray">
//     Привязать пост к потоку
//   </button>
// </div>

EditorActions.propTypes = {
  canPinEntry: PropTypes.bool,
  entryPrivacy: PropTypes.string.isRequired,
  isEntryForCurrentUser: PropTypes.bool.isRequired,
  isSaving: PropTypes.bool.isRequired,
  onChangePrivacy: PropTypes.func.isRequired,
  onPinEntry: PropTypes.func.isRequired,
  onSaveEntry: PropTypes.func.isRequired,
  pinOrderUrl: PropTypes.string,
  pinState: PropTypes.string,
  pinnedTill: PropTypes.string,
  tlog: PropTypes.object,
  tlogType: PropTypes.string.isRequired,
  togglePreview: PropTypes.func.isRequired,
};

export default EditorActions;
