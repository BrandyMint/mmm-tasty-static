import Api from '../api/api';
import ApiRoutes from '../../../shared/routes/api';
import ErrorService from '../../../shared/react/services/Error';
import { TLOG_SECTION_TLOG } from '../../../shared/constants/Tlog';

export const TLOG_ENTRIES_REQUEST = 'ENTRIES_REQUEST';
export const TLOG_ENTRIES_RECEIVE = 'ENTRIES_RECEIVE';
export const TLOG_ENTRIES_RESET = 'ENTRIES_RESET';
export const TLOG_ENTRIES_DELETE_ENTRY = 'ENTRIES_DELETE_ENTRY';
export const TLOG_ENTRIES_ERROR = 'ENTRIES_ERROR';

const INITIAL_LOAD_LIMIT = 10;

function tlogEntriesReceive(data) {
  return {
    type: TLOG_ENTRIES_RECEIVE,
    payload: data,
  };
}

function tlogEntriesRequest() {
  return {
    type: TLOG_ENTRIES_REQUEST,
  };
}

function tlogEntriesReset() {
  return {
    type: TLOG_ENTRIES_RESET,
  };
}

function tlogEntriesError(error) {
  return {
    type: TLOG_ENTRIES_ERROR,
    payload: error,
  };
}

function fetchTlogEntries(url, data) {
  return Api.entry.load(url, data)
    .fail((xhr) => {
      ErrorService.notifyErrorResponse('Загрузка записей', {
        method: 'fetchTlogEntries(url, data)',
        methodArguments: {url, data},
        response: xhr.responseJSON,
      });
    });
}

function shouldFetchTlogEntries(state, { slug, section, date, query, sinceId }) {
  const { isFetching, date: cDate, query: cQuery, section: cSection,
          sinceId: cSinceId, slug: cSlug } = state.tlogEntries;

  return !isFetching &&
    (slug !== cSlug || date !== cDate || section !== cSection || query !== cQuery ||
     (cSinceId && sinceId == null)); // update only if reset sinceId
}

function getTlogEntries({ slug, section, date, query, sinceId }) {
  return (dispatch) => {
    const url = ApiRoutes.tlogEntries(slug, section, 'tlogs');

    dispatch(tlogEntriesRequest());
    dispatch(tlogEntriesReset());
    return fetchTlogEntries(url, { date, limit: date ? void 0 : INITIAL_LOAD_LIMIT, since_entry_id: sinceId, q: query })
      .then((data) => dispatch(tlogEntriesReceive({ data, date, section, slug, query, sinceId })))
      .fail((error) => dispatch(tlogEntriesError({ error: error.responseJSON, date, section, slug, query, sinceId })));
  };
}

export function getTlogEntriesIfNeeded({ slug, section=TLOG_SECTION_TLOG, date, query, sinceId }) {
  return (dispatch, getState) => {
    if (shouldFetchTlogEntries(getState(), { slug, section, date, query, sinceId })) {
      return dispatch(getTlogEntries({ slug, section, date, query, sinceId }));
    }
  };
}

export function appendTlogEntries() {
  return (dispatch, getState) => {
    const { isFetching, section, slug, query, data: { next_since_entry_id } } = getState().tlogEntries;

    if (isFetching) {
      return null;
    }

    const url = ApiRoutes.tlogEntries(slug, section, 'tlogs');
    const params = { since_entry_id: next_since_entry_id, q: query };

    dispatch(tlogEntriesRequest());
    return fetchTlogEntries(url, params)
      .then((data) => {
        const prevItems = getState().tlogEntries.data.items;
        dispatch(tlogEntriesReceive({ data: { ...data, items: prevItems.concat(data.items) } }));
        return data;
      })
      .fail((error) => dispatch(tlogEntriesError({ error: error.responseJSON })));
  };
}

export function deleteEntry(entryId) {
  return {
    type: TLOG_ENTRIES_DELETE_ENTRY,
    payload: entryId,
  };
}
