###* @jsx React.DOM ###

window.Popup = React.createClass
  mixins: [ReactUnmountMixin]

  propTypes:
    title:       React.PropTypes.string.isRequired
    hasActivities:  React.PropTypes.bool
    onClose:     React.PropTypes.func
    isDark:      React.PropTypes.bool
    isDraggable: React.PropTypes.bool

    # например popup--settings, popup--persons
    className:   React.PropTypes.string

  getDefaultProps: ->
    hasActivities: false
    isDark:        true
    isDraggable:   false

  componentDidMount: ->
    $('body').addClass 'no-scroll'
    Mousetrap.bind 'esc', @close
    @makeDraggable() if @props.isDraggable

  componentWillUnmount: ->
    $('body').removeClass 'no-scroll'
    Mousetrap.unbind 'esc', @close

  render: ->
    # TODO координаты сохранять в localStorage
    classes = popup: true, 'popup--dark': @props.isDark, 'popup--center': true
    classes[@props.className] = true if @props.className?
    cx = React.addons.classSet classes

    return `<div className={cx}>
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
    $headboxNode = @refs.header.getDOMNode()

    $popupNode.draggable
      handle: $headboxNode
      stop:   (event, ui) => PositionsController.savePosition @props.title, ui.offset

  close: ->
    if @props.onClose? then @props.onClose() else @unmount()
