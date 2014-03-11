---
layout: default
title: Howls of asset pipeline
hidden: true
---

<blockquote class="twitter-tweet" lang="en"><p>I really believe asset pipeline is the worst thing that&#39;s ever happened to Rails ecosystem in terms of the pain it causes to operations.</p>&mdash; Oleksiy Kovyrin (@kovyrin) <a href="https://twitter.com/kovyrin/statuses/443157812135620608">March 10, 2014</a></blockquote>

<blockquote class="twitter-tweet" lang="en"><p>There&#39;s lots of sturm und drang around Sprockets/Rails asset pipeline. What are good, mature alternatives for Ruby?</p>&mdash; Mark Wunsch (@markwunsch) <a href="https://twitter.com/markwunsch/statuses/443419196316471296">March 11, 2014</a></blockquote>

## The pain of it all

* Magically serving local assets
  * Not a real benefit because it's not real
  * Just serve them, processed, from environment-specific dir
* Help required
  * Coupling files to each other
  * Adding yet another dependency
  * Problem that nobody has
* The Deployment Dilemma
  * Do you vendor processed assets or process on server?
* Rails coupling
  * The opression of convention
