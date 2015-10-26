## Two kinds of Embedded Ruby

So there are actually *two* ways to embed Ruby in an ERB file. You've seen seen this way already:

``` html
<%= CODE HERE %>
``

That runs some Ruby, then injects the result directly into the page. For example:

``` html
<p><%= 2 + 2 %></p>
```

will render into:

``` html
<p>4</p>
```

But sometimes, you want to run some Ruby without immediately injecting anything. For that, you simply leave out the equal sign, like this:

``` html
<% CODE HERE %>
```

That code is run, but does not directly affect the HTML. So... why would you ever want that? Probably the most common example is with Ruby arrays. An "array" in programming is just a list and we'll dive into them more deeply in a subsequent lesson.

---

## Ruby arrays

Arrays sound fancy but they're just _lists_. Here's an example:

``` ruby
[ 1, 2, 3 ]
[ 'one', 'two', 'three' ]
```

``` ruby
[
  #<CatAPI::Image:0x007f89b659b4c8
    @id="MTUxMjcxNw",
    @source_url="http://thecatapi.com/?id=MTUxMjcxNw",
    @url="http://25.media.tumblr.com/tumblr_m2i0ojdIwk1qbt33io1_1280.jpg"
  >,
  #<CatAPI::Image:0x007f89b659af78
    @id="2ui",
    @source_url="http://thecatapi.com/?id=2ui",
    @url="http://27.media.tumblr.com/tumblr_m2fj1wguN21qhwmnpo1_500.jpg"
  >,
  #<CatAPI::Image:0x007f89b659aa28
    @id="5g0",
    @source_url="http://thecatapi.com/?id=5g0",
    @url="http://25.media.tumblr.com/tumblr_lt0m0fmHxi1r4xjo2o1_500.jpg"
  >
]
```

Let's say we want to list a bunch of different kinds of cats. Wowza.

```html
<ul>
  <% [ 'American Shorthair', 'Abyssynian', 'Russian Blue' ].each do |cat| %>
    <li class="cat <%= cat.downcase.gsub(' ','-') %>"><%= cat %></li>
  <% end %>
</ul>
```

This evaluates to the following HTML:

```html
<ul>
  <li class="cat american-shorthair">American Shorthair</li>
  <li class="cat abbyssynian">Abyssynian</li>
  <li class="cat russian-blue">Russian Blue</li>
</ul>
```

Try it out for yourself.

---

More cats!
----------

The example we just went over is just the tip of the iceberg - and honestly, a little contrived. Who wants to see names of cats listed out? In the real world, it's all about cat *pics*.

What if your boss comes to you one day and says, "New kid! We need to display 100 random pictures of cats wearing hats, and we need them stat!" That day may come sooner than you think. Fortunately, you'll be prepared.

--

There's a gem for everything
----------------------------

You'll learn this soon. Unfortunately, there *wasn't* yet a gem to display tons of random pictures of cats! Can you believe it?! So I created one. You can use it by adding the following line to your `Gemfile`:

```ruby
gem 'cat_api'
```

Then running:

```bash
bundle install
```

--

Sending a local variable to our view
------------------------------------

In your `app.rb` file, you'll need to `require 'cat_api'`, then pass a variable to our view. Let's call it `pictures`, except to pass it to our view, we need to prepend it with `@`, making it `@pictures`. The value of `@pictures` will be an array of cats from The Cat API. If you're curious, here are [the different parameters you can pass to `get_images`]().

```ruby
# app.rb

require 'sinatra'
require 'cat_api'

class CatIndustriesApp < Sinatra::Base
  get '/cats' do
    @pictures = CatAPI.new.get_images(category: 'hats')
    erb :cats
  end
end
```

--

And finally, our embedded Ruby
------------------------------

```html
<% @pictures.each do |pic| %>
  <a href="<%= pic.source_url %>" title="This cat with a hat is brought to you by The Cat API">
    <img src="<%= pic.url %>">
  </a>
<% end %>
```

Can you believe that little hunk of code displays 100 cat pictures, all with hats, and each one wrapped in a link to its source?
