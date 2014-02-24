require 'sass'
require 'yui/compressor'

input  'assets'
output 'public'

package :styles do
  assets '**/*.scss'
  modify do |content, basename|
    [Sass.compile(content), basename]
  end
  concat 'main.min.css'
  modify do |content, basename|
    cmp = YUI::CssCompressor.new
    [cmp.compress(content), basename]
  end
end
