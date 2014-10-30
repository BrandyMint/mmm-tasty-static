###* @jsx React.DOM ###
#= require ./settings_radio_item

window.ToolbarSettings = React.createClass
  mixins: [
    'ReactActivitiesUser', ReactShakeMixin, React.addons.LinkedStateMixin
    RequesterMixin, ComponentManipulationsMixin
  ]

  propTypes:
    title: React.PropTypes.string.isRequired
    user:  React.PropTypes.instanceOf(Backbone.Model).isRequired

  getInitialState: ->
    isProcess: false
    user:      @props.user

  save: (key, value) ->
    console.log 'save', key, value
    @incrementActivities()

    @setState isProcess: true

    data = {}
    data[key] = value

    @createRequest
      url:  ApiRoutes.update_profile_url()
      data: data
      dataType: 'JSON'
      method:   'PUT'
      success: (data) =>
        TastyEvents.trigger TastyEvents.keys.user_property_changed( key, @props.user.id ), [value]

        if key is 'slug'
          TastyLockingAlertController.show
            title:   'Внимание!'
            message: "Сейчас будет произведён переход по новому адресу вашего тлога (#{ data.tlog_url })"
            action:  -> window.location = data.tlog_url

        @props.user.set data
      error: (data) =>
        @shake()
        TastyNotifyController.errorResponse data
      complete: =>
        @safeUpdateState isProcess: false
        @decrementActivities()

  render: ->
    saveCallback = @save

    return `<div className="settings">
              <form>
                <SettingsHeader user={ this.state.user }
                                activitiesHandler={ this.props.activitiesHandler }
                                saveCallback={ saveCallback } />

                <div className="settings__body">
                  <SettingsRadioItem title="Закрытый дневник?"
                                     description="Тлог виден только подписчикам, стать которым можно после одобрения. Ну и вам конечно."
                                     user={ this.state.user }
                                     saveCallback={ saveCallback }
                                     key="is_privacy" />

                  <SettingsRadioItem title="Тлогодень"
                                     description="Это режим отображения, когда на странице показываются записи только за один день."
                                     user={ this.state.user }
                                     saveCallback={ saveCallback }
                                     key="is_daylog" />

                  <SettingsRadioItem title="Вы - девушка"
                                     description="На Тейсти сложилось так, что 7 из 10 пользователей – это девушки. Поэтому по-умолчанию для всех именно такая настройка."
                                     user={ this.state.user }
                                     saveCallback={ saveCallback }
                                     key="is_female" />

                  <SettingsEmail email={ this.state.user.get('email') }
                                 confirmationEmail={ this.state.user.get('confirmation_email') }
                                 isConfirmed={ this.state.user.get('is_confirmed') }
                                 saveCallback={ saveCallback } />

                  <SettingsRadioItem title="Уведомления"
                                     description="Отправлять мне емейл уведомления обо всех новых комментариях, подписчиках и личных сообщениях?"
                                     user={ this.state.user }
                                     saveCallback={ saveCallback }
                                     key="available_notifications"/>

                  <SettingsPasswordItem saveCallback={ saveCallback } />

                  <SettingsAccountsItem accounts={ [] }
                                        user={ this.state.user } />
                </div>
              </form>
            </div>`