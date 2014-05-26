---
layout: default
title: Moving past the Rails asset pipeline
tags:
  - rails
  - ruby
  - asset pipeline
  - pannier
---

The asset pipeline has some good ideas buried deep inside, but like various
other parts of Rails it is over-reaching and inflexible. Working with it has
been an extremely frustrating experience for many of us.

I'm sure a lot of people reading this will know exactly how I feel. In case you
don't, I will list some of my main issues with the asset pipeline below.

That said, it is hard to fault the effort of the developers responsible for its
creation and maintenance &#8212; they have tried hard to to make front-end web
development with Rails better and their work is appreciated &#8212; but I'm
confident that the result has hindered more people than it has helped.

*tl;dr &#8212; The asset pipeline results in increased cognitive load for
developers and encourages poor software development practices. You should use
something simpler.*

## Directive spaghetti

Sprockets directives are the magic comments that live inside your asset files,
referencing other assets.

```javascript
//= require admin
```

Users can require a single file, a whole directory recursively, and so
on. At first it might seem like a good idea to explicitly state dependencies in
this way. Sprockets will order your assets correctly on the page so that your
JavaScript errors are at least never of the load order-dependent kind.
(You will always have JavaScript errors. Until you die.)

This is fine, until you need to use an asset outside of the
Rails environment, for example in a JavaScript unit test. Sprockets directives
actively fight against a clean separation of concerns, driving tight coupling
of front-end code to Ruby infrastructure.

## Logical complement

Sprockets allows users to register numerous directories that contain assets to
*the load path*. The load path is sort of like the Unix environment variable
`PATH` &#8212; it's a list of directories.

When actually using assets &#8212; including them in a template, requiring them
in a manifest &#8212; users are encouraged to use a *logical path*. The logical
path of an asset is the path relative to whichever directory from the load path
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
sequence, from right to left. So a file named `great_code.js.coffee.erb` would be
evaluated as ERB first, then as CoffeeScript, then finally delivered as
JavaScript.

This can seem like a good idea, especially if you have an environment variable
like an API key that you want to take from Ruby and inject into JavaScript. In
practice it's another feature that helps more than it hurts.

Not only does it encourage tight coupling of otherwise unrelated areas of your
codebase, but it renders the asset file totally useless without the presence of
both the Rails environment and the asset pipeline.

## Frustration over configuration

TODO: Bit about being unable to add your own uglifier, no way of switching off file
name hashing, Rails config options etc.

## Rip it up and start again

If you're lucky enough to be starting with a brand new application, you can use
the <nobr>`--skip-sprockets`</nobr> option when you create the app.

```
$ rails new appname --skip-sprockets
```

There may still be some lines in your Gemfile to remove, but for the most part
this will do the trick.

If your application already exists, you will have some horrible untangling to
do. Remove the various extension gems, remove the Sprockets directives from your
assets, remove the config cruft, the Railtie, and so on. Your best bet is to
check the [official Rails guide][ap].

### Pannier

TODO

### wake

TODO

### Broccoli

TODO

More?



[ap]: http://guides.rubyonrails.org/asset_pipeline.html
