###* @jsx React.DOM ###

window.PersonsPopup = PersonsPopup = React.createClass
  mixins: [ReactUnmountMixin]

  getDefaultProps: ->
    title: 'Управление подписками'

  getInitialState: ->
    items: {
            followings_count: null
            followers_count:  null
            guesses_count:    null
            blocked_count:    null
          }
    currentTab: 'followings'
    activities: 0

  componentWillMount: -> Mousetrap.bind 'esc', @close

  componentDidMount: -> @getSummaryData()

  componentWillUnmount: -> Mousetrap.unbind 'esc', @close

  getSummaryData: (tlogId) ->
    @incrementActivities()
    xhr = $.ajax
      url: Routes.api.relationships_summary_url()
      success: (data) => @setState items: data
      error:   (data) ->
        TastyNotifyController.errorResponse data

    xhr.always @decrementActivities

  selectTab: (type) -> @setState currentTab: type

  incrementActivities: -> @setState activities: @state.activities+=1
  decrementActivities: -> @setState activities: @state.activities-=1

  close: -> @unmount()

  render: ->
    switch @state.currentTab
      when 'followings' then tabPanel = `<PersonsPopup_FollowingsPanel></PersonsPopup_FollowingsPanel>`
      when 'followers'  then tabPanel = `<PersonsPopup_FollowersPanel></PersonsPopup_FollowersPanel>`
      when 'guesses'    then tabPanel = `<PersonsPopup_GuessesPanel></PersonsPopup_GuessesPanel>`
      # when 'ignored'    then tabPanel = `<BlockedTabPanel></BlockedTabPanel>`
      else console.warn "Неизвестный тип отношений #{@state.currentTab}"

    return `<div className="popup popup--persons popup--dark" style={{ display: 'block', top: '30px', left: '36%'}}>
              <PopupHeader title={ this.props.title }
                           activities={ this.state.activities }
                           handleClose={ this.close }></PopupHeader>
              <div className="popup__body">
                <PersonsPopup_Menu items={ this.state.items }
                                   currentTab={ this.state.currentTab }
                                   onClick={ this.selectTab }></PersonsPopup_Menu>
                { tabPanel }
              </div>
            </div>`

module.exports = PersonsPopup