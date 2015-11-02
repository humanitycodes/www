## Two kinds of Embedded Ruby

So there are actually *two* ways to embed Ruby in an ERB file. You've seen seen this way already:

``` html
<%= CODE HERE %>
```

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

That code is run, but does not directly affect the HTML. So... why would you ever want that? Probably the most common example is with Ruby arrays. An "array" in programming is just a list. We'll dive into them more deeply in a subsequent lesson, but for now, just know this:

1. Arrays can be a list of _anything_ (numbers, strings, cats, etc.)
2. When arrays are defined, you list the things you want to list with square brackets and a comma between each item, like this:

``` ruby
[ 1, 2, 3 ]
[ 'one', 'two', 'three' ]
```

---

## Listing cats on a page

Let's say we want to make a webpage that lists all our favorite cats. For the sake of brevity, we'll assume we're able to reduce the list to 3:

``` html
<ul>
  <% [ 'American Shorthair', 'Abyssinian', 'Russian Blue' ].each do |breed| %>
    <li class="cat <%= breed.downcase.gsub(' ','-') %>"><%= breed %></li>
  <% end %>
</ul>
```

When you run this, this will be the end result:

``` html
<ul>
  <li class="cat american-shorthair">American Shorthair</li>
  <li class="cat abyssinian">Abyssinian</li>
  <li class="cat russian-blue">Russian Blue</li>
</ul>
```

Now let's take a look at what's going on line-by-line.

```
<% [ 'American Shorthair', 'Abyssinian', 'Russian Blue' ].each do |breed| %>
```

Inside of uninjected ERB (`<%` `%>`), we're defining our array ([ 'American Shorthair', 'Abyssinian', 'Russian Blue' ]) and then going through each breed in that array (`.each do |breed|`).

```
<li class="cat <%= breed.downcase.gsub(' ','-') %>"><%= breed %></li>
```

Then for each breed, we create an `li` element, with two classes: "cat" and an all lowercased (i.e. "downcased") version of our breed, with the spaces substituted for dashes (`gsub` stands for "global substitution", which just means "replace all"). Inside of our `li` element, we inject the name of our breed.

`<% end %>`

And finally, we tell Ruby that we're at the "end" of doing something for each cat breed. Just like in our `app.rb`, where we have pairs of `get '/something' do` and `end`, you'll notice that whenever you have a `do` in Ruby, we're starting a section of code that will eventually have to be closed with an `end`.

Try this code out for yourself in one of your projects and make sure that it works.

---

## There's a gem for everything

The example we just went over is just the tip of the iceberg - and honestly, a little contrived. Who wants to see names of cats listed out? In the real world, it's all about cat _pictures_.

What if your boss comes to you one day and says, "New kid! We need to display 100 random pictures of cats wearing hats, and we need them stat!" That day may come sooner than you think. Fortunately, you'll be prepared.

Because __there's a gem for _everything___. You'll learn this soon. Unfortunately, there _wasn't_ yet a gem to display tons of random pictures of cats! Can you believe it?! So I created one. You can use it by adding the following line to your `Gemfile`:

```ruby
gem 'cat_api'
```

Then running:

```bash
bundle install
```

The `gem 'cat_api'` tells Ruby that we want to use the cat_api gem in our project. Then `bundle install` actually installs it.

---

## Playing with a new gem in IRB

Before including a new gem directly in a project, I often like to play with it first, to see what it can do. Ruby has a built-in tool for this called "IRB" (standing for "interactive Ruby"). Open up your command line and enter in `irb` now.

Possibly after a few seconds, a new command prompt will show up, which may look something like this:

```
[1] irb(main)>
```

That means you can now type in lines of Ruby code, line by line, and explore what they do.

Now to start playing with the gem we just installed, we have to let Ruby know we want to use it. You can do the `require` command:

``` ruby
require 'cat_api'
```

