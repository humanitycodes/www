## Introducing Ruby methods

In Ruby, __methods__ are a way of storing code you might want to run later. Here's a simple example of a method definition:

``` ruby
def current_year
  Time.now.year
end
```

We're `def`ining a method called `current_year`, which runs the code `Time.now.year`. Then whenever we want to run that code, we can just type the name we gave it: `current_year`.

Try opening up `irb` (the interactive Ruby console) in your terminal and enter this line to define the method on a single line (notice we've simply replaced the new lines with semi-colons):

``` ruby
def current_year; Time.now.year; end
```

Then let's "call" (i.e. run) our method by entering it's name.

``` ruby
current_year
```

Did you get back something like this?

```
=> 2015
```

---

## Using methods in Sinatra

That `current_year` method would probably be very useful in the copyright at the bottom of a page. Take that, future people! Thanks to the power of code, this copyright is _never_ expiring!

But... how do we use methods in Sinatra?

The easiest way is to list them in a `helpers do` ... `end` block, right after your routes, like this:

``` ruby
require 'sinatra'

class MyWebApp < Sinatra::Base
  get '/' do
    erb :home
  end

  helpers do

    def current_year
      Time.now.year
    end

  end
end
```

Any methods defined between `helpers do` and `end` are available in any of our routes and also in our views. So now, at the bottom of an `.erb` file, I might decide to put something like this:

``` html
<footer>
  <p>Copyright © Lansing Code Lab 2015-<%= current_year %></p>
</footer>
```

And that's _all_ it takes. Try adding this helper methods and a copyright to one your previous projects, just to make sure the method is working.

---

## Building strings in Ruby methods

One very common use for methods will be to take some other code and use it to build a useful __string__ (which is just programming-speak for text).

For example, let's say we want to show the current year. If it's January 15th, 2020, we want the date to appear on the page as `1/15/2020`.

The method for this might look like this:

``` ruby
def current_date
  "#{ Time.now.month }/#{ Time.now.day }/#{ Time.now.year }"
end
```

We're defining a string with the quotes (`""`). And in between them, we put the text we want to show up. When we want some code to run inside the string, we have to wrap it with `#{}`. Putting code inside of a string is called __string interpolation__.

What we're saying with that line is we want the string to consist of:

- The result of `Time.now.month`
- Then a `/`
- Then the result of `Time.now.day`
- Then another `/`
- Then the result of `Time.now.year`

In a `.erb` file, I might call this method like this:

``` html
<p>Today's date is <%= current_date %>.</p>
```

If you're still not quite sure what's going on, go ahead and pull over a mentor so they can explain it more clearly.

---

## Using variables inside of methods

Let's take a hypothetical scenario. Someone is visiting our website literally _nanoseconds_ before January 1st, 2016. In our `current_date` method, we're telling Ruby to find the current time _three_ times with `Time.now`. The first time, it sees that it's still December 31st, 2015, so `Time.now.month` returns `12`. But even though that runs _really, really_ fast, by pure coincidence, by the time we get to the day, it's actually January 1st, 2016 now! So `Time.now.day` returns `1` and `Time.now.year` returns `2016`. And the final date we get is `12/1/2016`. Yikes.

To avoid this kind of bug and even speed up our code a little. We can re-use values with variables, so that the computer doesn't have to recalculate them over and over again.

Here's an example, rewriting our `current_date` method:

``` ruby
def current_date
  current_time = Time.now
  "#{ current_time.month }/#{ current_time.day }/#{ current_time.year }"
end
```

We've changed our code to only calculate the current time _once_. Then we store the current time in a variable unimaginatively called `current_time`. Finally, we just grab the month, day, and year from that variable.

---

## Giving a method more information

Sometimes, you might want a method to do different things in different circumstances.

Our `current_date` method works well for the format used in the United States and Canada, but Europe (and the vast majority of the rest of the world) displays dates with the _day_ first, rather than the month. For example, January 15th, 2020 would be displayed as `15/1/2020`, instead of `1/15/2020`.

One solution would be to just have two methods:

``` ruby
def current_date_usa
  current_time = Time.now
  "#{ current_time.month }/#{ current_time.day }/#{ current_time.year }"
end

def current_date_europe
  current_time = Time.now
  "#{ current_time.day }/#{ current_time.month }/#{ current_time.year }"
end
```

That works _alright_, but let's say we want One Method To Rule Them All (and only one method we have to remember when working in our views). For that, we can use a nifty feature called __method parameters__. Here's an example:

``` ruby
def current_date(date_format)
  if date_format == 'usa'
    current_date_usa
  else
    current_date_europe
  end
end
```

That allows us to call the method with a value passed in, like `current_date('usa')`. Then inside the method, we're checking if the `date_format` has the value of `'usa'` (the `==` checks for equality). And if it does, we use the `current_date_usa` method. Otherwise (i.e. `else`), we use the `current_date_europe` method.

One advantage here is that if we do business in the United States and Europe, we can assume that if someone is _not_ in the United States, they're always using the European format. So `current_date('germany')`, `current_date('spain')`, or even `current_date('mars')` should always return the European date. Only date_format('usa') will give us the date formatted for the United States.

---

## More advanced conditionals

Good news! Your business has expanded to not only the United States and Europe, but also South America, Central America, and Canada.

Canada formats dates like the United States (month/day/year), but the rest of North, Central, and South America all format dates like Europe (day/month/year). So there are two changes we probably want to make:

- Since we're describing so many different regions, `current_date_usa` and `current_date_europe` aren't very good method names. Instead, let's rename them to `current_date_mdy` and `current_date_dmy`, respectively. I think these better describe what the methods actually do.
- Since we're not using `usa` and `europe` to describe formats anymore, we notice that what's _really_ being passed to `date_format` is a country, so let's rename that variable to `country.`
- Now that we have Canada also using the month/day/year date format, let's upgrade our conditional (the `if` statement) to check if the `country` is `'usa'` _OR_ the `country` is `'canada'`. In Ruby and many other programming languages, the way we write "or" is with double pipes (`||`). Pipe (`|`) can usually be found on a key above the Enter key.

``` ruby
def current_date(country)
  if country == 'usa' || country == 'canada'
    current_date_mdy
  else
    current_date_dmy
  end
end

def current_date_mdy
  current_time = Time.now
  "#{ month.day }/#{ current_time.day }/#{ current_time.year }"
end

def current_date_dmy
  current_time = Time.now
  "#{ current_time.day }/#{ current_time.month }/#{ current_time.year }"
end
```

If you wanted to check if two things were _both_ true, you would use a double ampersand (`&&`), which again in Ruby and many other programming languages, means "and". Here's an example:

``` ruby
if you_are_happy && you_know_it
  'Clap your hands'
end
```

And what about when you want to check that something is _not_ true? You can use `!` (read "not") to flip a `true` to a `false` or a `false` to a `true`. Like this:

``` ruby
if you_are_happy && you_know_it && !you_are_afraid_to_show_it
  'Clap your hands'
end
```

---

## Figuring out how to do things in Ruby

So we've got a tiny problem. We figure out someone's country by text they type in. Some people are typing `usa` and some are typing `USA`, with capitals - even though we have clear instructions _not_ to use capitals! It happens. Users, am I right?

The problem is that `country == 'usa'` returns `false` when the country passed in is `USA`. It's case sensitive. And... we have no idea how to make it _not_ case sensitive.

Trust me, having no idea how to do something will happen _all the time_ when working in any programming language. It's normal to turn to Google with something like, "ruby don't pay attention to case", "ruby uppercase and lowercase doesn't matter", or "ruby string compare case insensitive". When I searched for that just now, the first result was [this page](http://stackoverflow.com/questions/2844507/ruby-string-compare-regardless-of-string-case), which explained with examples how I could use the `casecmp` method to compare strings case insensitively.

``` ruby
def current_date(country)
  if country.casecmp('usa') == 0 || country.casecmp('canada') == 0
    current_date_mdy
  else
    current_date_dmy
  end
end
```

Yay!

---

## Building HTML programmatically in helper methods

There are often big chunks of HTML that we find ourselves having to write out all the time. And it's annoying having to remember to add all the right classes and other attributes. For example, let's say we have a sidebar with a bunch of widgets

``` html
<aside class="sidebar-widget">
  <h3 class="sidebar-widget-title">
    This is my title
  </h3>
  <div class="sidebar-widget-content">
    This is my content.
  </div>
</aside>
```

That's a lot of HTML to type out when all we really care about is that we're creating a widget, with a title of `This is my title` and content of `This is my content.`. So how can we be lazier?

Well, we've already created strings with `""` and `''`. When creating multiline strings that may have `"`s and `'`s inside of them though, it's often useful to use a percent (`%`) with any opening and closing symbol, like the parentheses (`(` and `)`). Here's an example:

``` ruby
def sidebar_widget(title, content)
  %(
    <aside class="sidebar-widget">
      <h3 class="sidebar-widget-title">
        #{title}
      </h3>
      <div class="sidebar-widget-content">
        #{content}
      </div>
    </aside>
  )
end
```

Notice how even though we have `"` characters, they aren't closing the string. And see how we're building the HTML in the string and injecting the title and content where they need to be? With that method, we can create the same HTML with a simple:

```
<%= sidebar_widget("This is my title", "This is my content.") %>
```

Taking a look at another example, let's say I'm using Twitter Bootstrap in a project and it's difficult to remember all the HTML needed to create an alert box. But I need a lot of alerts, so I'm thinking of extracting it all out to a helper method. Here are a couple examples of the HTML I have to write:

``` html
<div class="alert alert-info alert-dismissible" role="alert">
  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
  This is just a friendly, informational message.
</div>
```

``` html
<div class="alert alert-warning alert-dismissible" role="alert">
  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
  Warning! This is a message warning you about something!
</div>
```

It's the same HTML every time, except we use `alert-info` for an informational class in the first example and the `alert-warning` for the warning message in the second example. The message itself is also different.

Now let's turn it into a helper method:

``` ruby
def bootstrap_alert(type, message)
  %(
    <div class="alert alert-#{type} alert-dismissible" role="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
      #{message}
    </div>
  )
end
```

Suddenly, the 6 complicated lines we had to write for every alert is reduced to one much simpler line:

```
<%= bootstrap_alert('info', 'This is just a friendly, informational message.') %>
```

And the second example would be created with:

```
<%= bootstrap_alert('warning', 'Warning! This is a message warning you about something!') %>
```

---

## Setting default values for methods

Sometimes, we want methods to make assumptions about what we want, so that we don't have to tell them explicitly every time. For example, let's say 90% of our alerts are actually using type `'info'`. How can we modify our method so that we don't always have to specify the type?

In Ruby, if we want a method parameter to have a default value, it's as simple as writing `type='info'` instead of just `type` on the first line. Well, _almost_ as simple. Ruby recognizes parameters by their order, so if we're not going to be including parameters sometimes, they need to come last.

Like this:

``` ruby
def bootstrap_alert(message, type='info')
  %(
    <div class="alert alert-#{type} alert-dismissible" role="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
      #{message}
    </div>
  )
end
```

Then we can simply include this line in our view:

```
<%= bootstrap_alert('This is just a friendly, informational message.') %>
```

And it'll do the same thing as:

```
<%= bootstrap_alert('This is just a friendly, informational message.', 'info') %>
```

In the case that we want a warning alert instead, it's just:

```
<%= bootstrap_alert('Warning! This is a message warning you about something!', 'warning') %>
```

What's nice is that most of the time though, we can just include our message, making our method even smarter! And we can be even lazier!
