## What is Ruby on Rails?

Ruby on Rails (often shortened to just "Rails") is the most popular Ruby web framework. Whereas Sinatra is tiny and fast, with very few assumptions about what you want to build, Rails takes a different approach. It's much bigger, but is set up in such a way that it's very easy to quickly add new features.

So what kinds of features? What exactly can you build with Rails? GitHub, for one. Airbnb, Hulu, Shopify, Basecamp, and more. Even Twitter started out on Rails. This webapp - the one you're reading now - is also built on Rails. And because Rails makes so many things easy, I was able to build it mostly _by myself_, in my spare time.

---

## Creating your first Rails app

The command to generate the files for a new Rails app also creates a folder to keep them in, so before we do anything, let's first `cd` into the folder where you keep Code Lab projects.

Then in the Ruby setup lesson, we already installed Ruby and the `rails` gem, so now starting a new Rails app is as simple as:

``` bash
rails new codelab-rails-intro
```

We're not writing any tests for now though, so to keep things simpler, our modified command to create a new rails app will instead be:

``` bash
rails new codelab-rails-intro --skip-test-unit
```

---

## Tour of a new Rails app

This just created a new folder called `codelab-rails-intro`, with (by my count) 50 new files, containing 976 lines of code. Woah. Fortunately, you don't have to know what all of them do for a long time yet!

Instead, we'll take a quick tour of the most important parts. To do so, `cd` into that folder and open it in Atom with:

``` bash
cd codelab-rails-intro
atom .
```

---

## Views

Just like our Sinatra apps had a `views` directory, so does our Rails app - except it's in `app/views`. Once again, that's where we'll keep our HTML.

### Default layout

As you'll see, we already have a single folder in there called `layouts`, containing a single file: `application.html.erb`. Rails is so nice, it already comes with a layout file so we don't have to create one!

### View file extensions

And just like in Sinatra, it's in good ol' ERB. But there's one difference. This file actually has _two_ extensions. First, `html`, _then_ `erb`. Just note for now that this is important for some of Rails' magic.

---

## Assets

In Sinatra, we kept our static assets (like CSS, JavaScript, and images) in a folder called `public`. Rails actually has a `public` folder too, used for the same purpose, but __you'll almost never use it__.

Instead, for any CSS, JavaScript, or images, there are actually corresponding folders set up for you in `app/assets`. Placing files in these folders makes them a part of __the asset pipeline__, which allows you to use preprocessors and does automatic concatenation and minimization (with optional compression).

Sound like a bunch of gobbledygook? Don't worry - we'll go over what all of those words mean right now.

### Preprocessors

If you prefer writing in a CSS preprocessor such as SCSS, SASS, Less, or Stylus, you're in luck. Rails will look at the file extension and if it's not CSS, it will automatically compile it _into_ CSS.

Rails supports SCSS and SASS out of the box, but adding support for others is usually as simple as adding a new gem to the `Gemfile`, then running `bundle install`.

### Concatenation

It's often useful to organize your CSS and JS into many files and folders. The problem is, it takes web browsers a lot more time to process many requests for small files, than a single request for one big file.

So the asset pipeline helps out here by concatenating (i.e. combining) all our CSS into one big CSS file and all our JS into one big JS file.

### Minimization

Would you want to look at this kind of CSS while styling your app?

``` css
.first_class{width:100%;height:auto}.second_class{width:32px;height:32px;background:#324962}
```

Of course not. The problem is, all the comments, spaces, newlines, and unnecessary semi-colons that make this work easier _also_ make files bigger. And the bigger files are, the longer they take to download. Which means slower page loads.

That's why the asset pipeline will automatically strip away all that stuff in a live, "production" environment like Heroku.

---

## Routes, controllers, and actions

### How it worked in Sinatra

This is where the territory becomes a little less familiar. We never worked with "controllers" in Sinatra. The good news is, we _have_ dealt with actions and routes, even if we haven't used those words. Let's take this example:

``` ruby
get '/cat-pictures' do
  @cats = CatAPI.new.get_images(results_per_page: 10)
  erb :cats
end
```

A __route__ is a rule for what should happen when a user visits different parts of our app. For example, "When a visitor goes to X, do Y." In that sentence, `Y` is our __action__. As you'll see above, Sinatra combines routes and actions into a single chunk of code. The first and last lines are our route, while everything in the middle is our action.

### How it works in Rails

Since Rails apps often get a little more complex, we organize things a little differently. Instead of having our routes and actions together, our routes are all listed in `config/routes.rb` and our actions are organized into __controllers__ in the `app/controllers` folder.

It's hard to wrap your head around without an example, so let's start creating some pages for our app. On the next page, we'll expore the process by creating _Home_ and _About_ pages.

---

## Rails generators

