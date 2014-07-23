DRAG_HOVER_CLASS = 'state--drag-hover'
DRAGOFF_TIMEOUT  = 500

window.PostEditor_Dragging =
  dragOver:  ->
    clearTimeout @_dragLeaveTimer if @_dragLeaveTimer?
    @draggingOn()

  dragLeave: ->
    clearTimeout @_dragLeaveTimer if @_dragLeaveTimer?
    @_dragLeaveTimer = setTimeout @draggingOff, DRAGOFF_TIMEOUT

  draggingOn: ->
    @setState isDragging: true

  draggingOff: ->
    @setState isDragging: false

  updateDropZoneClass: (active) ->
    $dropZone = $ @dropZoneNode()
    $dropZone.toggleClass DRAG_HOVER_CLASS, active

  bindDragging: ->
    $(document).on 'dragleave', @dragLeave
    $(document).on 'drop', @draggingOff

  unbindDragging: ->
    $(document).off 'dragleave', @dragLeave
    $(document).off 'drop', @draggingOff

  dropZoneNode: ->
    @refs.layout.refs.dropZone.getDOMNode()
