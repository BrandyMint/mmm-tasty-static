import React, { Component, PropTypes } from 'react';
import PrivacyBadge from '../common/PrivacyBadge';
import EntryTlogMetabar from './EntryTlogMetabar';
import EntryTlogActions from './EntryTlogActions';
import EntryTlogComments from './EntryTlogComments';

class EntryTlogSongType extends Component {
  startComment() {
    this.refs.comments.startComment();
  }
  renderTitle() {
    if (this.props.entry.title) {
      return (
        <h1 className="post__title">
          <a href={this.props.entry.audioUrl} target="_blank" className="post__link">
            {this.props.entry.title}
          </a>
        </h1>
      );
    }
  }
  renderActions() {
    if (this.props.hasModeration) {
      return <EntryTlogActions {...this.props} />;
    }
  }
  render() {
    const { isPrivate } = this.props.entry;

    return (
      <span>
        <header className="post__header">
          {isPrivate && <PrivacyBadge />}
          {this.renderTitle()}
        </header>
        <div className="post__meta">
          <EntryTlogMetabar {...this.props} onComment={this.startComment.bind(this)} />
        </div>
        {this.renderActions()}
        <EntryTlogComments {...this.props} ref="comments" />
      </span>
    );
  }
}

EntryTlogSongType.propTypes = {
  commentator: PropTypes.object,
  entry: PropTypes.object.isRequired,
  hasModeration: PropTypes.bool.isRequired,
};

export default EntryTlogSongType;
