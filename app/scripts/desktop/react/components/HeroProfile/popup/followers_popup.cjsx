window.HeroProfileStats_FollowersPopup = React.createClass
  mixins: ['ReactActivitiesUser', ReactUnmountMixin, RequesterMixin, ScrollerMixin
            ComponentManipulationsMixin]

  propTypes:
    tlogId:  React.PropTypes.number.isRequired
    onClose: React.PropTypes.func

  getInitialState: ->
    relationships: null
    isError:       false
    isLoading:     false

  componentDidMount: -> @loadFollowers()

  render: ->
    if @state.relationships?.length > 0
      relationships = @state.relationships.map (relationship, i) =>
        <HeroProfileStats_FollowerItem relationship={ relationship }
                                       key={ i } />

      followerList = <section className="users">{ relationships }</section>
    else
      if @state.isError
        message = <div className="popup__text">{ i18n.t('hero_stats_popup_error') }</div>
      else if @state.isLoading
        message = <div className="popup__text">{ i18n.t('hero_stats_popup_loading') }</div>
      else
        message = <div className="popup__text">{ i18n.t('hero_stats_popup_empty') }</div>
      followerList = <div className="grid-full"><div className="grid-full__middle">{ message }</div></div>

    return <div className="scroller scroller--users" ref="scroller">
             <div className="scroller__pane js-scroller-pane">{ followerList }</div>
             <div className="scroller__track js-scroller-track">
               <div className="scroller__bar js-scroller-bar"></div>
             </div>
           </div>

  loadFollowers: ->
    @safeUpdate => @incrementActivities()
    @setState isError: false, isLoading: true
    @createRequest
      url: ApiRoutes.tlog_followers(@props.tlogId)
      success: (data) =>
        @safeUpdateState relationships: data.relationships
      error:   (data) =>
        @safeUpdateState isError: true
        NoticeService.errorResponse data
      complete: =>
        @safeUpdate => @decrementActivities()
        @safeUpdateState isLoading: false