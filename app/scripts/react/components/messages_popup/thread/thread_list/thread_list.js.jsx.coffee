###* @jsx React.DOM ###

window.MessagesPopup_ThreadList = React.createClass

  render: ->
   `<div>
      <div className="messages__empty state--hidden">
        <div className="messages__empty-text">Здесь будут отображаться сообщения</div>
      </div>
      <div className="message message--from">
        <span className="messages__user-avatar">
          <span className="avatar avatar--eighth">
            <span className="avatar__text">M</span>
          </span>
        </span>
        <div className="messages__bubble">
          <span className="messages__user-name">madwotrld</span> Правоспособность лица может быть поставлена под сомнение, если понятие политического участия методологически…
        </div>
        <span className="messages__date">Вчера в 20:08</span>
      </div>
      <div className="message message--to">
        <span className="messages__user-avatar">
          <span className="avatar" style={{ 'background-image': 'url(images/avatars/ava_6.png)' }}>
            <img className="avatar__img" src="images/avatars/ava_6.png" alt="vladaserb" />
          </span>
        </span>
        <div className="messages__bubble">
          <span className="messages__user-name">vladaserb</span> Бред какой-то. Сама придумала?
        </div>
        <span className="messages__date">18 минут назад</span>
      </div>
      <div className="message message--from">
        <span className="messages__user-avatar">
          <span className="avatar avatar--eighth">
            <span className="avatar__text">M</span>
          </span>
        </span>
        <div className="messages__bubble">
          <span className="messages__user-name">madwotrld</span> Нет,<br /> <a href="http://vesna.yandex.ru" title="http://vesna.yandex.ru">http://vesna.yandex.ru</a><br /> подсказал
        </div>
        <span className="messages__date">Только что</span>
      </div>
    </div>`