import React, { PropTypes } from 'react';
import EntryTlogCommentForm from './EntryTlogCommentForm';

function EntryTlogCommentEditForm({ comment, commentator, onCancel, onCommentUpdate, process }) {
  return (
    <EntryTlogCommentForm
      commentator={commentator}
      onCancel={onCancel}
      onSubmit={onCommentUpdate}
      process={process}
      text={comment.comment_html}
    />
  );
}

EntryTlogCommentEditForm.propTypes = {
  comment: PropTypes.object.isRequired,
  commentator: PropTypes.object.isRequired,
  process: PropTypes.bool,
};
