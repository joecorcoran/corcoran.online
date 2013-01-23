---
layout: default
title: "An update on Judge"
tags:
  - judge
  - ruby
  - javascript
  - activerecord
  - i18n
  - rails
  - validation
---

<p>I&#8217;ve just released <a href="https://rubygems.org/gems/judge/versions/1.5.0">Judge 1.5.0</a> and since it&#8217;s been a while since the last update, I thought I&#8217;d run through some of the improvements that have been made since version 1.0.0 and also introduce some ideas for future improvements.</p>

{% highlight ruby %}
gem "judge", "~> 1.5.0"
{% endhighlight %}

<!--more-->


<h2>Callbacks</h2>

<p>The various <code>validate()</code> methods now accept callback functions. Yep, real modern. The cool thing about this is that we can handle what happens after validation a little more elegantly. Behold!</p>

<p><code>watcher.validate([callback])</code></p>

{% highlight javascript %}
var watcher = new judge.Watcher(document.getElementById('foo'));
watcher.validate(function(valid, messages, element) {
  element.style.background = valid ? 'green' : 'red';
});
{% endhighlight %}


<p><code>judge.validate(elements, [callback])</code></p>

{% highlight javascript %}
// callback is executed once for each input
judge.validate(document.getElementsByTagName('input'), function(valid, messages, element) {
  element.style.background = valid ? 'green' : 'red';
});
{% endhighlight %}


<p><code>judge.store.validate(key, [callback])</code></p>

{% highlight javascript %}
judge.store.save('foo', document.getElementById('foo'));
// callback is executed once for each element stored 
// against key 'foo' (in this case just once)
judge.store.validate('foo', function(valid, messages, element) {
  element.style.background = valid ? 'green' : 'red';
});
{% endhighlight %}

<h2>I18n</h2>

<p>Internationalized error messages are sweet.  Remember when Rails didn&#8217;t do this?  Oh man. Bad times. They&#8217;re still a bit confusing though. There are a lot of bad custom validator examples sitting around on the web, just waiting to be copied and pasted into some poor, unsuspecting app. Don&#8217;t do this:</p>

{% highlight ruby %}
class FooValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value != "foo"
      record.errors[attribute] << "ain't foo"
    end
  end
end
{% endhighlight %}

<p><a href="http://en.wikipedia.org/wiki/Magic_number_(programming)">That rogue error message is doing nobody any favours</a>. The errors object has an <code>add</code> method which will handle i18n translation lookup for you:</p>

{% highlight ruby %}
class FooValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value != "foo"
      record.errors.add(attribute, :not_foo)
    end
  end
end
{% endhighlight %}

<p><a href="http://guides.rubyonrails.org/i18n.html#translations-for-active-record-models">You can read about how the error message is looked up over on rubyonrails.org</a>.</p>

<p>Since Judge is all about porting stuff from server- to client-side for great DRY justice, you can now use <code>declare_messages</code> in your custom <code>EachValidator</code> to specify which messages will be made available to your validation methods on the client-side:</p>

{% highlight ruby %}
class FooValidator < ActiveModel::EachValidator
  declare_messages :not_foo

  def validate_each(record, attribute, value)
    if value != "foo"
      record.errors.add(attribute, :not_foo)
    end
  end
end
{% endhighlight %}

<p>This means that we can access our translated message like this:</p>

{% highlight javascript %}
judge.customValidators.foo = function(valid, messages, element) {
  console.log(messages.not_foo);
};
{% endhighlight %}

<h2>Documentation</h2>

<p>The <a href="http://judge.joecorcoran.co.uk">Judge docs</a> have been spruced up a little too. Please do let me know if anything is unclear.</p>

<h2>The future</h2>

<p>I have a few things that I&#8217;m planning on adding to Judge in the very near future.</p>

<h3>Uniqueness validation</h3>

<p>This isn&#8217;t currently possible with Judge but given the <a href="http://railscasts.com/episodes/277-mountable-engines?view=asciicast">updates to Engines in Rails >= 3.1</a>, I&#8217;m excited about tackling this issue in a clean, unobtrusive way. Watch this space.</p>

<h3>Backbone.Model validation</h3>

<p><a href="http://backbonejs.org/">Backbone.js</a> models have a <a href="http://backbonejs.org/#Model-validate">validate method</a> which, with a little extra work, I think could work really nicely with Judge. I&#8217;m not settled on how to implement this but I have some vague ideas. Suggestions welcome as always.</p>