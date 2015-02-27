browserify     = require 'browserify'
watchify       = require 'watchify'
gulp           = require 'gulp'
source         = require 'vinyl-source-stream'
coffeeReactify = require 'coffee-reactify'
bundleLogger   = require '../../util/bundleLogger'
handleErrors   = require '../../util/handleErrors'
config         = require('../../config').desktop.local.scripts.client

gulp.task '[D] ClientScripts', ->
  bundler = browserify({
    cache: {}, packageCache: {}
    entries: config.entries
    extensions: config.extensions
  }).external 'jquery'
    .external 'jquery.ui.core'
    .external 'jquery.ui.slider'
    .external 'jquery.ui.draggable'
    .external 'jquery.ui.mouse'
    .external 'jquery.ui.widget'
    .external 'jquery.autosize'
    .external 'jquery.autosize.input'
    .external 'jquery.collage'
    .external 'jquery.waypoints'
    .external 'jquery.fileupload'
    .external 'jquery.shapeshift'
    .external 'react'
    .external 'react-mixin-manager'
    .external 'reactUjs'
    .external 'react-color-picker'
    .external 'baron'
    .external 'mousetrap'
    .external 'bowser'
    .external 'eventEmitter'
    .external 'pusher'
    .external 'i18next'
    .external 'bootstrap.tooltip'
    .external 'Modernizr'
    .external 'swfobject'
    .external 'introJs'
    .external 'es5-shim'
    .external 'jquery.mousewheel'
    .external 'jquery.scrollto'
    .external 'undo'
    .external 'medium-editor'
    .external 'screenviewer'
    .external 'aviator'
    .external 'nanobar'

  bundler.transform coffeeReactify

  bundle = ->
    bundleLogger.start config.outputName

    return bundler
             .bundle()
             .on 'error', handleErrors
             .pipe source(config.outputName)
             .pipe gulp.dest(config.dest)
             .on 'end', ->
               bundleLogger.end config.outputName

  if global.isWatching
    bundler = watchify bundler
    bundler.on 'update', bundle

  return bundle()