---
layout: default
title: "Ruby asset processing with Pannier"
tags:
  - ruby
  - asset pipeline
  - rack
  - pannier
---

Sometime last year I was considering the present state of asset processing in
Ruby. The Rails *asset pipeline* &#8212; the [Sprockets][sprockets] library plus
some Rails-specific coupling &#8212; was a source of frustration for friends and
colleagues. In a moment of folly I decided to write my own Ruby asset processing
tool. I hoped that doing so would at least help me to understand the space a
little better. The result is [Pannier][pannier].

Pannier does the minimum amount of work required
to process assets and nothing else. Got some Sass files to turn into
plain old CSS? Want to compile CoffeeScript to JavaScript and then wrap each
file in an AMD module? Go right ahead. It's really more of an anti-framework
than a framework. All the hard work will be done by whichever preprocessors
you choose to use. Pannier just connects the dots.

The anti-feature I like the most is that there is absolutely no enforced plugin
ecosystem. No sad list of sub-libraries to browse. No scattergun, half-baked
package system. One of my favourite concepts from the Ruby world is that any
*callable* Ruby object (block, proc, lambda, object reponding to `#call`) can
be a Rack application. The same applies to [asset modifiers in Pannier][mod].

Pannier can be mounted within any Rack application, in which case Rack is used
to serve the assets and some basic helpers are provided for generating `<link>`
and `<script>` tags. It can also be used outside of web applications entirely,
in the same way you might use a `Makefile`. I use it in this way on a number of
my own static sites.

Below is a demonstration of basic Pannier usage. For further details, you can
check out the [project on GitHub][readme] or read the [documentation][features].

<iframe class="showterm" src="https://showterm.herokuapp.com/d83aa12e9f5eade929b71" height="430"></iframe>

[sprockets]: https://github.com/sstephenson/sprockets
[pannier]: https://github.com/joecorcoran/pannier
[mod]: https://www.relishapp.com/joecorcoran/pannier/docs/asset-modification
[readme]: https://github.com/joecorcoran/pannier#readme
[features]: https://www.relishapp.com/joecorcoran/pannier/docs
