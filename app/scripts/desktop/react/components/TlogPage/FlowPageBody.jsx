import React, { Component, PropTypes } from 'react';
import EntryTlogsContainer from '../EntryTlogs/EntryTlogsContainerRedux';
import EntryBricksContainer from '../EntryBricks/EntryBricksContainerRedux';
import FeedFilters from '../FeedFilters';
import { VIEW_STYLE_TLOG } from '../../constants/ViewStyleConstants';

class FlowPageBody extends Component {
  componentDidMount() {
    
  }
  renderTlogs() {
    return (
      <div className="content-area">
        <div className="content-area__bg" />
        <div className="content-area__inner">
          <EntryTlogsContainer {...this.props} />
        </div>
      </div>
    );
  }
  renderBricks() {
    return <EntryBricksContainer {...this.props} />;
  }
  render() {
    const { viewStyle } = this.props.flow;

    return (
      <div className="page-body">
        <div className="layout-outer">
          <FeedFilters navViewMode viewMode={viewStyle} />
          {viewStyle === VIEW_STYLE_TLOG ? this.renderTlogs() : this.renderBricks()}
        </div>
      </div>
    );
  }
}

FlowPageBody.propTypes = {
  FlowActions: PropTypes.object.isRequired,
  TlogEntriesActions: PropTypes.object.isRequired,
  currentUser: PropTypes.object,
  error: PropTypes.string,
  flow: PropTypes.object.isRequired,
  queryString: PropTypes.string,
  sinceId: PropTypes.string,
  tlog: PropTypes.object,
  tlogEntries: PropTypes.object,
};

FlowPageBody.defaultProps = {
  flow: {
    flowpic: {},
    viewStyle: VIEW_STYLE_TLOG,
  },
  tlog: {
    data: {
      author: {
        id: null,
        is_daylog: false,
        is_privacy: false,
      },
      tlog_url: '',
    },
  },
  tlogEntries: {
    data: {
      items: [],
    },
  },
};

export default FlowPageBody;