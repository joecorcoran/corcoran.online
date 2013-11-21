---
layout: default
title: "Exploring Data, Context and Interaction through prototypes with Io"
comments: true
tags:
  - dci
  - io
  - prototypes
  - roles
  - inheritance
---

[Data, Context and Interaction][dci] is a programming concept that was once
picking up steam in the Ruby world. The general idea is to separate data objects
from any code specific to the context in which the data will be used. Objects
within a given context interact through "roles", which are stateless
representations of a set of responsibilities. *True DCI*, for the dogmatically
inclined, has further caveats. The [Wikipedia article on DCI][dciwiki] gives a
decent enough summary.

It has since been found that the most common way of implementing DCI in Ruby,
through mixing a module into the metaclass of an object, has
[terrible performance implications][arcieri]. An alternative is to
[use delegation][light], although in my experience delegation can lead to
[confusion over object identity][schiz].

The 1991 paper
[Organizing Programs Without Classes <span class="muted">(PDF)</span>][opwc]
makes a compelling case for the power of prototypal inheritance. It is
contended that a combination of trait objects and prototype objects allows for
code reuse and object composition in a more flexible way than class inheritance.

One of the proposed benefits of traits and prototypes is the ability to
change the "behaviour mode" of any data type instance at runtime through dynamic
inheritance. Figure 5 in the paper demonstrates quite neatly the authors'
investigation into dynamic inheritance with [Self][self].

Which brings us back to the idea of roles. Roles in the DCI sense are easily
represented as traits objects; containers for related functionality that is
injected into a data object in a specific context. A prototypal language
where dynamic inheritance is encouraged and comes with no performance penalty
handles this job well.

[Io][io] offers a flavour of prototypal programming inspired by Self
and others. Here's a run-through of a common DCI example &#8212; the
bank transfer &#8212; using Io.

An `Account` object, cloned from the basic `Object`, forms the basis of a bank
account. Any clones will be initialised with an arbitrary balance.

```io
Account := Object clone do(
  init := method(self balance := 100)
)
```

Here's a traits object that handles deposits.

```io
DepositingAccount := Object clone do(
  deposit := method(amount, balance = balance + amount)
)
```

A data object is cloned from `Account` and the traits object `DepositingAccount`
is injected into it.

```io
account ::= Account clone
account appendProto(DepositingAccount)
```

Inheritance is most often achieved through cloning objects but through direct
manipulation of the prototype list, objects can inherit from multiple others.

```io
account protos
  #==> list(Account_0x7fae4acaa610, DepositingAccount_0x7fae4aca0af0)
```

The data object can carry out its role&hellip;

```io
account deposit(10)
account balance
  #==> 110
```

&hellip;and the depositing capability can be removed afterwards.

```io
account removeProto(DepositingAccount)
```

With a traits object that adds withdrawal behaviour, it's easy to write the
context for a simplified bank transfer. In this case it's just a `transfer`
method in place of whatever controller or service would assemble the objects
in the real world.

```io
WithdrawingAccount := Object clone do(
  canWithdraw := method(amount, balance >= amount)
  withdraw := method(amount, balance = balance - amount)
)
```

```io
transfer := method(amount, from, to,
  from appendProto(WithdrawingAccount)
  to appendProto(DepositingAccount)

  if(from canWithdraw(amount)) then(
    from withdraw(amount)
    to deposit(amount)
  ) else(
    message := "Cannot transfer #{amount}, balance is #{from balance}"
    Exception raise(message interpolate)
  )

  from removeProto(WithdrawingAccount)
  to removeProto(DepositingAccount)

  list(from, to)
)
```

Of course it's easy to tout the benefits of a hobbyist language and we need to
work with the languages we have in production, but ever since investigating
this subject I find myself wishing that the languages I work with every day
could offer dynamic multiple inheritance like Io.

Would we still be fastidiously moving presentational methods into decorator
objects if Ruby had usable instance composition? Would we still have
hundreds of attempts to wedge classes into JavaScript if its own prototype
system was more flexible?

*The code from this post (with a bit of extra namespacing) is
[available on GitHub][code]. Credit to Fogus for
[recommending Organizing Programs Without Classes][papers]*.

[opwc]: http://cs.au.dk/~hosc/local/LaSC-4-3-pp223-242.pdf
[self]: http://selflanguage.org/
[dci]: http://www.artima.com/articles/dci_vision.html
[dciwiki]: http://en.wikipedia.org/wiki/Data,_context_and_interaction#Description
[arcieri]: http://tonyarcieri.com/dci-in-ruby-is-completely-broken
[light]: http://evan.tiggerpalace.com/articles/2011/11/24/dci-that-respects-the-method-cache/
[schiz]: http://en.wikipedia.org/wiki/Schizophrenia_(object-oriented_programming)
[io]: http://iolanguage.org/
[code]: https://github.com/joecorcoran/dci-io
[papers]: http://blog.fogus.me/2011/09/08/10-technical-papers-every-programmer-should-read-at-least-twice/
