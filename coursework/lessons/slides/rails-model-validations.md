## Controlling the data

In most apps, you want to more strictly control the data users enter beyond just its type (e.g. string, integer, boolean, etc). For example, let's say I have a problem where I keep forgetting to enter a title for my blog posts. And the posts with no titles look really weird. How can I change my blogging app to make sure the title isn't left empty when creating a new post?

Fortunately, Rails has a feature to help us place detailed restrictions on our models. They're called __validations__. We list validations for a model in our model file. In a `Post` model for example, this file would be `app/models/post.rb`. While we're here, let's update our model to validate that a title is present. We'll change:

``` ruby
class Post < ActiveRecord::Base
end
```

to:

``` ruby
class Post < ActiveRecord::Base
  validates :title, presence: true
end
```

Now if we try to create or update a post _without_ a title, users will see a message like this:

![title error message](https://www.dropbox.com/s/0tu7h9zoa1s0yoo/Screenshot%202016-01-03%2023.26.44.png?dl=1)

If we want to specify our own error message, we can set `presence:` to a list of options instead of `true`:

``` ruby
class Post < ActiveRecord::Base
  validates :title, presence: {
    message: "is blank because you forgot to add one again!"
  }
end
```

And now we'll see this instead:

![title custom error message](https://www.dropbox.com/s/dvg5m5aiaz0xxye/Screenshot%202016-01-03%2023.28.51.png?dl=1)

We can even set up some validations to only happen _sometimes_. For example, maybe I'm OK with an empty title before a post is published, because no on will see it. We could update the validation to only run if the post is set to be published, by adding another option:

``` ruby
class Post < ActiveRecord::Base
  validates :title, presence: {
    message: "can't be blank for a published post",
    if: :is_published
  }
end
```

This works great, but sometimes the conditions under which you want a validation to run are a little more complicated than whether a single, boolean attribute is set to `true` or `false`.

For example, what if we have two different kinds of posts:

- Longer posts (more than 140 characters), where a title is displayed so we _do_ want to validate its presence.
- Shorter posts (140 characters or less), which show up more like a tweet on the frontend, so the title won't even display. In this case, we _don't_ want the validation to run.

In cases like this, we can define more complicated boolean expressions in a method, like this:

``` ruby
class Post < ActiveRecord::Base
  validates :title, presence: {
    message: "can't be blank for published posts longer than 140 characters",
    if: :is_published_with_longer_content?
  }

  def is_published_with_longer_content?
    is_published && content.length > 140
  end
end
```

---

## Validation helpers

This is just the tip of the iceberg. Out of the box, Rails includes a bunch of validation helpers. Below are the ones I find myself using the most, with a typical example for each:

### [`presence`](http://apidock.com/rails/ActiveModel/Validations/HelperMethods/validates_presence_of)

Validates that an attribute is not absent or blank.

``` ruby
class Book < ActiveRecord::Base
  validates :title, presence: {
    message: "can't be blank"
  }
end
```

### [`confirmation`](http://apidock.com/rails/ActiveModel/Validations/HelperMethods/validates_confirmation_of)

Checks for the existence of a matching confirmation attribute and validates that both the original and confirmation have the same value. For example, for an `email` attribute, it is expected that an `email_confirmation` field exists in the same form and that it contains the same value as the `email` field.

``` ruby
class Contact < ActiveRecord::Base
  validates :email, confirmation: {
    message: "did not match the confirmation"
  }
end
```

### [`inclusion`](http://apidock.com/rails/ActiveModel/Validations/HelperMethods/validates_inclusion_of)

Validates that an attribute contains one of a limited set of values.

``` ruby
class Movie < ActiveRecord::Base
  validates :rating, inclusion: {
    in: { 1..5 },
    message: "must be on a scale from 1 to 5 stars"
  }
end
```

### [`format`](http://apidock.com/rails/ActiveModel/Validations/HelperMethods/validates_format_of)

Validates that an attribute is of an expected format, described in a "regular expression" (aka "regex"). Below, the regular expression is `/\A\d{3}-\d{3}-\d{4}\z/`. Looks super complicated, right? Don't worry, you won't have to master that crazy syntax for this lesson. Instead, you'll learn how to steal other people's regular expressions!

``` ruby
class Contact < ActiveRecord::Base
  validates :phone_number, format: {
    with: /\A\d{3}-\d{3}-\d{4}\z/,
    allow_blank: true,
    message: "isn't a correctly formatted phone number: e.g. 123-456-7890"
  }
end
```

### [`length`](http://apidock.com/rails/ActiveModel/Validations/HelperMethods/validates_length_of)

Validates that an attribute has a specific length.

``` ruby
class User < ActiveRecord::Base
  validates :username, length: {
    within: 3..20,
    too_long: "pick a shorter username (at most %d characters)",
    too_short: "pick a longer username (at least %d characters)"
  }
end
```

### [`numericality`](http://apidock.com/rails/ActiveModel/Validations/HelperMethods/validates_numericality_of)

Validates that an attribute is a number and optionally, a specific kind of number.

``` ruby
class Toy < ActiveRecord::Base
  validates :number_in_stock, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    message: "must be an integer greater than or equal to 0"
  }
end
```

### [`uniqueness`](http://apidock.com/rails/ActiveModel/Validations/HelperMethods/validates_uniqueness_of)

Validates that an attribute is unique within the scope of its model and optionally, within the scope of other attributes.

``` ruby
class Post < ActiveRecord::Base
  validates :title, uniqueness: {
    message: "cannot have the same value as an existing post title"
  }
end
```

<hr>

Again, these examples listed are just that: limited examples. They don't include everything each validation helper is capable of. As you're actually implementing these validations, I highly recommend reading the linked documentation for each.

---

## Writing your own validations

Sometimes Rails' built-in validation helpers aren't enough. For example, let's say we're building an inventory for a store. We're keeping track of a `sale_price` and an optional `discounted_sale_price` for when an item is on sale. In this case, we'd probably want to make sure that the `discounted_sale_price` wasn't greater than or even equal to the `sale_price`. That'd have to be a typo, right?

The easiest way to add a custom validation in Rails is to create a new method in our model, then refer to that model with the `validate` helper. Here's an example:

``` ruby
validate :discounted_sale_price_is_less_than_sale_price

def discounted_sale_price_is_less_than_sale_price
  if discounted_sale_price.present? && discounted_sale_price >= sale_price
    errors.add(:discounted_sale_price, "can't be greater than or equal to the sale price")
  end
end
```

If a `discounted_sale_price` has been set and it's larger than or equal to the `sale_price`, we simply add an error.

Before Rails saves anything, it'll check to see if there are any errors on the model. If there are, it'll send the user back to the form, tell them about the problem, and make them fix it before continuing.

That's it!

---

## Changing the value of an attribute before it's validated

At first, this idea may sound strange. When would you want to do this? You want to do this __when users make predictable and easily fixed mistakes__.

For example, let's say you're building a clone of reddit.com, where users are providing links to other websites. A correctly formatted link will start with a protocol (`http://` or `https://`), but users keep leaving it out, _over and over again_. They're pasting in stuff like this:

- [google.com](google.com)
- [msu.edu](msu.edu)

instead of:

- [https://google.com](http://google.com)
- [http://msu.edu](http://msu.edu)

When you put the first set of links into the `href` for an anchor tag, you get _relative links_ on the _current website_, which messes everything up. Hover your mouse over them and you'll see what I mean.

So how do we fix that? How do we add the protocol if it doesn't already exist? Just for this purpose, Rails gives us a `before_validation` method, allowing us to run some code _just before_ validation occurs.

Here's how we could solve our problem:

``` ruby
before_validation :format_url

def format_url
  unless url =~ /\Ahttp/
    self.url = 'http://' + url
  end
end
```

As you can see, `before_validation` works similarly to our `validate` method: we give it the name of a method and Rails runs that method at the appropriate time.

Then in `format_website`, unless `website` starts with `"http"` (we're using a regular expression to check this, which we'll learn more about in a later lesson), we set `website` to "http://" plus itself. This way, we're automatically adding a protocol for them if they forgot.

<div class="callout callout-danger">

  <h4>Important</h4>

  <p>You see how I'm using `self.website` instead of `website` in that code example? You have to use `self.attribute =` when assigning a new value to an attribute in the model, for <a href="http://stackoverflow.com/questions/22032801/whats-the-difference-between-using-self-attribute-and-attribute-in-a-model"> complicated Ruby reasons</a> that you don't have to understand right now.</p>

  <p>All you have to remember is this: <strong>When you <em>get</em> the value of an attribute, just use the attribute's name. When you <em>set</em> the value of an attribute, use `self.attribute_name =`.</strong></p>

</div>

---

## Stealing validations (It's a good thing!)

Some common validations are a bit more complicated. For example, how do you make sure an `email` field _actually_ has a valid email address? The simplest way would be to validate the format with something like this:

``` ruby
validates :email, format: {
  with: /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/
  message: "isn't a properly formatted email address"
}
```

Did your eyes glaze over when you saw this: `/\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/`? It almost looks like I just mashed the keys on my keyboard. That's what regular expressions look like. Not to worry though! As I mentioned earlier, you do _not_ have to master regular expressions in this lesson. For now, you can just copy other people's!

So whenever you need to validate the format of an attribute, I recommend a good ol' Google search with something like this: "rails validate email" or "rails validate email format". You'll be able to find good results for emails, phone numbers, addresses, and many other common attributes. After all, you're not the first person to want to validate these kinds of attributes, so why reinvent the wheel?

---

## Psst... over here. I hear you're looking for some custom validations?

And because I like you, here are some super fancy validations I frequently use, from my personal stash. Please steal them at your leisure.

### Validate that an __address__ maps to valid geographic coordinates according to Google Maps or [other services](https://github.com/alexreisner/geocoder#street-address-services)

The heavy lifting here is done by the `geocoder` gem. I won't go into the [installation](https://github.com/alexreisner/geocoder#installation) and [setup](https://github.com/alexreisner/geocoder#activerecord) for this gem, because they're both well-documented. But once all that is done, all you have to do is add this to your model:

``` ruby
# Sets the latitude and longitude coordinates to be
# calculated from the address attribute on our model
geocoded_by :address
validate :valid_address

# Before the validation, try to calculate new latitude
# and longitude coordinates if the latitude was previously
# blank or the address was just changed
before_validation :geocode, if: -> (it) {
  it.latitude.blank? || it.address_changed?
}

def valid_address
  # If the latitude is missing (i.e. coordinates couldn't be calculated
  # from the given address), then add an error to the address attribute
  if latitude.blank?
    errors.add(:address, "isn't a valid location according to Google Maps")
  end
end
```

### Validate that a __URL__ isn't only in a valid _format_, but actually points to a real webpage

This one is accomplished without an external gem. It first validates the format of a URL, then if it looks good, tries to visit the URL to ensure it points to a valid webpage. It also runs surprisingly fast, since it doesn't try to load entire pages. It just gets _barely enough_ of the page to know that the URL does indeed go somewhere.

``` ruby
# Formats the url to fix missing protocols if it was just changed
before_validation :format_url, if: -> (it) {
  it.url_changed?
}

# Validates the url if it was just changed
validate :valid_url, if: -> (it) {
  it.url_changed?
}

def format_url
  # Unless the url already starts with "http"
  unless url =~ /\Ahttp/
    # Prepend it with "http://"
    self.url = 'http://' + url
  end
end

def valid_url
  # If the url looks at least kind of like a valid web address
  if url =~ /\Ahttps?:\/\/[\w\.-]+\S*\z/i
    begin
      # Try to visit the page and check the header response
      response = Net::HTTP.get_response URI.parse(url)
      # End the validation without errors if the status code is in the 200 or 300 range
      return if response.kind_of?(Net::HTTPSuccess) || response.kind_of?(Net::HTTPRedirection)
      # Set an error message if there was any other kind of status code
      message = "doesn't appear to be a page on #{response.uri.host} (#{response.code}: #{response.msg})"
    rescue # Recover on DNS failures
      # Set a message in the case that DNS couldn't even process the url
      message = "doesn't seem to exist on the web"
    end
  end
  # Set a generic error message if the none other message has been set
  message ||= "isn't a valid web address"
  # Add the error to the url attribute with the appropriate message
  errors.add :url, message
end
```
