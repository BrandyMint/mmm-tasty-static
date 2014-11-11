###* @jsx React.DOM ###

window.PostEditor_QuoteEditor = React.createClass
  mixins: ['PostEditor_PersistenceMixin', 'ReactActivitiesUser', PostEditor_AutosaveMixin]

  render: ->
   `<article className="post post--quote post--edit">
      <div className="post__content">
        <blockquote className="blockquote">
          <TastyEditor ref="textEditor"
                       placeholder="Текст цитаты (499 символов)"
                       mode="partial"
                       content={ this.entryText() }
                       autofocus={ true }
                       isLoading={ this.hasActivities() }
                       onChange={ this.startAutosave } />

          <div className="blockquote__caption">
            <span className="blockquote__dash">—</span>
            <TastyEditor ref="sourceEditor"
                         placeholder="Автор (не обязательно)"
                         content={ this.entrySource() }
                         isLoading={ this.hasActivities() }
                         onChange={ this.startAutosave } />
          </div>
        </blockquote>
      </div>
    </article>`

  entryText:   -> @props.normalizedEntry.data2
  entrySource: -> @props.normalizedEntry.data1
  entryType:   -> 'quote'

  _getNormalizedData: ->
    data2: @refs.textEditor.content()
    data1: @refs.sourceEditor.content()

  # Используется в ключе data, ajax-запроса
  _getEditorData: ->
    text:   @refs.textEditor.content()
    source: @refs.sourceEditor.content()