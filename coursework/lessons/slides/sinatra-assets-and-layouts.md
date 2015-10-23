## Being lazy with HTML, CSS, and JavaScript

Let's say you have an app with 10 different pages. You want every page to have the title `My Awesome App` and a background color of `lightgray`. To accomplish this right now, we'd have to include the code below in _all 10 pages_, which also means that if you decided to change one of these details, you'd have to make the change 10 times!

``` html
<!DOCTYPE html>
<html>
  <head>
    <title>My Awesome App</title>
    <style>
      body {
        background-color: lightgray;
      }
    </style>
  </head>
  <body>
    <!-- CODE THAT'S DIFFERENT -->
  </body>
</html>
```

That's pretty annoying. And it's easy to make a mistake and accidentally miss one page or mistype something.

So in programming, there's an acronym people throw around a lot: DRY. It stands for Don't Repeat Yourself. When someone says, "let's DRY this up", they mean they want change the code to allow you to reuse it, rather than repeating the same code over and over again.

As a general rule, __when changing one line of code would always force you to  change identical code, you want to find a way to only write that code only once__. And Sinatra gives us lots of ways to do that.

---

## Including external `css`, `js`, and font files

With CSS and JavaScript, we've already learned about a way to avoid repeating ourselves, and at the same time, better organize our app.

For CSS, we can add `link` element to the `head`:

``` html
<link rel="stylesheet" href="/css/main.css" media="screen" charset="utf-8">
```

And for JavaScript, we can add a `script` element as the last item in our `body`:

``` html
<script src="/js/main.js" charset="utf-8"></script>
```

The problem is, Sinatra has some security to keep random visitors from seeing your source code. That's great, but it means web browsers won't be able to find a `css/main.css` or `js/main.js` file in the root of our app.

To get around this, you can create a special folder called `public`. Then any files in the `public` folder will be shown to the world. So in order for the `link` and `script` elements above to work, we'll need to put our files in that folder, like below:

```
public
|-- css
    |-- main.css
|-- js
    |-- main.js
```    

And that's it! Anything in `public` will be served to the root of your app.

---

## DRYing up HTML

What about that pesky HTML though? We've avoided having to write the same CSS and JavaScript on every page, we still have this in all 10 pages:

``` html
<!DOCTYPE html>
<html>
  <head>
    <title>My Awesome App</title>
    <link rel="stylesheet" href="/css/main.css" media="screen" charset="utf-8">
  </head>
  <body>
    <!-- CODE THAT'S DIFFERENT -->
    <script src="/js/main.js" charset="utf-8"></script>
  </body>
</html>
```

Fortunately, Sinatra gives us a way to very quickly solve this problem. We can put all the code that's the same in a `views/layout.erb` file and where we have code that's different, we'll simply `yield` to the file for that page, like so:

``` erb
<!DOCTYPE html>
<html>
  <head>
    <title>My Awesome App</title>
    <link rel="stylesheet" href="/css/main.css" media="screen" charset="utf-8">
  </head>
  <body>
    <%= yield %>
    <script src="/js/main.js" charset="utf-8"></script>
  </body>
</html>
```

So then in other view files, all I have to do is page-specific code and it will replace `<%= yield %>` in the layout file when it renders.

For example, if I have a `home.erb` file that looks like this:

``` html
<p>This is my homepage! WAHH!!!</p>
```

Then when it actually renders, the resulting HTML will be:

``` html
<!DOCTYPE html>
<html>
  <head>
    <title>My Awesome App</title>
    <link rel="stylesheet" href="/css/main.css" media="screen" charset="utf-8">
  </head>
  <body>
    <p>This is my homepage! WAHH!!!</p>
    <script src="/js/main.js" charset="utf-8"></script>
  </body>
</html>
```

So much cleaner!
