EditorStore = require '../../../stores/editor'
EditorActionCreators = require '../../../actions/editor'
ConnectStoreMixin = require '../../../../../shared/react/mixins/connectStore'
StringHelpers = require '../../../../../shared/helpers/string'
EditorTextField = require '../fields/Text'
EditorEmbed = require '../Embed/Embed'
EditorTypeInstagramWelcome = require './Instagram/Welcome'
{ PropTypes } = React

EditorTypeInstagram = React.createClass
  displayName: 'EditorTypeInstagram'
  mixins: [ConnectStoreMixin(EditorStore)]

  propTypes:
    entry: PropTypes.object.isRequired
    entryType: PropTypes.string.isRequired

  render: ->
    <article className="post post--video post--edit">
      <div className="post__content">
        <EditorEmbed
            embedUrl={ @state.embedUrl }
            embedHtml={ @state.embedHtml }
            onCreate={ @handleCreateEmbed }
            onChaneEmbedUrl={ @handleChangeEmbedUrl }
            onDelete={ @handleDeleteEmbed }>
          <EditorTypeInstagramWelcome />
        </EditorEmbed>
        <EditorTextField
            mode="partial"
            text={ @state.title }
            placeholder={ i18n.t('editor_description_placeholder') }
            onChange={ @handleChangeTitle } />
      </div>
    </article>

  handleCreateEmbed: ({embedHtml, title}) ->
    EditorActionCreators.changeEmbedHtml embedHtml
    # Перезаписываем title описание с iframely, только если он пустой либо с тегами без контента
    unless StringHelpers.removeTags @state.title
      EditorActionCreators.changeTitle title

  handleDeleteEmbed: ->
    EditorActionCreators.deleteEmbedUrl()
    EditorActionCreators.deleteEmbedHtml()

  handleChangeTitle: (title) ->
    EditorActionCreators.changeTitle title

  handleChangeEmbedUrl: (embedUrl) ->
    EditorActionCreators.changeEmbedUrl embedUrl

  getStateFromStore: ->
    title: EditorStore.getEntryValue 'title'
    embedUrl: EditorStore.getEntryValue 'embedUrl'
    embedHtml: EditorStore.getEntryValue 'embedHtml'

module.exports = EditorTypeInstagram