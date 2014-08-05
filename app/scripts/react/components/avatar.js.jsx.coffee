###* @jsx React.DOM ###

# Вызывается из 
# - SettingsHeader
#
window.Avatar = React.createClass
  #mixins: [ReactComponentWithPureRenderMixin]

  propTypes:
    name:     React.PropTypes.string.isRequired
    userpic:  React.PropTypes.object.isRequired
    size:     React.PropTypes.number

  # Известные размеры аватаров:
  #
  # settings: 110
  # comment:  35
  # hero:     220 
  # brick:    35 

  getDefaultProps: ->
    size: 220 # Этого размера картинки хватает на все аватары

  render: ->
    avatar_url = @props.userpic?['original_url'] || @props.userpic?['large_url']

    if avatar_url?
      avatar_url = ThumborService.image_url avatar_url, '220x220'
      avatarStyles = "background-image": "url(#{avatar_url})"

      return `<span className="avatar"
                    style={ avatarStyles }>
                <img src={ avatar_url }
                     alt={ this.props.name }
                     className="avatar__img" />
              </span>`
    else
      avatarStyles = 'background-color': @props.userpic.default_colors.background, 'color': @props.userpic.default_colors.name

      return `<span title={ this.props.name }
                    className="avatar"
                    style={ avatarStyles }>
                <span className="avatar__text">{ this.props.name.charAt(0) }</span>
              </span>`


# Вызывается из:
# hero profile
# persos popup items
#
window.UserAvatar = React.createClass

  propTypes:
    user: React.PropTypes.object.isRequired
    size: React.PropTypes.number

  render: ->
    Avatar {
      name:    @props.user.name
      userpic: @props.user.userpic
      size:    @props.size
    }
