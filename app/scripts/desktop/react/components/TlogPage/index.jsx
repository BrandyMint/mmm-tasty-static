import React, { Component, PropTypes } from 'react';
import TlogPageBody from './TlogPageBody';
import FlowPageBody from './FlowPageBody';
import {
  TLOG_SECTION_TLOG,
  TLOG_SECTION_FAVORITE,
  TLOG_SECTION_PRIVATE,
} from '../../../../shared/constants/Tlog';

class TlogPageContainer extends Component {
  componentWillMount() {
    const { TlogEntriesActions, params: { slug }, sinceId } = this.props;

    TlogEntriesActions.getTlogEntriesIfNeeded({
      slug,
      section: this.section(this.props),
      date: this.date(this.props.params),
      sinceId: sinceId,
    });
  }
  componentWillReceiveProps(nextProps) {
    this.props.TlogEntriesActions.getTlogEntriesIfNeeded({
      slug: nextProps.params.slug,
      section: this.section(nextProps),
      date: this.date(nextProps.params),
      sinceId: nextProps.sinceId,
    });
  }
  section(props) {
    const { path } = props.route;
    
    if (this.date(props.params)) {
      return TLOG_SECTION_TLOG;
    } else if (path === TLOG_SECTION_PRIVATE || path === TLOG_SECTION_FAVORITE) {
      return path;
    } else {
      return TLOG_SECTION_TLOG;
    }
  }
  date(params = {}) {
    const { year, month, day } = params;

    return (year && month && day) && `${year}-${month}-${day}`;
  }
  render() {
    const { currentUser, currentUserId, flow, isFlow, location, params, queryString, sinceId,
            tlog, tlogEntries, CalendarActions, FlowActions, TlogEntriesActions } = this.props;

    return isFlow
      ? <FlowPageBody
          FlowActions={FlowActions}
          TlogEntriesActions={TlogEntriesActions}
          bgStyle={{ opacity: tlog.data.design.feedOpacity }}
          currentUser={currentUser}
          currentUserId={currentUserId}
          flow={flow}
          location={location}
          queryString={queryString}
          sinceId={sinceId}
          tlog={tlog}
          tlogEntries={tlogEntries}
        />
      : <TlogPageBody
          CalendarActions={CalendarActions}
          TlogEntriesActions={TlogEntriesActions}
          bgStyle={{ opacity: tlog.data.design.feedOpacity }}
          currentUser={currentUser}
          currentUserId={currentUserId}
          queryString={queryString}
          section={this.section(this.props)}
          sinceId={sinceId}
          tlog={tlog}
          tlogEntries={tlogEntries}
        />;
  }
}

TlogPageContainer.propTypes = {
  CalendarActions: PropTypes.object.isRequired,
  FlowActions: PropTypes.object.isRequired,
  TlogEntriesActions: PropTypes.object.isRequired,
  currentUser: PropTypes.object,
  currentUserId: PropTypes.number,
  flow: PropTypes.object.isRequired,
  isFlow: PropTypes.bool,
  location: PropTypes.object.isRequired,
  params: PropTypes.object.isRequired,
  queryString: PropTypes.string,
  route: PropTypes.object,
  sinceId: PropTypes.string,
  tlog: PropTypes.object,
  tlogEntries: PropTypes.object,
};

export default TlogPageContainer;
