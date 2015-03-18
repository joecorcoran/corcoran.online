---
layout: default
title: "Designing the side-effects of data persistence"
tags:
  - ruby
  - rails
  - "design patterns"
---

Data persistence in a web application often comes with side-effects. So
`create`, `update` and their kind are often accompanied by code which needs to
run right away, but is only tangentially related to the current context.

This article explores some design possibilities for the code which causes
side-effects within a typical Rails application.

## Controllers gonna control

Consider the following controller actions for creating and destroying photos.
The controller actions also send emails, send mobile device push
notifications and update the application search index. Although the real work
will be done asynchronously (in this case via [Sidekiq][sidekiq]), the
controller kicks everything off.

```ruby
class PhotosController < ApplicationController
  def create
    @photo = current_user.photos.create(photo_params)
    UserMailer.new_photo(@photo).deliver_later
    SearchWorker::Index.perform_async(@photo)
    PushWorker::NewPhoto.perform_async(@photo)
    # ...
  end

  def destroy
    @photo = current_user.photos.find(params[:id])
    @photo.destroy
    SearchWorker::Remove.perform_async(@photo)
    # ...
  end
end
```

## Carly Rae Jepsen pun goes here

A common approach in Rails applications is to use
[`ActiveRecord` callbacks][callbacks], which trigger side-effects whenever
model instances change. Moving the side-effects into callbacks, the above
example would look as follows.

```ruby
class PhotosController < ApplicationController
  def create
    @photo = current_user.photos.create(photo_params)
    # ...
  end

  def destroy
    @photo = current_user.photos.find(params[:id])
    @photo.destroy
    # ...
  end
end
```

```ruby
class Photo < ActiveRecord::Base
  after_create :create_mail, :create_search, :create_push
  after_destroy :destroy_search

  private

  def create_mail
    UserMailer.new_photo(@photo).deliver_later
  end

  def create_search
    SearchWorker::Index.perform_async(@photo)
  end

  def create_push
    PushWorker::NewPhoto.perform_async(@photo)
  end

  def destroy_search
    SearchWorker::Remove.perform_async(@photo)
  end
end
```

Both of the above scenarios bring problems. The first, with the cluttered
controller actions, burdens the controller with too much knowledge of other
classes and their behaviour. "Too much knowledge" being a short way
of saying that a class has [too many responsibilities][srp].

The callback approach, while good for the controller, simply moves the problem
into the model. It can also be too blunt an instrument &#8212; consider that
photos might be created from multiple places in our application &#8212; we may
not really want to trigger all of the side-effects on every `create`.
`ActiveRecord` callbacks can be triggered conditionally, but in practice this
only increases code complexity.

The issue of bloated responsibilities is often highlighted through unit tests.
When a unit test contains numerous assertions about side-effects rather than
the main purpose of the class, it's tempting to just turn to mocks. Your
mileage may vary, but more than a few lines of mocking or stubbing can be
a sign that our design isn't quite right.

```ruby
describe PhotosController do
  describe 'POST :create' do
    before do
      allow(UserMailer).to receive(:new_photo) { double(deliver_later: true) }
      allow(SearchWorker::Index).to receive(:perform_async)
      allow(PushWorker::NewPhoto).to receive(:perform_async)
    end

    # ...
  end
end
```

## Service please

One way of shifting the work is to use [service classes][service]. We would
commit to no longer using `create` and `destroy` directly, but instead use
create- and destroy-service classes which take on two responsibilities:

1. To touch the record
2. To carry out all side-effects associated with touching the record

In the following example, a service class has strictly one class method.

```ruby
class PhotosController < ApplicationController
  def create
    @photo = CreatePhoto.call(current_user, photo_params)
    # ...
  end

  def update
    @photo = current_user.photos.find(params[:id])
    DestroyPhoto.call(@photo)
    # ...
  end
end
```

```ruby
class CreatePhoto
  def self.call(user, attrs = {})
    photo = user.photos.create(attrs)
    UserMailer.new_photo(photo).deliver_later
    SearchWorker::Index.perform_async(@photo)
    PushWorker::NewPhoto.perform_async(@photo)
    photo
  end
end
```

