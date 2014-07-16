###* @jsx React.DOM ###

window.PersonsPopupTab = PersonsPopupTab = React.createClass

  propTypes:
    title:  React.PropTypes.string.isRequired
    type:   React.PropTypes.string.isRequired
    count:  React.PropTypes.number.isRequired
    active: React.PropTypes.bool.isRequired

  handleClick: (e) ->
    e.preventDefault()
    @props.onClick(@props.type)

  render: ->
    linkClasses = React.addons.classSet 'tabs-nav__link': true, 'state--active': @props.active

    return `<li className="tabs-nav__item">
              <a title={ this.props.title }
                 className={ linkClasses }
                 onClick={ this.handleClick }>
                { this.props.title }
                <span className="tabs-nav__count"> { this.props.count }</span>
              </a>
            </li>`

module.exports = PersonsPopupTabs