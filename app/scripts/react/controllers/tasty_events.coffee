window.TastyEvents = new EventEmitter()

TastyEvents.keys =
  follow_status_changed:               (tlogId) -> "follow_status:#{ tlogId }:changed"
  hero_closed:                                  -> "hero:closed"
  comment_replied:                    (entryId) -> "comment:#{entryId}:replied"
  comment_form_toggled:                         -> "comment_form:toggled"
  user_property_changed: (propertyName, userId) -> "#{ propertyName }:#{ userId }:changed"