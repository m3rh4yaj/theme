gulp = require "gulp"

#js
coffee = require "gulp-coffee"
concat = require "gulp-concat"
uglify = require "gulp-uglify"

#rename
rename = require "gulp-rename"

#改行コード
crLfReplace = require "gulp-cr-lf-replace"

#path
dev_path =
  dev:    "./themes/jade-barebone/source/dev/"

build_path =
  js:     "./themes/jade-barebone/source/js/"

#coffee
gulp.task "coffee", ->
  return gulp.src "#{dev_path.dev}common/*.coffee"
    .pipe coffee
      bare: true
    .on "error", console.log
    .pipe gulp.dest "#{dev_path.dev}common/"

gulp.task "coffee_slider", ->
  return gulp.src "#{dev_path.dev}slider/*.coffee"
    .pipe coffee
      bare: true
    .on "error", console.log
    .pipe gulp.dest "#{dev_path.dev}slider/"

#jsファイル結合
gulp.task "concat", ["coffee"], ->
  return gulp.src "#{dev_path.dev}common/*.js"
    .pipe concat "common.js"
    .pipe uglify()
    .pipe rename
      extname: ".min.js"
    .pipe gulp.dest build_path.js

gulp.task "concat_slider", ["coffee_slider"], ->
  return gulp.src "#{dev_path.dev}slider/*.js"
    .pipe concat "slider.js"
    .pipe uglify()
    .pipe rename
      extname: ".min.js"
    .pipe gulp.dest build_path.js

gulp.task "concat_bootstrap", ->
  return gulp.src "#{dev_path.dev}bootstrap/*.js"
    .pipe concat "bootstrap-3.3.5.js"
    .pipe uglify()
    .pipe rename
      extname: ".min.js"
    .pipe gulp.dest build_path.js

gulp.task "concat_ie", ->
  return gulp.src "#{dev_path.dev}ie/*.js"
    .pipe concat "ie.js"
    .pipe uglify()
    .pipe rename
      extname: ".min.js"
    .pipe gulp.dest build_path.js

#デフォルトタスク
#gulp.task("default", ["yaml", "jade"])