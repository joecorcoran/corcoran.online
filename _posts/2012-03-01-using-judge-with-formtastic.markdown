---
layout: default
title: "Using Judge with Formtastic"
tags:
  - judge
  - ruby
  - formbuilder
  - formtastic
---

<p>There&#8217;s now an extension gem to help you use <a href="http://github.com/joecorcoran/judge">Judge</a> for client-side validation from within your <a href="https://rubygems.org/gems/formtastic">Formtastic</a> forms.</p>

<!--more-->


<p>One of the <em>modi operandi</em> of Judge is to use the power of the <a href="http://api.rubyonrails.org/classes/ActionView/Helpers/FormBuilder.html">FormBuilder</a> to great effect.  Coding forms is one of the great pains of front-end web development and I feel pretty confident in saying that nobody ever gets it completely right. Formtastic can help take some of the repetition and view clutter out of the process.</p>

<p>Adding Judge support to Formtastic turned out to be pretty easy. In fact, most of my time was spent marvelling at the Formtastic test suite, which is end-of-level bonkers.</p>

<h2>Install</h2>

{% highlight ruby %}
gem "judge-formtastic", "~> 0.1", :require => "judge/formtastic"
{% endhighlight %}


<p>Sorry about the require option. The most recently released version of Bundler (<a href="https://rubygems.org/gems/bundler/versions/1.0.22">1.0.22 at time of writing</a>) doesn't correctly translate hyphen-delimited gem names into file paths before autorequiring. There's a <a href="https://github.com/carlhuda/bundler/issues/1205">fix for this</a> already but I don't know when Bundler 1.1 will be released.</p>

<p><em>Update: <a href="https://rubygems.org/gems/bundler">Bundler 1.1</a> was released, so the require option is no longer necessary.</em></p>

{% highlight ruby %}
gem "judge-formtastic", "~> 0.1"
{% endhighlight %}