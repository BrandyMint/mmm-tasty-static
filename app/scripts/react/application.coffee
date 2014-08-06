#= require react
#= require react-mixin-manager
#= require react_ujs
#= require ./utils
#= require_tree ./services
#= require_tree ./mixins
#= require_tree ./components/post_editor/mixins
#= require_tree ./components
#= require_tree ./controllers

window.ReactApp =

  start: ->
    console.log 'ReactApp start'
    personsContainer = $('<\div>', {'popup-persons-container': ''}).appendTo('body').get(0)

    $(document).on 'page:change', ReactUjs.mountReactComponents

    @shellbox = new ReactShellBox()
    @popup    = new ReactPopup()

    # Есть только у анонимов
    $('[invite-button]').click => @shellbox.show InviterShellBox

    # TODO Сделать что-то типа $('[static-inviter]').renderReactComponent InviterShellBox(fixed: true)
    if ic = document.getElementById 'js-static-inviter-container'
      React.renderComponent InviterShellBox(fixed: true), ic

window.isMobile = ->
    userAgent = navigator.userAgent || navigator.vendor || window.opera;
    (/iPhone|iPod|iPad|Android|BlackBerry|Opera Mini|IEMobile/).test(userAgent);
