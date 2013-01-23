---
layout: default
title: "Using Judge with SimpleForm"
tags:
  - judge
  - ruby
  - formbuilder
  - simpleform
---

<p>Following on from my <a href="/2012/03/01/using-judge-with-formtastic">previous post about Formtastic</a>, there&#8217;s now a <a href="http://github.com/joecorcoran/judge">Judge</a> extension gem for <a href="http://github.com/plataformatec/simple_form">SimpleForm</a> too.</p>

<!--more-->


<p>It&#8217;s an almost identical affair.</p>

<h2>Install</h2>

{% highlight ruby %}
gem "judge-simple_form", "~> 0.1", :require => "judge/simple_form"
{% endhighlight %}

<p><a href="/2012/03/01/using-judge-with-formtastic">Read here</a> why the require option is necessary.</p>

<p><em>Update: <a href="https://rubygems.org/gems/bundler">Bundler 1.1</a> was released, so the require option is no longer necessary.</em></p>

{% highlight ruby %}
gem "judge-simple_form", "~> 0.1"
{% endhighlight %}

<h2>Usage</h2>

<p>Add <code>:validate => true</code> to the inputs you want to validate on the front-end.</p>

{% highlight ruby %}
<%= simple_form_for(@user) do |f| %>
  <%= f.input :name, :validate => true %>
<% end %>
{% endhighlight %}


<h2>Feedback</h2>

<p>If you&#8217;re a regular SimpleForm user and you have any ideas about how to improve on this, I&#8217;d love to hear from you.</p>