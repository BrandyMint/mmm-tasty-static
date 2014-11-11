STORAGE_PREFIX = 'entries'
window.EntryStore =
  storage: window.localStorage

    # /**
    #  * Получение нормализованных данных Entry
    #  *
    #  * @param {String} entryType - тип Entry
    #  * @param {Object} entry - содержит список уже существующих свойств Entry
    #  * @param {Number} entryId - идентификатор Entry
    #  * @param {String} entryUpdatedAt - дата обновления Entry
    # */

  restoreExistenEntry: (entryId, entryUpdatedAt) ->
    @restore @keyExisten(entryId, entryUpdatedAt)

  restoreNewEntry: ->
    @restore @keyNew()

  restoreAnonymousEntry: ->
    @restore @keyAnonymous()

  storeEntry: (normalizedEntry) ->
    @store @key(normalizedEntry), normalizedEntry

  removeNormalizedEntry: (normalizedEntry) ->
    if normalizedEntry.id?
      key = @keyExisten normalizedEntry.id, normalizedEntry.updatedAt
    else if normalizedEntry.tlogType? && normalizedEntry.tlogType is 'anonymous'
      key = @keyAnonymous()
    else
      key = @keyNew()

    @storage.removeItem key

  store: (key, data) ->
    data.storeAt = new Date().getTime()

    @storage.setItem key, JSON.stringify(data)

  restore: (key) ->
    data = JSON.parse @storage.getItem key

    if data? then new NormalizedEntry(data) else null

  key: (entry) ->
    if entry.id?
      @keyExisten entry.id, entry.updatedAt
    else if entry.tlogType? && entry.tlogType is 'anonymous'
      @keyAnonymous()
    else
      @keyNew()

  keyExisten: (entryId, entryUpdatedAt) ->
    entryUpdatedAt = new Date(entryUpdatedAt).getTime()
    STORAGE_PREFIX + ':' + entryId + ':' + entryUpdatedAt

  keyNew: ->
    STORAGE_PREFIX + ':' + 'new'

  keyAnonymous: ->
    STORAGE_PREFIX + ':' + 'anonymous'