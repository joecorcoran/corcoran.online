---
layout: default
title: "Designing the side-effects of persistence"
tags:
  - ruby
  - rails
  - listeners
  - services
---

Web applications that persist data, in 2015, have lots of side-effects. When you
log on and spout your reckons, your entire social graph *needs* to
know.

So `create`, `update` and their ilk are often accompanied by lines of code
which need to run right away, but have little relevance within the current
context.

Consider the following controller actions for creating and destroying photos.
There are side-effects for sending emails, sending mobile device push
notifications and updating the application search index.

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

A common approach in Rails applications is to use callbacks, which see the
side-effects triggered from within models. The above example with callbacks
would look as follows.

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

Both of the above scenarios bring problems. The first, with the cluttered controller actions, burdens the controller with too much knowledge of other classes and their behaviour. The callback approach simply moves the same
problem into the model. It can also be too blunt an instrument &#8212; consider
 that photos might be created from multiple places in our application &#8212; we may not really want to trigger the side-effects on *every* `create`, or every
 `destroy`.

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

class CreatePhoto
  def self.call(user, attrs = {})
    photo = user.photos.create(attrs)
    UserMailer.new_photo(photo).deliver_later
    SearchWorker::Index.perform_async(@photo)
    PushWorker::NewPhoto.perform_async(@photo)
    photo
  end
end

class DestroyPhoto
  def self.call(photo)
    photo.destroy
    SearchWorker::Remove.perform_async(@photo)
  end
end
```

```ruby
class PhotosController < ApplicationController
  def create
    @photo = current_user.photos.create(photo_params)
    Announcer.announce(:create_photo, @photo)
    # ...
  end

  def destroy
    @photo = current_user.photos.find(params[:id])
    @photo.destroy
    Announcer.announce(:destroy_photo, @photo)
  end
end

class MailListener
  def create_photo(photo)
    UserMailer.new_photo(photo).deliver_later
  end
end

class SearchListener
  def create_photo(photo)
    SearchWorker::Index.perform_async(@photo)
  end

  def destroy_photo(photo)
    SearchWorker::Remove.perform_async(@photo)
  end
end

class PushListener
  def create_photo(photo)
    PushWorker::NewPhoto.perform_async(@photo)
  end
end
```