Rails has nifty __generators__ to make common tasks simpler. We need some static pages (i.e. pages that aren't tied to our database), so let's create a new controller called `static` to keep them in. This controller will have two actions, called `home` and `about`.

The generator command we run in the terminal to accomplish this is:

``` bash
rails generate controller Static home about
```

When you run that command, it should spit back something like this:

``` output
create  app/controllers/static_controller.rb
 route  get 'static/about'
 route  get 'static/home'
invoke  erb
create    app/views/static
create    app/views/static/home.html.erb
create    app/views/static/about.html.erb
invoke  helper
create    app/helpers/static_helper.rb
invoke  assets
invoke    coffee
create      app/assets/javascripts/static.coffee
invoke    scss
create      app/assets/stylesheets/static.scss
```

Now let's dive in these files and what they do.

### The controller

``` output
create  app/controllers/static_controller.rb
```

So it looks like we created a new file: `static_controller.rb`. Taking a look inside with our text editor, it looks like it contains the following code:

``` ruby
class StaticController < ApplicationController
  def home
  end

  def about
  end
end
```

This is defining two actions: `home` and `about`. Both are just empty methods right now, so we're not running any Ruby code before passing the baton to our view.

But... don't we still need something like `erb :home`, like we did in Sinatra? We don't! Unless we want to [render a specific view](http://apidock.com/rails/ActionController/Base/render), each action will default to looking for a view file in `app/views/NAME_OF_CONTROLLER/NAME_OF_ACTION.html.*`. In this case, our generator has already created `app/views/static/home.html.erb` and `app/views/static/about.html.erb`, so we're all set.

It's also good to note that just like in Sinatra, any instance variables (variables starting with `@`) we define here will be available in our view.

### The views

``` output
invoke  erb
  create    app/views/static
  create    app/views/static/home.html.erb
  create    app/views/static/about.html.erb
```

Now diving into our views, we can confirm that the generator created a new `static` folder in the `views` folder, with two files: `home.html.erb` and `about.html.erb`. If you look inside them, you'll see something like:

``` html
<h1>Static#home</h1>
<p>Find me in app/views/static/home.html.erb</p>
```

There's no Ruby here yet. Just HTML. But since they end in `.erb`, you can use the same embedded Ruby you used in Sinatra.

### The routes

``` output
route  get 'static/about'
route  get 'static/home'
```

We also have two new routes, one for each action. You can find both of these in `config/routes.rb`. This is what they mean:

``` ruby
get 'static/home'
# when a visitor goes to `/static/home`, send them to
# the `home` action in the `static` controller

get 'static/about'
# when a visitor goes to `/static/about`, send them to
# the `about` action in the `static` controller
```

Let's actually change these. How about we make `home` the root our app (`/`), then make `about` available at `/about`? This is as simple as:

``` ruby
root 'static#home'
# when a visitor goes to the root of our app (`/`), send
# them to the `home` action in the `static` controller

get '/about' => 'static#about'
# when a visitor goes to `/about`, send them to the
# `about` action in the `static` controller
```

The comments in `routes.rb` have even more examples of kinds of routes you can create.

### Summary of routes, controllers, and views

To summarize what we've gone over so far, I've prepared this little infographic.

[![Serving a page in Rails](http://i.imgur.com/elBnQLi.jpg)](http://i.imgur.com/elBnQLi.jpg)

### The helper

``` output
invoke  helper
  create    app/helpers/static_helper.rb
```

We also have a new file to keep helper methods we want to use in our static pages. If you look inside the helper now, it'll just be an empty module:

``` ruby
module StaticHelper
end
```

If we wanted to use our `current_date_and_time` method from the previous app, we could make it available in our views with:

``` ruby
module StaticHelper
  def current_date_and_time
    Time.now.strftime('%B %-d, %Y at %-l:%M%P')
  end
end
```

### The assets

``` output
invoke  assets
invoke    coffee
create      app/assets/javascripts/static.coffee
invoke    scss
create      app/assets/stylesheets/static.scss
```

Finally, the generator created some empty files for any JavaScript or CSS we might need for our static pages. Don't want to write in CoffeeScript? Then just rename `static.coffee` to `static.js`.

---

## We're done (almost)!

Let's run our app to test that everything is working. The command to run the Rails server is:

``` bash
rails server
```

Note that instead of serving to `localhost:9292` like Sinatra, Rails apps serve to `localhost:3000` by default. Now check it out in your browser!

---

## Adding a new action

The app is looking pretty good so far. But now we want a new page to show a list of cats. This time we'll do it without a generator, by adding...

### 1) `gem 'cat_api'` to the Gemfile and then running `bundle install`

``` ruby
# Gemfile
gem 'cat_api'
```

``` bash
bundle install
```

### 2) A `cats` action in our static controller

``` ruby
# app/static_controller.rb
def cats
  @cats = CatAPI.new.get_images(results_per_page: 10)
end
```

Notice that unlike in Sinatra, we don't need to add `require 'cat_api'` to the top of the file we're using it in, because Rails is autorequiring the `cat_api` gem for us, throughout our project.

### 3) A route that serves the `cats` action to `/cat-pictures`

``` ruby
# config/routes.rb
get '/cat-pictures' => 'static#cats'
```

### 4) A view that displays each cat picture in an image tag

``` erb
<!-- app/views/static/cats.html.erb -->
<% @cats.each do |cat| %>
  <img src="<%= cat.url %>" alt="Cat pic">
<% end %>
```

Now check out the app in your browser to make sure you're getting some cat pics at `/cat-pictures`.

---

## Adding a URL parameter

If we want a dynamic URL for different numbers of cats, we can add a new route.

``` ruby
# config/routes.rb
get '/cat-pictures'                 => 'static#cats'
get '/cat-pictures/:number_of_cats' => 'static#cats'
```

This second route allows us to optionally specify a specific number of cats. We'd get this number in trusty ol' `params` in our controller, like below. In this case, if there's nothing in `params[:number_of_cats]`, we'll simply be shown 1 cat.

``` ruby
# app/static_controller.rb
def cats
  @cats = CatAPI.new.get_images(results_per_page: params[:number_of_cats] || 1)
end
```

---

## Optional URL parameters

``` ruby
# config/routes.rb
get '/cat-pictures'                 => 'static#cats'
get '/cat-pictures/:number_of_cats' => 'static#cats'
```

Whenever there's a case where sometimes you'll include a parameter and sometimes you won't, you can specify the parameter as optional with parentheses. In this case, the code above can be shortened to:

``` ruby
# config/routes.rb
get '/cat-pictures(/:number_of_cats)' => 'static#cats'
```

---

## Displaying a navigation menu

So there's a tiny problem. If a visitor goes to the root of our application, they have no way of knowing that we have an `/about` page or a `/cat-pictures` page. To fix this, we'll use Rails' built-in [URL helpers](http://api.rubyonrails.org/classes/ActionView/Helpers/UrlHelper.html) and [route helpers](http://guides.rubyonrails.org/routing.html) to display a navigation menu.

### Route helpers

If you want to get a list of routes in your application, you can type `rake routes` into the terminal and you'll get something like this:

``` output
Prefix Verb URI Pattern             Controller#Action
  root GET  /                       static#home
 about GET  /about(.:format)        static#about
       GET  /cat-pictures(.:format) static#cats
```

See the _Prefix_ column? Rails takes those prefixes and appends `_path` to them, to automatically create helper methods you can use in your view. For example:

``` ruby
root_path  # returns "/"
about_path # returns "/about"
```

The advantage to using helper methods for these is that if we later decide we want our about page to be at `/about-us` instead, we don't have to hunt down 20 different links throughout our app. The helper method can just return `"/about-us"` instead.

But, uhh... where's the prefix for `/cat-pictures`? Well, sometimes Rails won't know what kind of automatic prefix it should generate. Such is the case for the line below:

``` ruby
# config/routes.rb
get '/cat-pictures(/:number_of_cats)' => 'static#cats'
```

Fortunately, we can manually set one up with an `as: :my_prefix` parameter. In our case, we can update this line to:

``` ruby
# config/routes.rb
get '/cat-pictures(/:number_of_cats)' => 'static#cats', as: :cat_pictures
```

Now re-running `rake routes` gives us:

``` output
      Prefix Verb URI Pattern             Controller#Action
        root GET  /                       static#home
       about GET  /about(.:format)        static#about
cat_pictures GET  /cat-pictures(.:format) static#cats
```

Which means we now also have a `cat_pictures_path` method available in our views, which returns `/cat-pictures`. Yay!

### URL Helpers

If we combine route helpers with the `link_to` URL helper, we can create a nice list of the pages in our app.

``` erb
<ul>
  <li><%= link_to 'Home', root_path %></li>
  <li><%= link_to 'About', about_path %></li>
  <li><%= link_to 'Cat Pictures', cat_pictures_path %></li>
</ul>
```

This would generated the following HTML:

``` html
<ul>
  <li><a href="/">Home</a></li>
  <li><a href="/about">About</a></li>
  <li><a href="/cat-pictures">Cat Pictures</a></li>
</ul>
```

Can you guess where you'd put this code so that it would show up at the top of every page?

---

## Deploying to Heroku

There are a few things we have to change to get Rails ready for Heroku. [Heroku's docs](https://devcenter.heroku.com/articles/getting-started-with-rails4) have a lot of information on how you can work with Rails applications on Heroku, but here are the minimal steps you must take.

### Configure your database

We're not working with the database yet, but we our app still comes with one.

Ideally, it's a good idea to use the same database locally (on your computer) as you do in production (on Heroku). We don't live in an ideal world though, so for the sake of simplicity and because we won't be doing any complex database work for a while, you're going to use the very simple SQLite3 locally, but PostgreSQL on Heroku (since it doesn't work with SQLite3).

Fortunately, Rails has different __environments__ available, so that we can differentiate our setup in the `development` environment (when we're running Rails on our computer) from the `production` environment (when Rails is running on the server that the world sees).

Here's how we set up our development and production environments to use different databases.

### Set up our Gemfile

First, remove this line from your `Gemfile`:

``` ruby
gem 'sqlite3'
```

And add this:

``` ruby
group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
```

### `bundle install` without production gems

Then when you `bundle install`, you'll want to add the `--without production` flag to skip local installation of production gems (i.e. gems that only Heroku needs):

``` bash
bundle install --without production
```

__From now on, you'll have to use this line every time you do a `bundle install`, until you have PostgreSQL installed on your computer. Otherwise, you'll likely get some errors.__
