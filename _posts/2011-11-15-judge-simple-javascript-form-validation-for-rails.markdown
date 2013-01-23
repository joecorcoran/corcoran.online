---
layout: default
title: "Judge: Simple JavaScript form validation for Rails"
comments: true
tags:
  - judge
  - javascript
  - ruby
  - rails
  - activerecord
  - validation
published: true
---

Since version 1.0 has just been released and I've settled on what I hope is a friendly interface, I thought it was probably time I wrote a bit about [Judge][j_rg], my client side form validation gem for Rails 3.

<!--more-->

## Context

There are some other gems out there that attempt to solve this problem, so it would be remiss of me not to mention them. [Client Side Validations][csv] is feature-rich and does a lot of work for you.  There's also [LiveValidation][lv], which has been around for a long time and might be a good choice for people with legacy Rails apps that need Prototype.

I wanted a solution that was as small as possible. This is a simple job &#8211; no need for middleware, no need for extensions to core Ruby classes.  I also wanted it to be as flexible as possible &#8211; no assumptions should be made about form markup, styles, classes and so on. I started hacking away, using the jQuery plugin pattern as a starting point for the client side code. It soon became clear that jQuery had to go. Writing Judge as a jQuery plugin was a mistake &#8211; the code I wrote ended up tightly coupled to specific event bindings, specific DOM elements etc. That kind of stuff should really be left for the user to decide.

## Examples

### Setup

Add validation to an attribute in your model.

{% highlight ruby %}
class Thing < ActiveRecord::Base
  validates :name, :presence => true
end
{% endhighlight %}

Use the <code>Judge::FormBuilder</code> in your view. Add <code>:validate => true</code> to the options hash of any form element that you wish to validate on the client side.

{% highlight ruby %}
<%= form_for(@thing, :builder => Judge::FormBuilder) do |f| %>
  <%= f.text_field :name, :validate => true %>
<% end %>
{% endhighlight %}

### Quick validation

The <code>judge</code> object has a static <code>validate</code> method for immediate validation:

{% highlight javascript %}
judge.validate(document.getElementById('thing_name'));
  // => { valid: false, element: HTMLInputElement..., messages: { blank: "Can't be blank" } }
{% endhighlight %}

The same method used within a <code>keyup</code> event handler (requires jQuery):

{% highlight javascript %}
$('input#thing_name').keyup(function() {
  var input = this;
  console.log(judge.validate(input));
});
{% endhighlight %}

Note that we are not passing a jQuery object into the <code>validate</code> method here, but the DOM element itself. The [jQuery **get** method](http://api.jquery.com/get/) will often be of use when validating elements that have been wrapped by jQuery.

### Validation with watchers

Most of the features of Judge are based around watchers &#8211; JavaScript objects that hold information about the form elements to which they point.

{% highlight javascript %}
// instantiate watcher
var nameInput   = document.getElementById('thing_name'),
    nameWatcher = new judge.Watcher(nameInput);

// some time later:
nameWatcher.validate();
  // => { valid: false, element: HTMLInputElement..., messages: { blank: "Can't be blank" } }
{% endhighlight %}

### Validating stored elements

Most of the time, validating immediately on <code>keyup</code> or <code>change</code> will be enough to achieve the intended user experience.  But there are times when storing a reference to a form element, or a group of form elements, can be useful. For example, validating elements conditionally based on user triggers. This is where the Judge <code>store</code> comes in.

{% highlight javascript %}
// store some text input elements
var textInputs = document.querySelectorAll('form.thing-form input[type=text]');
judge.store.save('foo', textInputs);

// retrieve watchers for your stored elements
judge.store.get('foo');
  // => [ { element: HTMLInputElement... }, { element: HTMLInputElement... }, ... ]

// retrieve your stored elements
judge.store.getDOM('foo');
  // => [ HTMLInputElement, HTMLInputElement, ... ]

// validate all elements stored against key 'foo'
judge.store.validate('foo');
  // => [ { valid: true, ... }, { valid: false, ... }, ... ]
{% endhighlight %}

## Use it

Go ahead! Feedback is all kinds of welcome.

{% highlight ruby %}
gem "judge", "~> 1.0.0"
{% endhighlight %}

* [Judge on RubyGems.org][j_rg] 
* [Judge documentation](http://joecorcoran.github.com/judge) 
* [Judge source on GitHub](http://github.com/joecorcoran/judge) 

[j_rg]: https://rubygems.org/gems/judge
[csv]: https://github.com/bcardarella/client_side_validations "Client Side Validations gem by Brian Cardarella"
[lv]: https://github.com/alechill/livevalidation "LiveValidation by Alec Hill"