```ruby
class DestroyPhoto
  def self.call(photo)
    photo.destroy
    SearchWorker::Remove.perform_async(@photo)
  end
end
```

We have moved the side-effects into a separate place, which reduces the
resposibilities of the controller class. We can also reuse the service class
whenever we want the same side-effects, maybe adding extra service classes for
varying scenarios.

## Pub, Sub

A different approach is to use the [publish-subscribe pattern][pubsub]. If we
publish a message at the point of record creation/update, then any interested
subscriber can act whenever the message is published. In the following example,
we imagine a `publish` method which sends messages to all subscribers that
are able to respond.

```ruby
class PhotosController < ApplicationController
  def create
    @photo = current_user.photos.create(photo_params)
    publish(:create_photo, @photo)
    # ...
  end

  def destroy
    @photo = current_user.photos.find(params[:id])
    @photo.destroy
    publish(:destroy_photo, @photo)
  end
end
```

```ruby
class MailSubscriber
  def create_photo(photo)
    UserMailer.new_photo(photo).deliver_later
  end
end
```

```ruby
class SearchSubscriber
  def create_photo(photo)
    SearchWorker::Index.perform_async(@photo)
  end

  def destroy_photo(photo)
    SearchWorker::Remove.perform_async(@photo)
  end
end
```

```ruby
class PushSubscriber
  def create_photo(photo)
    PushWorker::NewPhoto.perform_async(@photo)
  end
end
```

The main difference between the service classes and the subscribers is
where we drew the boundaries. The service classes are themed by the type of
action being performed. This allows us to pick up the code that causes
side-effects and drop it all into one place. Whereas service classes remove the
problems introduced by callbacks, they really only move the complexity into a
new place. The `CreatePhoto` service retains knowledge of three other classes
and their interfaces.

The subscribers are themed by the type of side-effect for which they are
responsible, which further reduces the spread of domain knowledge. In our
example the controller actions simply publish messages and move on. The
subscribers wait for those messages, or not, as the case may be.

It is worth noting that the same pattern can be achieved through
`ActiveSupport`, with the [`Notifications` module][notifications] publishing
events and [`Subscriber` classes][subscriber] consuming those events
by being attached to an event namespace. However the `ActiveSupport`
implementation is better suited to instrumentation &#8212; it is most commonly
used for logging and timing.

```ruby
class PhotosController < ApplicationController
  include ActiveSupport::Notifications

  def create
    @photo = current_user.photos.create(photo_params)
    instrument('create_photo.photo_app', photo: @photo)
    # ...
  end

  def destroy
    @photo = current_user.photos.find(params[:id])
    @photo.destroy
    instrument('destroy_photo.photo_app', photo: @photo)
  end
end
```

```ruby
class MailSubscriber < ActiveSupport::Subscriber
  def create_photo(event)
    UserMailer.new_photo(event.payload[:photo]).deliver_later
  end
end
MailSubscriber.attach_to :photo_app
```

```ruby
class SearchSubscriber < ActiveSupport::Subscriber
  def create_photo(event)
    SearchWorker::Index.perform_async(event.payload[:photo])
  end

  def destroy_photo(event)
    SearchWorker::Remove.perform_async(event.payload[:photo])
  end
end
SearchSubscriber.attach_to :photo_app
```

```ruby
class PushSubscriber < ActiveSupport::Subscriber
  def create_photo(event)
    PushWorker::NewPhoto.perform_async(event.payload[:photo])
  end
end
PushSubscriber.attach_to :photo_app
```

*With thanks to [Simon Coffey][simon] for
[introducing me to the pub-sub idea][tribesports] a few years ago.*

[sidekiq]: http://sidekiq.org
[callbacks]: http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html
[srp]: http://en.wikipedia.org/wiki/Single_responsibility_principle
[service]: https://blog.engineyard.com/2014/keeping-your-rails-controllers-dry-with-services
[pubsub]: http://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern
[notifications]: http://api.rubyonrails.org/classes/ActiveSupport/Notifications.html
[subscriber]: http://api.rubyonrails.org/classes/ActiveSupport/Subscriber.html
[simon]: http://urbanautomaton.com
[tribesports]: http://techblog.tribesports.com/blog/2012/08/21/pub-sub-system-events-for-post-action-tasks
