gulp        = require 'gulp'
browserSync = require 'browser-sync'
config      = require('../../config').desktop.local.html
reload      = browserSync.reload

gulp.task '[D] Html', ->
  gulp.src config.src
    .pipe gulp.dest config.dest
    .pipe reload stream: true