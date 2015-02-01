window.VideoMediaBox_Loading = React.createClass

  propTypes:
    embedUrl: React.PropTypes.string.isRequired

  render: ->
    <MediaBox_Layout type="video">
      <div className="media-box__info">
        <div className="media-box__text">
          <span>{ this.props.embedUrl }</span>
          <br />
          <span>{ i18n.t('editor_video_mediabox_loading') }</span>
        </div>
      </div>
    </MediaBox_Layout>