require 'sass'
require 'yui/compressor'

input  'assets'
output 'public'
logger

behavior :compress do
  modify do |content, _|
    yui = YUI::CssCompressor.new
    [yui.compress(content), _]
  end
end

package :sass do
  input  'sass'
  assets '**/*.scss'

  modify do |content, basename|
    [Sass.compile(content), basename]
  end
  concat 'main.min.css'
  behave :compress
end

package :fa do
  input  'fonts'
  assets '*.css'

  concat 'fa.min.css'
  behave :compress
end

package :fonts do
  input  'fonts'
  output 'fonts'
  assets '**/*'
end
