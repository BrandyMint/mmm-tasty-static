browserify   = require 'browserify'
gulp         = require 'gulp'
source       = require 'vinyl-source-stream'
bundleLogger = require '../../util/bundleLogger'
handleErrors = require '../../util/handleErrors'
config       = require('../../config').desktop.production.scripts.bundle

gulp.task 'desktopScripts', ->
  bundler = browserify({
    cache: {}, packageCache: {}
    basedir: config.baseDir
    entries: config.entries
    extensions: config.extensions
  })
    .require './bower_components/jquery/dist/jquery',                       { expose: 'jquery' }
    .require './bower_components/jquery-ui/ui/core',                        { expose: 'jquery.ui.core' }
    .require './bower_components/jquery-ui/ui/slider',                      { expose: 'jquery.ui.slider' }
    .require './bower_components/jquery-ui/ui/draggable',                   { expose: 'jquery.ui.draggable' }
    .require './bower_components/jquery-ui/ui/mouse',                       { expose: 'jquery.ui.mouse' }
    .require './bower_components/jquery-ui/ui/widget',                      { expose: 'jquery.ui.widget' }
    .require './bower_components/jquery-autosize/jquery.autosize',          { expose: 'jquery.autosize' }
    .require './bower_components/jquery-waypoints/waypoints',               { expose: 'jquery.waypoints' }
    .require './scripts/desktop/plugins/jquery.autosize.input',             { expose: 'jquery.autosize.input' }
    .require './scripts/desktop/plugins/jquery.collage',                    { expose: 'jquery.collage' }
    .require './bower_components/blueimp-file-upload/js/jquery.fileupload', { expose: 'jquery.fileupload' }
    .require './bower_components/jquery.shapeshift/core/jquery.shapeshift', { expose: 'jquery.shapeshift' }
    .require './bower_components/react/react-with-addons',                  { expose: 'react' }
    .require './bower_components/react-mixin-manager/react-mixin-manager',  { expose: 'react-mixin-manager' }
    .require './scripts/desktop/react/resources/react_ujs',                 { expose: 'reactUjs' }
    .require './bower_components/underscore/underscore',                    { expose: 'underscore' }
    .require './bower_components/baron/baron',                              { expose: 'baron' }
    .require './bower_components/mousetrap/mousetrap',                      { expose: 'mousetrap' }
    .require './bower_components/bowser/bowser',                            { expose: 'bowser' }
    .require './bower_components/eventEmitter/EventEmitter',                { expose: 'eventEmitter' }
    .require './bower_components/pusher/dist/pusher',                       { expose: 'pusher' }
    .require './bower_components/i18next/i18next',                          { expose: 'i18next'}
    .require './bower_components/bootstrap/js/tooltip',                     { expose: 'bootstrap.tooltip' }
    .require './scripts/desktop/shims/modernizr',                           { expose: 'Modernizr' }
    .require './scripts/desktop/shims/swf/swfobject',                       { expose: 'swfobject' }
    .require './bower_components/es5-shim/es5-shim',                        { expose: 'es5-shim' }
    .require './bower_components/jquery.mousewheel/jquery.mousewheel',      { expose: 'jquery.mousewheel' }
    .require './bower_components/jquery.scrollto/jquery.scrollTo',          { expose: 'jquery.scrollto' }
    .require './bower_components/undo/undo',                                { expose: 'undo' }
    .require './bower_components/medium-editor/dist/js/medium-editor',      { expose: 'medium-editor' }
    .require './scripts/desktop/resources/screen_viewer',                   { expose: 'screenviewer' }
    .require './bower_components/aviator/src/main',                         { expose: 'aviator' }
    .require './bower_components/nanobar/index',                            { expose: 'nanobar' }

  bundle = ->
    bundleLogger.start config.outputName

    return bundler
      .bundle()
      .on 'error', handleErrors
      .pipe source(config.outputName)
      .pipe gulp.dest(config.dest)
      .on 'end', ->
        bundleLogger.end config.outputName

  return bundle()