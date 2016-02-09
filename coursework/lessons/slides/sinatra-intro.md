## Libraries: other people's code

There's quite a bit involved in creating a webapp. But guess what? There's quite a bit involved in making a grilled cheese sandwich - there's the growing of the wheat, collection of other ingredients, turning it into bread, then cultivating animal milk into cheese and butter. Then you have to build a fire to heat it all up - except typically, you'll do none of that. You outsource most of it.

And that's exactly what we do in web development. We let other people worry about the nuts and bolts. All we want to worry about is what's special about _our_ webapp. So communities of people around the world work on __open source__ (meaning freely available to use and even contribute to) __libraries__ (meaning a collection of code made to be used in other projects).

In the Ruby world, because the programming language is called _Ruby_, there's a cute little name we use for libraries: __gems__. _Ruby gems_? Get it? As you'll discover, programmers love coming up with silly names for things.

For example, two popular web servers are _unicorn_ and _rainbows_.

![Unicorns and rainbows](http://www.ancientlight.info/products/images_robes/unicorn_rainbow_fabric.jpg)

---

## Starting files

To start with, we'll be using the __sinatra__ gem to create simple webapps. And instead of creating an HTML file like before, we'll create 3 very small files.

Let's briefly go over each one now on the following pages.

---

## app.rb

This is where we'll keep most of the code related to our webapp.

``` ruby
require 'sinatra'

class MyWebApp < Sinatra::Base
  get '/' do
    "Welcome to the webapp of DOOM, where the copyright is always up to date! Copyright 2014-#{ Time.now.year } Your Name."
  end

  get '/about' do
    "Here's a little information about me."
  end
end
```

Now line by line...

``` ruby
require 'sinatra'
```

At the top, we __require__ sinatra to let it know we want to use the code from that gem.

``` ruby
class MyWebApp < Sinatra::Base
```

Then we define a webapp unimaginatively called `MyWebApp`, which uses (`<`) code from `Sinatra::Base`.

``` ruby
get '/' do
```

Now whenever a user tries to get to the homepage (`/`), we want to _do_ some stuff.

``` ruby
"Welcome to the webapp of DOOM, where the copyright is always up to date! Copyright 2014-#{ Time.now.year } Your Name."
```

And what will we do? We'll show some text, starting with "Welcome to the...". And here's where having a web __application__ becomes useful. We're using some Ruby to make sure the current year is always displayed in the copyright, so that it can _never_ expire. Bwahh haa haa!!

Whenever you want text in Ruby, which in programming lingo is called a __string__ (i.e. a string of characters) you have to put apostrophes or quotes around it. Here, we're using quotes, because they also allow us to embed Ruby directly into our string. We do this by putting the Ruby code in between `#{` and `}`. And `Time.now.year` always gives you the current year.

We also have another get block defined:

``` ruby
get '/about' do
  "Here's a little information about me."
end
```

This one makes it so that when a visitor goes to our `/about` page, they'll see the words: "Here's a little information about me."

Each of these `get '/SOMEWHERE' do ... end` is called a __route__ and we define one for every page we want on our website.

---

### config.ru

This is the file we'll use to launch our webserver. The name of this file is very special. There's a command we can run from the terminal called `rackup` which looks for this file and uses it to start a web server from our computer, so we can visit it and test out our app in a web browser.

``` ruby
require File.join( File.dirname(__FILE__), 'app' )

run MyWebApp
```

And line by line...

``` ruby
require File.join( File.dirname(__FILE__), 'app' )
```

Once again, the require defines what code we'll be referencing in this file. In this case, we're referencing the "app.rb" file we just made. The `File.dirname(__FILE__)` just gets the folder that the `config.ru` file is in, and we use `File.join` with that and `'app'` to require a Ruby file called "app.rb" in the same folder.

``` ruby
run MyWebApp
```

Isn't it nice when code pretty much reads like English? This lines _runs_ our webapp, which in this example is called `MyWebApp`.

---

### Gemfile

Our Gemfile is where we list all the __dependencies__ in our application. A dependency is a just a gem that this project uses.

``` ruby
source 'https://rubygems.org'

gem 'sinatra', '~> 1.4.6'
```

Line by line...

``` ruby
source 'https://rubygems.org'
```

First, we have to say where we're getting our gems from. The official gem source in the Ruby community is `rubygems.org`, which is supported for free by the nonprofit [Ruby Together](https://rubytogether.org/).

And then we just list our dependencies.

``` ruby
gem 'sinatra', '~> 1.4.6'
```

The only dependency of this app is version 1.4.6 of the "sinatra" gem. The `~>` means that if version 1.4.6.2 or 1.4.6.3 comes out, our project can be safely upgraded to those.

Why wouldn't we just want to use the latest version of everything? Great question! In future versions of sinatra, like 1.5 for example, it's possible that the gem will work _slightly_ differently and that difference could break our project. By locking in at a version we _know_ works, we prevent someone else from breaking our app.

---

## Let's see what our app does

Now the moment of truth! Almost. If we try to run our webapp right now using `rackup`, we'll probably get an error like this:

``` output
cannot load such file -- sinatra (LoadError)
```

That's because there are a lot of gems for Ruby and they wouldn't all fit on your computer. So in order to use one, it has to be installed first. Listing the gems our app uses in a `Gemfile` makes this really easy. Whenever we want to set up an app on a new computer or server, we just have to run the following in our project directory:

``` bash
bundle install
```

You may notice that this command creates a new file called `Gemfile.lock`, which stores a snapshot of the _exact_ versions of all the gems your application is using. Note that you'll _never_ edit this file directly - the only way it changes is through `bundle` commands.

_Now_ let's try to run our app with the following command (make sure you're still in your project directory):

``` bash
rackup
```

---

## Viewing our app in a web browser

If the `rackup` command was successful, you should see something like this (it need not look exactly like this - as long as you don't get an error message, you're fine):

``` output
[2015-09-30 12:58:25] INFO  WEBrick 1.3.1
[2015-09-30 12:58:25] INFO  ruby 2.2.1 (2015-02-26) [x86_64-darwin14]
[2015-09-30 12:58:25] INFO  WEBrick::HTTPServer#start: pid=1542 port=9292
```

See the `port=9292`? That means you can now go to `localhost:9292` in your web browser and check out your app live in action! When you want to close the server and get your terminal back, press Ctrl+C.

---

## Push your project to Heroku

To create a new Heroku app, you can run this command in the terminal, from your project directory:

``` bash
heroku create
```

Then to make your app live at `randomly-assigned-name.herokuapp.com`:

``` bash
git push heroku master
```

And finally, to open your live app in the browser:

``` bash
heroku open
```
