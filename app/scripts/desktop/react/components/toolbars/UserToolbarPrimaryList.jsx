import UserToolbarListItem from './UserToolbarListItem';

let UserToolbarPrimaryList = React.createClass({
  propTypes: {
    user: React.PropTypes.object.isRequired,
    unreadBestCount: React.PropTypes.number.isRequired,
    unreadConversationsCount: React.PropTypes.number.isRequired,
    unreadFriendsCount: React.PropTypes.number.isRequired,
    unreadLiveCount: React.PropTypes.number.isRequired,
    unreadNotificationsCount: React.PropTypes.number.isRequired,
    stayOpen: React.PropTypes.bool.isRequired,
    onMessagesClick: React.PropTypes.func.isRequired,
    onNotificationsClick: React.PropTypes.func.isRequired,
    onFriendsClick: React.PropTypes.func.isRequired,
    onDesignSettingsClick: React.PropTypes.func.isRequired,
  },

  render() {
    return (
      <ul className="toolbar__nav">
        <UserToolbarListItem
          url={Routes.new_entry_url(this.props.user.slug)}
          title={ i18n.t('toolbar_new_entry_item') }
          icon="icon--plus"
        />
        <UserToolbarListItem
          badgeClassName="messages-badge"
          badgeCount={this.props.unreadFriendsCount}
          icon="icon--friends"
          title={i18n.t('feed_friends')}
          url={Routes.friends_feed_path()}
        />
        <UserToolbarListItem
          url={Routes.flows()}
          title={i18n.t('toolbar_flows_item')}
          label="new"
          labelClassName="toolbar__label--new"
          icon="icon--hash"
        />
        <UserToolbarListItem
          badgeClassName="messages-badge"
          badgeCount={this.props.unreadLiveCount}
          icon="icon--wave"
          title={i18n.t('feed_live')}
          url={Routes.live_feed_path()}
        />
        <UserToolbarListItem
          badgeClassName="messages-badge"
          badgeCount={this.props.unreadBestCount}
          icon="icon--fire"
          title={i18n.t('feed_best')}
          url={Routes.best_feed_path()}
        />
        <UserToolbarListItem
          icon="icon--people"
          title={i18n.t('feed_people')}
          url={Routes.people_path()}
        />
        <UserToolbarListItem
          url={Routes.anonymous_feed_path()}
          title={i18n.t('feed_anonymous')}
          icon="icon--anonymous"
        />
        <UserToolbarListItem
          title={i18n.t('toolbar_messages_item')}
          badgeCount={this.props.unreadConversationsCount}
          badgeClassName="messages-badge"
          icon="icon--messages"
          onClick={this.props.onMessagesClick}
        />
        <UserToolbarListItem
          title={i18n.t('toolbar_notifications_item')}
          badgeCount={this.props.unreadNotificationsCount}
          badgeClassName="notifications-badge"
          icon="icon--bell"
          onClick={this.props.onNotificationsClick}
        />
        <UserToolbarListItem
          url={Routes.favorites_url(this.props.user.slug)}
          title={i18n.t('toolbar_favorites_item')}
          icon="icon--star"
        />
        <UserToolbarListItem
          url={Routes.private_entries_url(this.props.user.slug)}
          title={i18n.t('toolbar_privates_item')}
          icon="icon--lock"
        />
        <UserToolbarListItem
          title={i18n.t('toolbar_friends_item')}
          icon="icon--friends"
          onClick={this.props.onFriendsClick}
        />
        <UserToolbarListItem
          url={Routes.userDesignSettings(this.props.user.slug)}
          title={i18n.t('toolbar_design_item')}
          icon="icon--drawing"
          onClick={this.props.onDesignSettingsClick}
        />
      </ul>
    );
  }
});

export default UserToolbarPrimaryList;
