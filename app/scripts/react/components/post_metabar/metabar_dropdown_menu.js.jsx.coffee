###* @jsx React.DOM ###

DROPDOWN_CLOSED = 'closed'
DROPDOWN_OPENED_BY_HOVER = 'openedByHover'
DROPDOWN_OPENED_BY_CLICK = 'openedByClick'

window.MetabarDropdownMenu = React.createClass
  mixins: [ReactUnmountMixin]

  propTypes:
    entryId:          React.PropTypes.number.isRequired
    isFavorited:      React.PropTypes.bool.isRequired
    isWatching:       React.PropTypes.bool.isRequired
    entryUrl:         React.PropTypes.string.isRequired
    successDeleteUrl: React.PropTypes.string
    editUrl:          React.PropTypes.string
    canFavorite:      React.PropTypes.bool.isRequired
    canWatch:         React.PropTypes.bool.isRequired
    canReport:        React.PropTypes.bool.isRequired
    canDelete:        React.PropTypes.bool.isRequired

  getInitialState: ->
    currentState: DROPDOWN_CLOSED

  render: ->
    actionList = []
    menuClasses = React.addons.classSet {
      'meta-item__dropdown': true
      'state--open': @isOpen()
    }

    if @props.editUrl
      actionList.push `<MetabarDropdownMenuItem title="Редактировать"
                                                icon="icon--pencil"
                                                href={ this.props.editUrl }
                                                key="edit" />`
    actionList.push `<MetabarDropdownMenuItem title="Ссылка на запись"
                                              icon="icon--hyperlink"
                                              href={ this.props.entryUrl }
                                              key="link" />`
    if @props.canFavorite
      actionList.push `<MetabarDropdownMenuFavoriteItem entryId={ this.props.entryId }
                                                        isFavorited={ this.props.isFavorited }
                                                        key="favorite" />`
    if @props.canWatch
      actionList.push `<MetabarDropdownMenuWatchItem entryId={ this.props.entryId }
                                                     isWatching={ this.props.isWatching }
                                                     key="watch" />`
    if @props.canReport
      actionList.push `<MetabarDropdownMenuReportItem entryId={ this.props.entryId }
                                                      key="report" />`
    if @props.canDelete
      actionList.push `<MetabarDropdownMenuDeleteItem entryId={ this.props.entryId }
                                                      successDeleteUrl={ this.props.successDeleteUrl }
                                                      onDelete={ this.onDelete }
                                                      key="delete" />`

    return `<span onClick={ this.onClick }
                  onMouseEnter={ this.onMouseEnter }
                  onMouseLeave={ this.onMouseLeave }
                  className="meta-item__content">
              <i className="meta-item__common icon icon--dots"></i>
              <span className={ menuClasses }>{ actionList }</span>
            </span>`

  onClick: ->
    switch @state.currentState
      when DROPDOWN_CLOSED          then @setState currentState: DROPDOWN_OPENED_BY_CLICK
      when DROPDOWN_OPENED_BY_CLICK then @setState currentState: DROPDOWN_CLOSED
      when DROPDOWN_OPENED_BY_HOVER then @setState currentState: DROPDOWN_CLOSED
      else console.error? "Unknown state.currentState", @state.currentState

  onMouseEnter: ->
    if @state.currentState == DROPDOWN_CLOSED
      @setState currentState: DROPDOWN_OPENED_BY_HOVER

  onMouseLeave: ->
    if @state.currentState == DROPDOWN_OPENED_BY_HOVER
      @setState currentState: DROPDOWN_CLOSED

  onDelete: -> @unmount() if @isMounted()

  isOpen: -> @state.currentState != DROPDOWN_CLOSED