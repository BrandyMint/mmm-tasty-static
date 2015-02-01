cx = require 'react/lib/cx'

window.PostEditor_InstagramEditor = React.createClass
  mixins: ['PostEditor_PersistenceMixin', 'ReactActivitiesUser', PostEditor_AutosaveMixin
            PostEditor_VideoMixin]

  render: ->
    instagramEditorClasses = cx
      'post':        true
      'post--video': true
      'post--edit':  true
      'state--loading': @hasActivities()

    return <article className={ instagramEditorClasses }>
             <div className="post__content">
               <VideoMediaBox embedUrl={ this.state.embedUrl }
                              embedHtml={ this.state.embedHtml }
                              activitiesHandler={ this.activitiesHandler }
                              onDeleteEmbeded={ this.handleDeleteEmbeded }
                              onSuccessLoad={ this.successLoaded }>
                 <MediaBox_InstagramWelcome />
               </VideoMediaBox>
               <TastyEditor ref="titleEditor"
                            placeholder={ i18n.t('editor_description_placeholder') }
                            mode="partial"
                            content={ this.state.title }
                            isLoading={ this.hasActivities() }
                            onChange={ this.startAutosave } />
             </div>
           </article>