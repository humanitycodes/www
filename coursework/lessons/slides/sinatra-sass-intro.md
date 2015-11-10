## The problem with CSS

Take a look at this:

```
a {
  color: dodgerblue;
}
a:visited {
  color: dodgerblue;
}
a:hover {
  color: steelblue;
}
a:active {
  color: steelblue;
}

button {
  background-color: dodgerblue;
  color: white;
}
button:hover {
  background-color: steelblue;
}
```

It defines what color our links and buttons should be in various states. It works, but there are a few things I don't like about it:

- Everything is defined in a list, even though there's a hierarchy. When scanning our rules, it's difficult to see that hierarchy.
- We're repeating the same colors over and over again! That means when we want to change that color, we have to change it everywhere that we're defining it.
- The `steelblue` is slightly darker than `dodgerblue`. That's the only reason we picked it. But there's not a way in CSS to just say, "We want color Y to be slightly darker than color X."

---

## The advantage of SASSy CSS

SASS is a special kind of language called a __CSS preprocessor__. That means we write our styles in SASS and they get _processed_ into regular CSS for the browser.

It's also _superset_ of CSS, meaning you can write anything you would in normal CSS, but you also gain some superpowers.

Let's take a look at those superpowers by rewriting the CSS from the last page. This is going to look pretty new, see if you can figure out what's going on:

```
$link-color: dodgerblue;
$link-hover-color: darken($link-color, 15%);

a {
  color: $link-color;

  &:visited {
    color: $link-color;
  }
  &:hover {
    color: $link-hover-color;
  }
  &:active {
    color: $link-hover-color;
  }
}

$button-bg: $link-color;
$button-hover-bg: $link-hover-color;
$button-color: white;

button {
  background: $button-bg;
  color: $button-color;

  &:hover {
    background: $button-hover-bg;
  }
}
```

- We're defining variables (the word chunks starting with `$`) to re-use values. That means if we later decide to change the `$link-color`, for example, we only have to change it in one place.
- Rules are now nested inside each other, so that there's a clear visual hierarchy. We have a section where `a` rules are defined and another where `button` rules are defined.
- We're using [SASS functions](http://sass-lang.com/documentation/Sass/Script/Functions.html) like `darken()` to programmatically define values. In this case, that means if we change the `$link-color`, `a`s and `button`s will _automatically_ use a slightly darker version of that color when we hover over them.

---

## The two versions of SASS

There are two actually two versions of SASS. The recommended version, which you saw in the previous example, is `.scss`. For people who hate semi-colons and curly braces, there's also `.sass`.

Literally the only difference is you leave out semi-colons and curly braces. Instead, new lines and indentation is significant. It looks like this:

```
$link-color: dodgerblue
$link-hover-color: darken($link-color, 15%)

a
  color: $link-color

  &:visited
    color: $link-color
  &:hover
    color: $link-hover-color
  &:active
    color: $link-hover-color

$button-bg: $link-color
$button-hover-bg: $link-hover-color
$button-color: white

button
  background: $button-bg
  color: $button-color

  &:hover
    background: $button-hover-bg
```

The version you use is up to you.

---

## Setting up SASS in Sinatra

You're going to love how easy this is.

First, __add this line to your `Gemfile`__:

``` ruby
gem 'sass'
```

That defines the `sass` gem as a dependency in our project. Now to install that dependency, __`cd` into the directory of your Sinatra project and run `bundle install`__.

Now in `config.ru`, we need to tell `Rack` (the webserver interface Sinatra uses) that we want to write some SASS. __Add these two lines to `config.ru` _before_ the line to run your app__:

``` ruby
require 'sass/plugin/rack'
use Sass::Plugin::Rack
```

Now __create this folder structure: `public/stylesheets/sass`__. You can do this through your file manager if you like, or from your project directory in the terminal with:

```
mkdir -p public/stylesheets/sass
```

You should remember the `public` folder as where we put static assets in a previous project. The other folders are where the `sass` gem will look by default. It expects all your `.scss` or `.sass` files to be in the `sass` folder. When it finds them, it'll automatically process them into `.css` files in the `stylesheets` folder.

Try that on the previous Sinatra project now to make sure it's working. Don't forget the `link` element pointing to the generated `.css` file in the `head` of your layout file! And if you want some dummy `SCSS` just to make sure it's working, try this:

```
$body-bg: orange;

body {
  background-color: $body-bg;
}
```

---

## Diving into the features of SASS

I highly recommend reading through [this article](https://scotch.io/tutorials/getting-started-with-sass#variables) for an overview of how to use SASS, __starting with the _Variables_ section and stopping before _Function Directives___, as it's a bit more advanced than we want to get into right now.

It's also a good idea to click on every `Play with this gist on SassMeister` link. They'll allow you to play around with an example of each feature, to make sure you understand how it works.
