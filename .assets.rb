require 'sass'
require 'yui/compressor'

input  'assets'
output 'public'

class CssSquasher
  def call(content, basename)
    [yui.compress(content), basename]
  end

  def yui
    @yui ||= YUI::CssCompressor.new
  end
end

package :sass do
  input  'sass'
  assets '**/*.scss'
  modify do |content, basename|
    [Sass.compile(content), basename]
  end
  concat 'main.min.css'
  modify CssSquasher.new
end

package :fa do
  input  'fonts'
  assets '*.css'
  concat 'fa.min.css'
  modify CssSquasher.new
end

package :fonts do
  input  'fonts'
  output 'fonts'
  assets '**/*'
end
