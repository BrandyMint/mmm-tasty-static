/*global i18n */
import React, { Component, PropTypes } from 'react';
import classNames from 'classnames';
import ThreadFormUploadButton from './ThreadFormUploadButton';
import ThreadFormMediaPreview from './ThreadFormMediaPreview';
import MessageActions from '../../../actions/MessageActions';
import CurrentUserStore from '../../../../stores/current_user';
import { GROUP_CONVERSATION } from '../../../constants/ConversationConstants';

class ThreadForm extends Component {
  state = {
    user: CurrentUserStore.getUser(),
    hasText: false,
    files: [],
    isLoading: false,
  };
  componentDidMount() {
    this.form = this.refs.messageForm;
    if (this.form instanceof HTMLElement) {
      this.form.focus();
    }
  }
  onKeyDown(ev) {
    if (ev.key === 'Enter' && !ev.shiftKey && !ev.ctrlKey && !ev.altKey && !ev.metaKey) {
      ev.preventDefault();
      this.sendMessage();
    }
  }
  onFileInputChange(ev) {
    if (!window.File || !window.FileList) {
      return;
    }
    const files = [].slice.call(ev.target.files);
    this.setState({ files: this.state.files.concat(files.map(this.getFileData)) });
  }
  onFileRemove(idx) {
    this.setState({
      files: this.state.files.filter((el, i) => i !== idx),
    });
  }
  getFileData(file) {
    return file;
  }
  updateFormState() {
    this.setState({ hasText: this.form && this.form.value !== '' });
  }
  clearForm() {
    this.form.value = '';
    this.setState({ hasText: false, files: [] });
  }
  msgReadyToSend() {
    const { files, hasText } = this.state;

    return (hasText || files.length) && !this.shouldDisableForm();
  }
  shouldDisableForm() {
    const { type, users_left=[], users_kicked=[] } = this.props.conversation;
    const { user: { id } } = this.state;

    return type === GROUP_CONVERSATION &&
      (users_left.indexOf(id) > -1 || users_kicked.indexOf(id) > -1);
  }
  sendMessage() {
    if (this.msgReadyToSend()) {
      MessageActions.newMessage({
        content: this.form.value,
        files: this.state.files,
        conversationId: this.props.conversation.id,
      });

      this.clearForm();
    }
  }
  render() {
    const { userCount } = this.props;
    const disabledInputs = this.shouldDisableForm();

    const buttonClasses = classNames({
      'message-form__button-send': true,
      '--disabled': !this.msgReadyToSend(),
    });

    return (
      <div className="message-form">
        <div className="message-form__controls">
          <div className="message-form__textarea-container">
            <textarea
              className="message-form__textarea"
              disabled={disabledInputs}
              onChange={this.updateFormState.bind(this)}
              onKeyDown={this.onKeyDown.bind(this)}
              placeholder={i18n.t('new_message_placeholder')}
              ref="messageForm"
            />
          </div>
          <ThreadFormMediaPreview
            files={this.state.files}
            onFileRemove={this.onFileRemove.bind(this)}
          />
          <div className="message-form__button-container">
            <ThreadFormUploadButton
              disabled={disabledInputs}
              onChange={this.onFileInputChange.bind(this)}
            />
            <button
              className={buttonClasses}
              onTouchTap={this.sendMessage.bind(this)}  
            >
              {i18n.t('buttons.messenger.send')}
            </button>
            <span className="message-form__users">
              {userCount > 1 && i18n.t('messages_public_users', { count: userCount })}
            </span>
          </div>
        </div>
      </div>
    );
  }
}

ThreadForm.propTypes = {
  conversation: PropTypes.object.isRequired,
  userCount: PropTypes.number,
};

ThreadForm.defaultProps = {
  userCount: 0,
};

export default ThreadForm;