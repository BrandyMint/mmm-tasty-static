import { camelizeKeys } from 'humps';
import { normalize } from 'normalizr';

export const NORMALIZE_DATA = Symbol('Normalize data');

export default (store) => (next) => (action) => {
  const normalizeData = action[NORMALIZE_DATA];
  if (typeof normalizeData === 'undefined') {
    return next(action);
  }

  const { schema, data, type, options } = normalizeData;

  if (!schema) {
    throw new Error('Specify exact schema for normalization');
  }

  if (typeof type !== 'string') {
    throw new Error('Action type must be a string');
  }

  if (typeof data !== 'object') {
    throw new Error('Normalization action should contain a data to normalize');
  }

  if (typeof options !== 'undefined' &&
    typeof options !== 'object') {
    throw new Error('Options must be an object');
  }

  function nextAction(data) {
    const nextActionData = Object.assign({}, action, data);
    delete nextActionData[NORMALIZE_DATA];
    return nextActionData;
  }

  function _process(data) {
    return (options && options.dontCamelize) ?
      data :
      camelizeKeys(data);
  }

  return next(nextAction({ // mimic middleware/api data structure
    response: normalize(_process(data), schema),
    type,
  }));
};
