###* @jsx React.DOM ###

window.PostEditor_EditorContainer = React.createClass
  mixins: ['ReactActivitiesUser']

  propTypes:
    entry:        React.PropTypes.object.isRequired
    entryType:    React.PropTypes.string.isRequired
    entryPrivacy: React.PropTypes.string.isRequired

  render: ->
    if @props.entry?
      editorContainer = `<section className="posts posts--edit">
                           { this._getEditorComponent() }
                         </section>`
    else
      editorContainer = `<div>No entry to edit</div>`

    editorContainer

  saveEntry: ({ entryPrivacy }) ->
    @refs.editor.saveEntry { entryPrivacy }

  redirectToEntryPage: (entry) ->
    if window.TASTY_ENV == 'development'
      alert "Статья #{ entry.id } успешно сохранена"
      window.location.reload()
    else
      _.defer =>
        # TODO Выводить модалку
        TastyNotifyController.notifySuccess 'Опубликовано! Переходим на страницу поста..'
        console.log 'goto', entry.entry_url
        window.location.href = entry.entry_url

  _getEditorComponent: ->
    opts =
      ref:               'editor'
      entry:             @props.entry
      entryType:         @props.entry.type
      entryPrivacy:      @props.entryPrivacy
      activitiesHandler: @activitiesHandler
      doneCallback:      @redirectToEntryPage

    switch @props.entryType
      when 'anonymous'
        editor = @_getTextEditor()
      when 'text'
        editor = @_getTextEditor()
      when 'image'
        editor = @_getImageEditor()
      when 'instagram'
        editor = PostEditor_InstagramEditor opts
      when 'music'
        editor = PostEditor_MusicEditor opts
      when 'video'
        editor = PostEditor_VideoEditor opts
      when 'quote'
        editor = PostEditor_QuoteEditor opts
      else
        console.error "Unknown entry type: #{@props.entryType}"

    editor

  _getTextEditor: ->
    `<PostEditor_TextEditor ref="editor"
                            entryId={ this.props.entry.id }
                            entryType={ this.props.entryType }
                            entryTitle={ this.props.entry.title }
                            entryText={ this.props.entry.text }
                            activitiesHandler={ this.activitiesHandler }
                            doneCallback={ this.redirectToEntryPage } />`

  _getImageEditor: ->
    `<PostEditor_ImageEditor ref="editor"
                             entryId={ this.props.entry.id }
                             entryType={ this.props.entryType }
                             entryTitle={ this.props.entry.title }
                             entryImageUrl={ this.props.entry.image_url }
                             entryImageAttachments={ this.props.entry.image_attachments }
                             entryPrivacy={ this.props.entryPrivacy }
                             activitiesHandler={ this.activitiesHandler }
                             doneCallback={ this.redirectToEntryPage } />`