###* @jsx React.DOM ###

NO_TRANSITION_CLASS = "no--transition"

window.Popup = React.createClass
  mixins: [ReactUnmountMixin, ReactPositionsMixin]

  propTypes:
    title:         React.PropTypes.string.isRequired
    hasActivities: React.PropTypes.bool
    onClose:       React.PropTypes.func
    isDark:        React.PropTypes.bool
    isDraggable:   React.PropTypes.bool
    position:      React.PropTypes.object

    # например popup--settings, popup--persons
    className:   React.PropTypes.string

  getDefaultProps: ->
    hasActivities: false
    isDark:        false
    isLight:       false
    isDraggable:   false

  componentDidMount: ->
    @makeDraggable() if @props.isDraggable

    Mousetrap.bind 'esc', @close

  componentWillUnmount: ->
    Mousetrap.unbind 'esc', @close

  render: ->
    classes = {
      'popup':         true
      'popup--dark':   @props.isDark
      'popup--light':  @props.isLight
      'popup--center': true
    }

    classes[@props.className] = true if @props.className?

    popupClasses = React.addons.classSet classes

    return `<div className={ popupClasses }
                 style={ this.initialPositionStyle() }>
              <PopupHeader title={ this.props.title } ref="header"
                           isDraggable= { this.props.isDraggable }
                           hasActivities={ this.props.hasActivities }
                           onClickClose={ this.close }></PopupHeader>
              <div className="popup__body">
                { this.props.children }
              </div>
            </div>`

  makeDraggable: ->
    $popupNode = $(@getDOMNode())
    headboxNode = @refs.header.getDOMNode()

    $popupNode.draggable
      handle: headboxNode
      drag: -> $popupNode.addClass NO_TRANSITION_CLASS
      stop: (event, ui) =>
        @checkPosition()
        @savePosition ui.position
        $popupNode.removeClass NO_TRANSITION_CLASS

  close: ->
    if @props.onClose? then @props.onClose() else @unmount()