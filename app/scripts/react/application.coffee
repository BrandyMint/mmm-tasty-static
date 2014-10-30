window.ReactApp =

  start: ({ user }) ->
    console.log 'ReactApp start'

    ReactUjs.initEvents()

    @shellbox = new ReactShellBox()
    @popup    = new ReactPopup()

    # Есть только у анонимов
    $('[invite-button]').click => @shellbox.show InviterShellBox

    # TODO Сделать что-то типа $('[static-inviter]').renderReactComponent InviterShellBox(fixed: true)
    if ic = document.getElementById 'js-static-inviter-container'
      React.renderComponent InviterShellBox(fixed: true), ic

    if user?
      window.messagingService = new MessagingService
        user: CurrentUserStore.getUser()