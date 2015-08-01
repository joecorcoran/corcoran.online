---
layout: default
title: "Building a minimal JavaScript event system"
comments: true
tags:
  - javascript
  - events
  - tutorial
---

*This article assumes a basic knowledge of JavaScript and comfort running simple commands like `cd` at the command line. I hope the test examples in this article are straightforward, but if you're not familiar with writing tests first, or even testing your code at all, you might want to [read a little about it first](http://en.wikipedia.org/wiki/Test-driven_development). The general idea is that we make an assertion about how our code should behave in the form of a test. We then write some code, run the test and repeat this loop until the test passes.*

## Events

Events are integral to programming on the web. They allow us to declare an interest in a specific happening in our system (user input from the keyboard, for example) and respond to it. These kinds of interactions are *asynchronous*; we don't know when an event will happen, so we write code that can respond whenever it does.

Programming with events involves two parts. The first part is *listening*. We specify that we want to call a particular function when a named event happens. This is often referred to as *binding*; we *bind* that function to the event. The second part is *announcing*, meaning actually making the event happen. This is commonly referred to as *triggering* or *firing* an event.

You can find examples of this code pattern in [the DOM](https://developer.mozilla.org/en-US/docs/Web/API/Event) and in popular libraries like [jQuery](http://api.jquery.com/category/events/event-object/) and [Backbone.js](http://backbonejs.org/#Events).

## The task

We will create an object capable of announcing and listening for events and a function for mixing that capability into any other object. We're not talking about the DOM events that occur when a user clicks a link or focuses on an input but a separate, custom event system. We'll end up with something quite similar to [the `Events` object from Backbone.js](http://backbonejs.org/#Events) but with fewer features.

We'll use the JavaScript testing framework Jasmine to describe our event behaviour first. Then we'll write the code to match our description. [A template for this exercise is available on GitHub](http://github.com/joecorcoran/event-tutorial), to help you get started without setting up the test environment. If you're comfortable with [Git](http://git-scm.com/), it would be a good idea to fork this repo and `git clone` your forked copy. If not, don't worry, you can just [download the template (ZIP)](https://github.com/joecorcoran/event-tutorial/archive/master.zip). You will need to have [Node.js](http://nodejs.org/download/) installed to run the tests.

Let's start with an object that contains two functions, `on` and `trigger`. We have chosen these names by loose convention; we hope they will be recognised by programmers who have worked with events before.

We'll use the `on` function to instruct our object to listen for specific events. So `object.on('foo', callback)`, will mean *on hearing the `'foo'` event happen, call the `callback` function*.

We'll use the `trigger` function to make events happen. So `object.trigger('foo', data)` will mean *tell `object` that the `'foo'` event has happened and to pass `data` to the callback function*.


```javascript
// evented-spec.js
describe('Evented', function() {
  describe('Event', function() {
    var eventObj = Evented.Event;
    it('has on function', function() {
      expect(eventObj.on).toEqual(jasmine.any(Function));
    });
    it('has trigger function', function() {
      expect(eventObj.trigger).toEqual(jasmine.any(Function));
    });
  });
});
```

`jasmine.any` is a utility that lets us make assertions about an object's type. We're starting out by simply specifying that our object must have two properties named `on` and `trigger` and they both must hold functions.

Let's run the tests.

*Whenever you see a block of monospaced text that looks like the one below, it's the test output; the way in which Jasmine tells us whether our tests have passed or failed.*

```
FF

Failures:

  1) Evented Event has on function
   Message:
     Expected undefined to equal <jasmine.any(function Function() { [native code] })>.

Finished in 0.007 seconds
2 tests, 2 assertions, 2 failures
```

Okay, the tests fail as expected. We haven't written any code yet! We can fix that.

```javascript
// evented.js
var Evented = {
  Event: {
    on: function() {},
    trigger: function() {}
  }
};
```

```
..

Finished in 0.007 seconds
2 tests, 2 assertions, 0 failures
```

Okay, our tests pass! Now let's write some meaningful behaviour. We have an interesting situation here in that the two functions we need to write are useless without each other. Ideally we would test the behaviour of each function in isolation ([read more about why this is a good idea](http://alistapart.com/article/writing-testable-javascript)). However, in this case it isn't really helpful to describe the behaviour of one function without the other. At a minimum, we want to know that we can tell our object to listen for an event and then respond when that event is triggered. So let's think about what that would look like in code.

```javascript
// evented-spec.js
describe('Event', function() {
  // ...
  it('executes callback when event is triggered', function() {
    var callback = function() {};
    eventObj.on('foo', callback);
    eventObj.trigger('foo');
  });
});
```

We expect that when the `'foo'` event is triggered, our `callback` function should have been called. But how do we actually test this? JavaScript doesn't provide a way to check whether or not a function was called. To achieve this, we need a *spy*. A spy is an object that we can use in place of a function. We can then ask the spy questions like "were you called?", "how many times were you called?" and "when you were called, what arguments did you receive?". So let's update our spec.

```javascript
// evented-spec.js
describe('Event', function() {
  // ...
  it('executes callback when event is triggered', function() {
    var callback = jasmine.createSpy();
    eventObj.on('foo', callback);
    eventObj.trigger('foo');
    expect(callback).toHaveBeenCalled();
  });
});
```

```
..F

Failures:

  1) Evented Event executes callback with correct arguments when event is triggered
   Message:
     Expected spy unknown to have been called.

Finished in 0.009 seconds
3 tests, 3 assertions, 1 failure
```

Okay, we already knew that would fail. So now we can try our hands at the implementation. Firstly, the `on` function needs to store event names and their list of corresponding callback functions. JavaScript doesn't have [hashes (sometimes called dictionaries)](http://en.wikipedia.org/wiki/Hash_table) so, for better or worse, it's common to use objects for this purpose.

```javascript
// evented.js
var Evented = {
  Event: {
    on: function(event, callback) {
      this.events = {};
      this.events[event] = [];
      this.events[event].push(callback);
    },
    trigger: function() {}
  }
};
```

Not a terrible start, but one problem sticks out. We can only store one event-callback pair at a time, as each time we call `on` we will reset the `events` object. We need to test for the existence of the `events` property before we can confidently assign the empty object.

```javascript
if (!this.hasOwnProperty('events')) {
  this.events = {};
}
```

We have the same problem on the next line too. We're resetting `this.events[event]` to an empty array even if it already exists. So let's improve that.

```javascript
if (!this.hasOwnProperty('events')) {
  this.events = {};
}
if (!this.events.hasOwnProperty(event)) {
  this.events[event] = [];
}
```

These necessary checks are in place. There's nothing wrong with this code as it is, but we can make a further improvement using what is known as [short-circuit evaluation](http://en.wikipedia.org/wiki/Short-circuit_evaluation).

```javascript
this.hasOwnProperty('events') || (this.events = {});
this.events.hasOwnProperty(event) || (this.events[event] = []);
```

This takes advantage of the way in which the logical operator `||` works. Each expression is evaluated in turn from left to right. When one of the expressions is *[truthy](http://codepen.io/philipwalton/pen/nufrk)*, it is returned and the other expressions are not evaluated. So if `this.hasOwnProperty('events')` returns `true`, the assignment on the right of the `||` operator simply doesn't happen.

So let's recap. The `on` function is looking good now.

```javascript
// evented.js
var Evented = {
  Event: {
    on: function(event, callback) {
      this.hasOwnProperty('events') || (this.events = {});
      this.events.hasOwnProperty(event) || (this.events[event] = []);
      this.events[event].push(callback);
    },
    trigger: function() {}
  }
};
```

We can now implement `trigger` pretty easily.

```javascript
// evented.js
var Evented = {
  Event: {
    on: function(event, callback) {
      this.hasOwnProperty('events') || (this.events = {});
      this.events.hasOwnProperty(event) || (this.events[event] = []);
      this.events[event].push(callback);
    },
    trigger: function(event) {
      var callbacks = this.events[event];
      for(var i = 0, l = callbacks.length; i < l; i++) {
        callbacks[i]();
      }
    }
  }
};
```

```
...

Finished in 0.007 seconds
3 tests, 3 assertions, 0 failures
```

Hooray, our tests all pass! The next thing to consider is that we need to be able to pass an arbitrary number of further arguments to `trigger` and have them passed onto the stored callback functions. Let's update our test.

```javascript
// evented-spec.js
describe('Event', function() {
  // ...
  it('executes callback with correct arguments when event is triggered', function() {
    var callback = jasmine.createSpy('callback');
    eventObj.on('foo', callback);
    eventObj.trigger('foo', 1, 2);
    expect(callback).toHaveBeenCalledWith(1, 2);
  });
});
```

```
..F

Failures:

  1) Evented Event executes callback with correct arguments when event is triggered
   Message:
     Expected spy callback to have been called with [ 1, 2 ] but actual calls were [  ]

Finished in 0.012 seconds
```

We aren't passing the arguments on. So how can we access an arbitrary number of arguments? Usually when defining a function, we use named arguments as follows.

```javascript
var f = function(a) {
  return a;
};
f(1); // => 1
```

But if we don't know how many arguments will be given, we can access them through the `arguments` object.

```javascript
var f = function() {
  return arguments[1];
};
f(1, 2, 3, 4); // => 2
```

We'll need to grab all of the arguments passed to `trigger` apart from the first one, which is the string representing the name of the event. A list of items minus the first one is often referred to as the list's *tail*. A good way of getting the tail of an array is to use the `slice` function.

```javascript
var a = ['a', 'b', 'c'];
a.slice(1); // => ['b', 'c']
```

We pass the number `1` to `slice`, meaning *return all the items in the array, starting from index 1*. Since the indices of an array start at 0, this returns everything from the second item onwards. Sadly, even though the arguments object has many array-like properties, [it's not an array](https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Functions_and_function_scope/arguments). So we can't use `slice` in that way.

```javascript
var tail = function() {
  return arguments.slice(1);
};
tail('a', 'b', 'c'); // => TypeError: Object has no method 'slice'
```

Thankfully we can access the `slice` function in another, much uglier way. Here's how.

```javascript
var tail = function() {
  return Array.prototype.slice.call(arguments, 1);
};
tail('a', 'b', 'c'); // => ['b', 'c']
```

What?! Well, it's not quite as complicated as it looks. Let's work through it piece by piece.

`Array.prototype` is simply the object that holds all of the functions we are familiar with using on arrays, like `join`, `shift` and `slice`. If you're familiar with class-based programming languages, you can think of functions stored in the `prototype` object as roughly equivalent to [instance methods](http://en.wikipedia.org/wiki/Method_(computer_programming\)).

(The word `prototype` refers to the *prototypical inheritance* that JavaScript objects use. You can [read more on the JavaScript object model](https://developer.mozilla.org/en-US/docs/JavaScript/Guide/Details_of_the_Object_Model) if you're curious, but don't forget to come back!)

`Array.prototype.slice` is the `slice` function we are looking for. But it's a function that expects to be called in the context of its containing object, e.g. `foos.slice(1)`, so calling `Array.prototype.slice()` will never work, no matter what arguments we use.

`call` allows us to call a function and specify the context of that function dynamically. So in effect, what we are saying here is *take the `slice` function, but pretend it's being called on the `arguments` object, e.g. `arguments.slice(1)`*.

```javascript
// evented.js
var Evented = {
  Event: {
    // ...
    trigger: function(event) {
      var tail = Array.prototype.slice.call(arguments, 1),
          callbacks = this.events[event];
      for(var i = 0, l = callbacks.length; i < l; i++) {
        callbacks[i](tail);
      }
    }
  }
};
```

```
..F

Failures:

  1) Evented Event executes callback with correct arguments when event is triggered
   Message:
     Expected spy unknown to have been called with [ 1, 2 ] but actual calls were [ [ 1, 2 ] ]

Finished in 0.012 seconds
```

Our test is still failing, but we're getting closer. The problem here is subtle. We wanted to pass `1` and `2`, but we're actually passing the array that was returned from the `slice` function. To convert that array into function arguments, we can use `apply`.

```javascript
// evented.js
var Evented = {
  Event: {
    // ...
    trigger: function(event) {
      var tail = Array.prototype.slice.call(arguments, 1),
          callbacks = this.events[event];
      for(var i = 0, l = callbacks.length; i < l; i++) {
        callbacks[i].apply(this, tail);
      }
    }
  }
};
```

`apply` does a very similar job to `call`. They will both call a function in the context of our choosing, but whereas `call` will simply pass along its remaining arguments, `apply` will go one step further and convert an array into function arguments for us.

```
...

Finished in 0.008 seconds
3 tests, 3 assertions, 0 failures
```

Okay, great. Let's take a step back for a minute though, because we kind of glossed over something important there. When we used `call`, we stated that the `slice` function should be called in the *context* of the `arguments` object. So both of the following examples would be functionally equivalent, if the second one was actually allowed.

```javascript
Array.prototype.slice.call(arguments, 1);
arguments.slice(1);
```

But when we used `apply`, we simply passed `this` as the function context. The `this` keyword in JavaScript refers to the current execution context or *scope*. In our usage above, `this` refers to `Evented.Event`: the object that holds the `trigger` function. So any functions that are called when an event is triggered will have access to this object through `this`.

```javascript
eventObj.on('foo', function() {
  console.log(this);
});

eventObj.trigger('foo');
  // => logs the Evented.Event object
```

We know that we can use `apply` to dynamically alter `this`, so why don't we take full advantage of that and add this functionality to our event system? Let's specify the desired behaviour first and then write it.

```javascript
// evented-spec.js
describe('Event', function() {
  // ...
  it('executes callback in context of another object', function() {
      var obj = {};
      eventObj.on('bar', function() {
        expect(this).toBe(obj);
      }, obj);
      eventObj.trigger('bar');
    });
});
```

```
...F

Failures:

  1) Evented Event executes callback in context of another object
   Message:
     Expected { on: Function ... } to be { }.

Finished in 0.017 seconds
4 tests, 4 assertions, 1 failure
```

Notice that we want to pass a context object of our choice as the third argument to `on`. Now let's make that work. We'll keep track of things by storing the callback function and the context together in an array and store that array in `this.events` as before.

```javascript
var Evented = {
  Event: {
    on: function(event, callback, context) {
      this.hasOwnProperty('events') || (this.events = {});
      this.events.hasOwnProperty(event) || (this.events[event] = []);
      this.events[event].push([callback, context]);
    },
    // ...
  }
};
```

In `trigger`, we still call `apply` on the callback function, this time setting the stored object as the context.

```javascript
var Evented = {
  Event: {
    // ...
    trigger: function(event) {
      var tail = Array.prototype.slice.call(arguments, 1),
          callbacks = this.events[event];
      for(var i = 0, l = callbacks.length; i < l; i++) {
        var callback = callbacks[i][0],
            context = callbacks[i][1] === undefined ? this : callbacks[i][1];
        callback.apply(context, tail);
      }
    }
  }
};
```

Notice that if the third argument to `on` is not given, our stored context will be `undefined`. If this is the case we want to fallback to using `this` (the `Evented.Event` object) as the context. We've set this up using a [*conditional operation*](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Conditional_Operator). Let's add another slightly different test, to prove that our fallback works.

```javascript
// evented-spec.js
describe('Event', function() {
  // ...
  it('executes callback in context of containing object', function() {
    eventObj.on('baz', function() {
      expect(this).toBe(eventObj);
    });
    eventObj.trigger('baz');
  });
});
```

```
.....

Finished in 0.011 seconds
5 tests, 5 assertions, 0 failures
```

Great! So we have an object that's capable of both announcing and listening for events. It's even capable of changing the scope of `this` inside callback functions. But it's only one object. If we stopped here, we'd have to route all of the events in our program through it; that's a lot of responsibility for one little object. So we need a way of adding this object's functionality to any other object.

Other programming languages, such as Ruby or Python, allow us to define modules; containers for groups of methods and statements. We can use these modules to extend the functionality of other objects. Modules, used in this context, are often referred to as *mixins*. JavaScript provides no such thing, so let's write a function that can take our `Evented.Event` object and mix its properties into any other object. We'll call the function `extend`.

```javascript
// evented-spec.js
describe('Evented', function() {
  // ...
  describe('extend', function() {
    it('copies the properties of Event onto another object', function() {
      var newObj = {};
      Evented.extend(newObj);
      expect(newObj.on).toEqual(Evented.Event.on);
      expect(newObj.trigger).toEqual(Evented.Event.trigger);
    });
  });
});
```

```
.....F

Failures:

  1) Evented extend copies the properties of Event onto another object
   Message:
     TypeError: Object #<Object> has no method 'extend'

Finished in 0.012 seconds
6 tests, 6 assertions, 1 failure
```

We've asserted that after passing an object to `extend`, that object should then be the proud owner of two new functions, `on` and `trigger`. So we need to iterate through the properties of `Evented.Event` and copy each property in turn onto the other object.

```javascript
var Evented = {
  Event: {
    // ...
  },
  extend: function(other) {
    for (var property in this.Event) {
      other[property] = this.Event[property];
    }
  }
};
```

We've used a `for-in` loop, which allows us to iterate over the properties of an object. `for-in` loops iterate over all properties of an object, including those in the `prototype`, so there can sometimes be [unintended consequences](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/for...in#Example) when using this kind of loop. However, since we control the `Evented.Event` object, we can be confident that we aren't copying unexpected properties onto the other object.

```
......

Finished in 0.008 seconds
6 tests, 7 assertions, 0 failures
```

We can make an improvement to this function. We should consider the return value. At present, there is no `return` statement, so our function will return `undefined`. That's not very helpful to our users. Returning the extended object would make the following obvious usage possible.

```javascript
var obj = Evented.extend({});
```

So let's write one last test.

```javascript
// evented-spec.js
describe('Evented', function() {
  describe('extend', function() {
    // ...
    it('returns the extended object', function() {
      var a = {};
      expect(Evented.extend(a)).toBe(a);
    });
  });
});
```

```
......F

Failures:

  1) Evented extend returns the extended object
   Message:
     Expected undefined to be { on : Function, ... }.

Finished in 0.012 seconds
7 tests, 8 assertions, 1 failure
```

And if we return the object&hellip;

```javascript
var Evented = {
  // ...
  extend: function(other) {
    for (var property in this.Event) {
      other[property] = this.Event[property];
    }
    return other;
  }
};
```

```
.......

Finished in 0.01 seconds
7 tests, 8 assertions, 0 failures
```

So there we have it. In only 24 lines of code and 42 lines of test code, we have a working event system. You can browse [the finished code on GitHub](http://github.com/joecorcoran/event-tutorial-complete).

## Further exploration

* Add another function to our `Evented.Event` object named `off`. This function should receive one argument, an event name, and should remove all functions bound to that event.
* Consider the [`on` and `off` functions from `Backbone.Events`](http://backbonejs.org/docs/backbone.html#section-13) and how they differ from ours.
* Modify our `on` function such that if the event name given is `all`, the callback function will be called when *any* event is triggered. Describe this behaviour by using spies, then write it.
* Consider the [`listenTo` and `stopListening` functions from `Backbone.Events`](http://backbonejs.org/#Events-listenTo) and how they differ from `on` and `off`.
* Look back at the very first tests we wrote. Do they describe our code in a meaningful way? Are we better off with them or without them?
