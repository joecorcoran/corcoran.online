---
layout: default
title: Moving past the Rails asset pipeline
tags:
  - rails
  - ruby
  - asset pipeline
  - pannier
---

The asset pipeline has some good ideas buried deep inside it, but like various
other parts of Rails it is inflexible and has too many responsibilities.
Working with it has been an unrewarding experience for many people.

It is hard to fault the effort of the developers responsible for its
creation and maintenance &#8212; they have tried hard to to make front-end web
development with Rails better and their work is appreciated &#8212; but I'm
confident that the result has hindered more people than it has helped.

I'm sure a lot of people reading this will know exactly how I feel. In case you
don't, some of my issues with the asset pipeline are listed below.

*tl;dr &#8212; The asset pipeline results in increased cognitive load for
developers and encourages poor software development practices that lead to
tightly-coupled, untestable front-end code. You should instead use tools with
more clearly-defined interfaces that are smaller in scope.*

## Pragma chamber

Sprockets directives are the magic comments that live inside your asset files,
referencing other assets.

```javascript
//= require admin
```

Users can require a single file, a whole directory recursively, and so
on. At first it might seem like a good idea to explicitly state dependencies in
this way. Sprockets will order your assets correctly on the page so that your
JavaScript errors are at least never of the load order-dependent kind.

This is fine, until you need to use an asset outside of the
Rails environment, for example in a JavaScript unit test. Depending on your test
environment you can at best expect a complete loss of your dependency graph and
at worst an explosion at parser level.

Sprockets directives actively fight against a clean separation of concerns,
driving tight coupling of front-end code to the Rails environment.

## Logical complement

Sprockets allows users to register numerous directories that contain assets to
*the load path*. The load path is sort of like the Unix environment variable
`PATH` &#8212; it's a list of directories.

When actually using assets &#8212; including them in a template, requiring them
in a manifest &#8212; users are encouraged to use a *logical path*. The logical
path is the path to an asset, relative to whichever directory from the load path
contains it. A helper method named `asset_path` will take your logical
path and look through the load path, trying to resolve the full path to the
file.

```erb
<%= asset_path('widgets/dingus') %>
```

If I am developing an application, I already know which directories contain
which assets. I can reference them by their full path, their path relative to
the `Rails.root` or in any number of other ways. Pretending to not know the full
path to a file and then using a helper method to search for it is not valuable
at all.

## Engines all the way down

When an asset file has multiple extensions that Sprockets can recognise,
that file will be run through a preprocessing engine for each extension in
sequence, from right to left. So a file named `great_code.js.coffee.erb` would
be evaluated as ERB first, then as CoffeeScript, then finally delivered as
JavaScript.

This can seem like a good idea, especially if you have an environment variable
like an API key that you want to take from Ruby and inject into JavaScript. In
practice it's another feature that helps more than it hurts.

Not only does it encourage tight coupling of otherwise unrelated areas of your
codebase, but it leaves you with an asset file with no identity &#8212; not
Ruby, not CoffeeScript, not JavaScript &#8212; which is totally useless without
the presence of both the Rails environment and the asset pipeline.

## Frustration over configuration

"Convention over configuration" &#8212; the release of software
with default behaviour that covers the common case without further setup &#8212;
is often an accompanied by the reassurance that deviation from the common case
is possible too, with a bit of extra work.

The problem with the asset pipeline is that it offers dozens of configuration
options whilst still being weirdly inflexible.

As of writing there is no way to process assets without adding a digest suffix
to their file names. The assumption is that any file that doesn't need to be
cache-busted can just be added to the `public` directory, but it's actually
another blow for front-end testing as it prevents the use of individual
preprocessed assets outside of the Rails environment.

## Keep on moving

With these issues in mind, I believe that any modern Rails application would be
better built and maintained without the asset pipeline.

If you're lucky enough to be starting with a brand new application, you can use
the <nobr>`--skip-sprockets`</nobr> option when you create the app.

```
$ rails new appname --skip-sprockets
```

There may still be some lines in your Gemfile to remove, but for the most part
this will do the trick.

If your application already exists, you will likely have some untangling to
do. Remove the various extension gems, remove the Sprockets directives from your
assets, remove the config cruft, the Railtie, and so on. Check the
[official Rails guide][ap] for tips on disabling the asset pipeline in all
environments and good luck.

Despite the issues above, I am still of the opinion that a development workflow
which includes asset preprocessing is a great thing. There are a number of tools
available that will run your assets through the preprocessors of your choice
and move them into a different directory, which is really all you need. Four
very different options are listed below.

### RequireJS

Regarding JavaScript, if you like the idea of using the AMD module pattern then
[RequireJS][rjs] is your friend. You can use it to load JavaScript modules
asynchronously, or use the related `r.js` command to concatenate and uglify.

In my experience the configuration options are sane and you have full access
to the configuration options of the underlying preprocessor, UglifyJS.

### Pannier

*Full disclosure: I am the author of this project.*

[Pannier][p] is a Ruby asset processing tool. You can use it as a command line tool
or mount it inside a Rack application with a single line of code in
`config.ru`.

It comes with no preprocessors, but they are easy to include
through a minimal DSL. You can [read more about it here][pn]. Pannier is
intended to be as unopinionated as possible. If you're a control freak like me,
you will consider this a feature.

### wake

Short for "web make", [wake][wake] is a tool for optimizing CSS and JavaScript
and nothing more. All configuration happens in a `package.json` file at the
root of your project.

It has most of the preprocessing capability of the asset pipeline but remains
entirely decoupled from your application.

### Broccoli

[Broccoli][br] is an asset processing tool that focuses on compilation speed.
The [post from the author][jl] about the thinking behind the project is an
interesting read.

At first glance Broccoli seems like it may be heading towards mainly focussing
on Ember applications, but the idea of leaning on the file system is strong and
I'm keen to try it out.


[ap]: http://guides.rubyonrails.org/asset_pipeline.html
[rjs]: http://requirejs.org/
[p]: https://github.com/joecorcoran/pannier
[pn]: /2014/03/11/ruby-asset-processing-with-pannier/
[wake]: https://github.com/jcoglan/wake
[br]: https://github.com/broccolijs/broccoli
[jl]: http://www.solitr.com/blog/2014/02/broccoli-first-release/
[gr]: http://gruntjs.com/
