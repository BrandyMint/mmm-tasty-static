Spinner                = require '../../../../../shared/react/components/common/Spinner'
CommentsLoadMoreButton = require './buttons/loadMore'
{ PropTypes }  = React

CommentsLoadMore = React.createClass
  displayName: 'CommentsLoadMore'

  propTypes:
    totalCount:         PropTypes.number.isRequired
    loadedCount:        PropTypes.number
    loadPerTime:        PropTypes.number
    loading:            PropTypes.bool.isRequired
    onCommentsLoadMore: PropTypes.func.isRequired

  render: ->
    <div className="comments__more">
      { @renderContent() }
    </div>

  renderContent: ->
    if @props.loading
      <div className="comments__loader">
        <Spinner size={ 14 } />
      </div>
    else
      <CommentsLoadMoreButton
          title={ @getTitle() }
          onClick={ @props.onCommentsLoadMore } />

  getTitle: ->
    remainingCount = @props.totalCount - @props.loadedCount
    possibleCount  = @props.loadedCount + @props.loadPerTime

    if possibleCount < @props.totalCount
      i18n.t 'buttons.comments_load_more', count: @props.loadPerTime
    else
      i18n.t 'buttons.comments_load_more_remaining', count: remainingCount

module.exports = CommentsLoadMore