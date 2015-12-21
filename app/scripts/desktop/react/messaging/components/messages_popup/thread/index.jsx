/*global ConversationsStore */
import React, { Component, PropTypes } from 'react';
import MessagesPopupThreadForm from './MessagesPopupThreadForm';
import ConversationsListItemEntry from '../conversations/list/ConversationsListItemEntry';
import PublicConversationActions from './PublicConversationActions';
import { PUBLIC_CONVERSATION } from '../../../constants/ConversationConstants';

class MessagesPopupThread extends Component {
  state = this.getStateFromStore();
  componentDidMount() {
    this.listener = this.syncStateWithStore.bind(this);
    ConversationsStore.addChangeListener(this.listener);
  }
  componentWillUnmount() {
    ConversationsStore.removeChangeListener(this.listener);
  }
  syncStateWithStore() {
    this.setState(this.getStateFromStore());
  }
  getStateFromStore() {
    return {
      conversation: ConversationsStore.getConversation(this.props.conversationId),
    };
  }
  onClickHeader(url, ev) {
    ev.preventDefault();
    window.location.href = url;
  }
  render() {
    const { conversation } = this.state;
    const id = conversation.id;
    const backgroundUrl = conversation.type === PUBLIC_CONVERSATION
      ? conversation.entry.author.design.backgroundImageUrl
      : conversation.recipient.design.backgroundImageUrl;
    const threadStyles  = { backgroundImage: `url(${backgroundUrl})` };
    const userCount = conversation.type === PUBLIC_CONVERSATION
      ? conversation.users.length
      : 0;

    return (
      <div className="messages__section messages__section--thread">
        {conversation.type === PUBLIC_CONVERSATION &&
          <ConversationsListItemEntry
            conversation={conversation}
            hasUnread={conversation.unread_messages_count}
            isInList={false}
            onClick={this.onClickHeader.bind(this, conversation.entry.url)}
          >
            <PublicConversationActions conversation={conversation} />
          </ConversationsListItemEntry>
        }
        <div className="messages__body" style={threadStyles}>
          <div className="messages__thread-overlay" />
          <MessagesPopup_ThreadMessageList conversationId={id} />
        </div>
        <footer className="messages__footer">
          <MessagesPopupThreadForm conversationId={id} userCount={userCount} />
        </footer>
      </div>
    );
  }
}

MessagesPopupThread.propTypes = {
  conversationId: PropTypes.number.isRequired,
};
  
export default MessagesPopupThread;
