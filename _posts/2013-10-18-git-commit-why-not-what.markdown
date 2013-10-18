---
layout: default
title: "Commit messages are for the why and not the what"
tags:
  - git
  - habits
---

I have a confession to make. Most of the commit messages I've written in my
time as a Git user have been useless. Here's an example.

```
commit 3420df0c35971219d9006870200a05c53974606f
Author: Joe Corcoran <joecorcoran@gmail.com>
Date:   Sat Mar 31 10:13:28 2012 +0100

    use _.has in place of hasOwnProperty
```

Here's part of the diff for that commit.

```diff
diff --git a/lib/generators/judge/templates/judge.js b/lib/generators/judge/templates/judge.js
index 8c3c7c8..5ca0939 100644
--- a/lib/generators/judge/templates/judge.js
+++ b/lib/generators/judge/templates/judge.js
@@ -240,7 +238,7 @@ judge.store = (function() {
     // the given key.
     get: function(key) {
       if (_(key).isUndefined()) { return store; }
-      return store.hasOwnProperty(key) ? store[key] : null;
+      return _(store).has(key) ? store[key] : null;
     },
 
```

I switched from using the native JavaScript `hasOwnProperty` function to
the `has` function from Underscore.js. But why did I make this choice? A year
or two down the line, the commit message tells me nothing and I have to
seek out [the relevant part of the library documentation](http://underscorejs.org/#has)
to figure it out.

Describing *what* you did in a commit message is redundant, unless what you did
was complex enough to require a summary. It's much better to describe *why*
you did it and let the diff speak for itself.

A quick browse through some popular open source projects tells me
I'm not alone in this habit. We need to be kinder to our colleagues and
future selves. One way to start is to quit using `git commit -m`.
