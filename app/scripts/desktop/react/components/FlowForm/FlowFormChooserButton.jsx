let FlowFormChooserButton = React.createClass({
  propTypes: {
    limitReached: React.PropTypes.bool,
    onClick: React.PropTypes.func.isRequired
  },

  render() {
    let text;

    if (this.props.limitReached) {
      text = 'Выбрано максимально число модераторов';
    } else {
      text = 'Укажите модераторов (не более трех)';
    }

    return (
      <div className="flow-form__chooser-button" onTouchTap={this.props.onClick}>
        <div className="flow-form__chooser-button-text">
          {text}
        </div>
      </div>
    );
  }
});

export default FlowFormChooserButton;