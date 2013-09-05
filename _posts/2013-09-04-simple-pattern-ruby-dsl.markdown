---
layout: default
title: "A simple pattern for cleaning up your Ruby DSL"
comments: true
tags:
  - ruby
  - dsl
  - "delegator pattern"
  - "builder pattern"
  - cucumber
---

I've recently been working on a project that involved building a Ruby [DSL][dsl]. As an experiment, I decided to use only [Cucumber][cuc] to describe the behaviour of the code and leave the unit tests until later. I quite enjoyed this way of
working at first, as it forced me to maintain focus on the end user experience and worry less about describing the stuff underneath.

A negative side effect of this approach was that without unit tests keeping me in check, things got a little messy. In lieu of a separate class responsible for DSL behaviour, DSL methods ended up sitting alongside non-DSL methods without much indication of their intended use to users or future maintainers. Worse, sometimes the DSL methods would be the only entry point to a particular feature.

The following code demonstrates the problem on a small scale. I'll leave it up to you to imagine the same situation with four or five times the number of methods.

The main class reponsible for the DSL would look something like this:

```ruby
class Config
  attr_reader :file_paths

  def initialize(&block)
    @file_paths = []
    self.instance_eval(&block) if block_given?
  end

  # DSL method
  def files(*paths)
    @file_paths += paths.map { |p| File.expand_path(p) }
  end

  # non-DSL method
  def save!
    @file_paths.each do |path|
      File.new(path, 'w')
    end
  end
end
```

Intended use follows the [builder pattern][bui], with some of that `instance_eval` magic that you either love or hate:

```ruby
Config.new do
  files 'foo.bar', 'baz/qux.quux'
end
```

Fine. But we have a problem when a user would rather not use the code in this manner. Ideally, a block-based DSL like this would be an optional nicety and not the sole way of getting things done.

This problem becomes even more obvious when writing unit tests &#8212; we are users of our own code, after all &#8212; and it's necessary to keep on initializing new objects in various states of configuration by using the DSL block. Not to mention that use of mock objects is made practically impossible in this case thanks to the altered scope from `instance_eval`.

To fix this, I settled on the following solution.

```ruby
require 'delegate'

class Config
  def self.build(&block)
    config = new
    delegator = ConfigDelegator.new(config)
    delegator.instance_eval(&block)
    config
  end

  attr_reader :file_paths

  def initialize
    @file_paths = []
  end

  def add_paths(*paths)
    @file_paths += paths.map { |p| File.expand_path(p) }
  end

  def save!
    @file_paths.each do |path|
      File.new(path, 'w')
    end
  end

  class ConfigDelegator < SimpleDelegator
    def files(*paths)
      add_paths(*paths)
    end
  end
end
```

```ruby
Config.build do
  files 'foo.bar', 'baz/qux.quux'
end
```

I'm sure the idea is nothing new, but it has a number of benefits.

By using a [delegator object][del] we can isolate the DSL methods, making them only available inside the `build` block. The footprint of the DSL is now clearer, since DSL methods are defined on the delegator class.

Ruby DSL behavior frequently deviates considerably from the concept of simply [constructing objects and passing messages between them][kay]. In the interest of providing a simple user experience, we are tempted to write complex behaviour into a DSL method. Separating our concerns presents the opportunity to keep a watchful eye on this complexity as it inevitably grows.

Cleaning up like this also allows for better unit testing. In the example above, the action of adding paths can be isolated without having to touch the DSL at all. What's more, the user can ignore the DSL completely if they wish.

```ruby
config = Config.new
config.add_paths('foo.bar', 'baz/qux.quux')
config.save!
```

A combination of unit tests for the non-DSL methods and acceptance tests for the DSL methods seems like a good fit to me.

It turns out this behavior is easy to extract into a module for reuse too.

```ruby
require 'delegate'

module DSL
  def build(*args, &block)
    base = self.new(*args)
    delegator_klass = self.const_get('DSLDelegator')
    delegator = delegator_klass.new(base)
    delegator.instance_eval(&block)
    base
  end

  def dsl(&block)
    delegator_klass = Class.new(SimpleDelegator, &block)
    self.const_set('DSLDelegator', delegator_klass)
  end
end
```

```ruby
class Config
  extend DSL
  # ...
  dsl do
    # DSL methods defined here
  end
end
```

The delegator class is created when the `dsl` class method is used. The class is assigned to the constant `DSLDelegator` and namespaced under the extending class.

My favourite thing about this approach is that it brings added clarity of thought. Simply having a clear place for the DSL methods to live and having them on hand in the same file as the class to which they relate has made iterative development on the project a little quicker and lot more enjoyable.

[dsl]: http://en.wikipedia.org/wiki/Domain-specific_language
[bui]: http://en.wikipedia.org/wiki/Builder_pattern
[cuc]: http://cukes.info
[del]: http://www.ruby-doc.org/stdlib-2.0.0/libdoc/delegate/rdoc/Delegator.html
[kay]: http://www.purl.org/stefan_ram/pub/doc_kay_oop_en