Now looking at [the usage document](https://github.com/chrisvfritz/cat_api#usage) for the cat_api gem, it seems like we should be able get an array of cats just by typing in these two lines:

``` ruby
client = CatAPI.new
client.get_images
```

When I typed that into my IRB, I got back this:

```
=> [#<CatAPI::Image:0x007f97bd335728
  @id="4ns",
  @source_url="http://thecatapi.com/?id=4ns",
  @url=
   "http://24.media.tumblr.com/tumblr_m2lncwNTLp1qiagllo1_500.jpg">]
```

It looks like the `get_images` method returns an array (notice the square brackets at the beginning and end). And this array only has one item: an `Image` object. And the image object has a bunch of other information associated with it: namely, an `id`, `source_url`, and `url`. These objects are pretty cool and you'll learn more about them later, including how to create your own custom objects - but for now, I'll just teach you a few different ways to play with arrays and objects like this.

First, let's grab the first item in the array and start playing with it. So that we don't have to get a new image every time, let's get the `first` item in the returned array and assign it to a variable that we'll call cat.

``` ruby
cat = client.get_images.first
```

That should return something like:

```
=> #<CatAPI::Image:0x007f97bd335728
  @id="4ns",
  @source_url="http://thecatapi.com/?id=4ns",
  @url=
   "http://24.media.tumblr.com/tumblr_m2lncwNTLp1qiagllo1_500.jpg">
```

Note that since the gem returns a random cat every time you run `get_image`, some of this information should be a little different. That's normal. You just got a different random cat than I did.

Now let's start accessing attributes of that cat. Probably the most useful attribute is `url`, which gives us a URL to that image. Guess how easy it is?

``` ruby
cat.url
```

```
=> "http://24.media.tumblr.com/tumblr_m2lncwNTLp1qiagllo1_500.jpg"
```

To access the `source_url` so that you can give credit where credit's due:

``` ruby
cat.source_url
```

```
=> "http://thecatapi.com/?id=4ns"
```

Excellent! Now the whole point of this is not to display 1 cat, but many, many cats. Like 100 cats. Looking back at the docs for the cat_api gem, it looks like there are [a few different options](http://thecatapi.com/docs.html#images-get) we can pass into `get_images`.

Let's play with those.

``` ruby
cats_in_boxes = client.get_images(results_per_page: 100, type: 'gif', category: 'boxes')
```

```
=> [#<CatAPI::Image:0x007f97bb362680
  @id="5ln",
  @source_url="http://thecatapi.com/?id=5ln",
  @url=
   "http://24.media.tumblr.com/tumblr_llhhozguSa1qgpl0co1_500.gif">,
 #<CatAPI::Image:0x007f97bb362158
  @id="hg",
  @source_url="http://thecatapi.com/?id=hg",
  @url=
   "http://24.media.tumblr.com/tumblr_lqrk6i1pp21qd8gt3o1_r2_250.gif">,
 #<CatAPI::Image:0x007f97bb361be0
  @id="d7",
  @source_url="http://thecatapi.com/?id=d7",
  @url=
   "http://28.media.tumblr.com/tumblr_lznpiq4KTA1qdry8zo2_250.gif">,
  ...
```

Excellent! By now, ideas should be beginning to form about how you could use this gem to show a bunch of random cats - arguably _too many_ cats - on a page.

---

## Sending data to our view in an "instance variable"

So let's set up a new `app.rb` that can specialize in cats.

``` ruby
# app.rb
require 'sinatra'
require 'cat_api'

class CatIndustriesApp < Sinatra::Base
  get '/cats' do
    @pictures = CatAPI.new.get_images(category: 'hats', results_per_page: 100)
    erb :cats
  end
end
```

You'll notice that we're requiring the cat_api gem, to let Ruby know we want to use it in this file. Then I've also given this Sinatra app a better name than the boring `MyWebApp` or something like that. Now it's called `CatIndustriesApp`!

Since our `config.ru` is responsible for running this app, let's update that file accordingly:

``` ruby
# config.ru
require File.join( File.dirname(__FILE__), 'app' )

run CatIndustriesApp
```

OK, now let's take a closer look at the route we defined:

``` ruby
get '/cats' do
  @pictures = CatAPI.new.get_images(category: 'hats', results_per_page: 100)
  erb :cats
end
```

That second line looks similar to what we were doing in `irb`, but in this case, our variable starts with an `@`. That makes it an "instance variable". In Ruby web development, instance variables are often used to pass specific information to our views, so that we can keep most of our Ruby in actual Ruby (`.rb`) files, rather than having it clutter up our views with a bunch of lines of uninjected Ruby.

If that variable were called `pictures` instead of `@pictures`, our `cats.erb` view file wouldn't be able to see it.

---

## Embedding our cats into the page with Ruby

```
<% @pictures.each do |pic| %>
  <a href="<%= pic.source_url %>" title="This cat with a hat is brought to you by The Cat API">
    <img src="<%= pic.url %>" alt="Cat with a hat">
  </a>
<% end %>
```

5 magical lines. 100 cats. 100 hats. Beautiful!
