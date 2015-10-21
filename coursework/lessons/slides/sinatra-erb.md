## Serving an HTML file

Instead of just serving text, it's useful to be able to serve actual HTML files. But plain old HTML files are boring. They're always the same. To spice things, up we'll use HTML files with Embedded Ruby, which are called `erb` files.

Sinatra provides a simple way to use `erb` files, but it also has a single rule: it expects all `erb` files to be in a `views` folder in your project directory. To play around, try jumping into the project for the last lesson and creating an `erb` file at `views/index.erb`, with this content:

``` html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>The Year Machine</title>
  </head>
  <body>
    <p>The current year is <%= Time.now.year %>.</p>
  </body>
</html>
```

It's a simple HTML file that announces the current year, similar to the last project. But in this case, it's enhanced by Ruby. Any Ruby we want in the file will be in between `<%=` and `%>`, then the _result_ shows up on the page. So:

```
<p>The current year is <%= Time.now.year %>.</p>
```

becomes:

``` html
<p>The current year is 2015.</p>
```

And you can embed as much Ruby as you want!

Now to return this file when a user visits our homepage, we'll change our `app.rb` to include this code:

``` rb
get '/' do
  erb :index
end
```

`erb :index` means "get a file in a `views` folder called `index.erb`, run any Ruby inside of it, then return the resulting HTML." The colon before `index` makes it a "symbol" - and all you need to know for now, is symbols are often used in Ruby when we want to reference something else - like a file, in this case.

Now run your app with `bundle exec rackup` and see if this works the way you expect. When you want to shut down that web server to get back your terminal, you can hit `Ctrl`+`C` (`C` standing for "cancel" in this case).

---

## Goodbye `index.html`!

Remember how we used to name pretty much every file `index.html`. That was annoying, huh? Well guess what? We can now use whatever name we want - though underscores should be used instead of spaces.

To celebrate, let's rename our `index.erb` to something like `home.erb` and then we'll change:

``` ruby
get '/' do
  erb :index
end
```

to:

``` ruby
get '/' do
  erb :home
end
```

And while we're at it, let's create an `about.erb` file as well, for our About page. Once again, this will be in our `views` directory. Then in `app.rb`, we can specify:

``` ruby
get '/about' do
  erb :about
end
```

Now run `bundle exec rackup` again to make sure this is working.

---

## HTML forms + ERB = "mad" interactivity



``` html
<form>
  Animal
  <input name="animal"><br>
  Adjective
  <input name="adjective"><br>
  Body Part
  <input name="body_part"><br>
  Verb
  <input name="verb"><br>
  Place
  <input name="place"><br>
  Holiday
  <input name="holiday"><br>
  <button type="submit">Generate Madlib</button>
</form>
```

That will generate a form that looks like this:

![Mad Libs form](https://www.dropbox.com/s/42ts7o59p6s3mq9/Screenshot%202015-10-21%2012.21.31.png?dl=1)

Each `input` has a `name` attribute so that we have a way of referring to it in our code. When a user is done filling everything out, they can click on the "Generate Madlib" button to submit the form and we'll be able to use what they typed in with ERB.

So let's do that now. Right underneath the form, I'm going to add my story, with embedded Ruby filling in many of the blanks:

```
<p>Once upon a time, there was a <%= params['animal'] %> with a very <%= params['adjective'] %> <%= params['body_part'] %>. It lived far from home, so every year, it had to <%= params['verb'] %> all the way to <%= params['place'] %> to see its family at the big <%= params['holiday'] %> festival.</p>
```

The values from the form inputs are stored in what's called a variable called `params` (short for parameters). And `params` is a `hash`. Hashes work just like dictionaries. In a dictionary, you look something up and you get back a definition. In a hash, you look up a `key` and you get back a `value`. In `params['animal']`, for example, `'animal'` is the key and the value returned will be whatever the user entered, like "giraffe", "dog", or "space zebra".

Sinatra makes our lives easier by automatically putting _anything_ submitted in a form inside the `params` hash.

Try this out in your app to make sure it works.

---

## Submitting our form to a different page

OK, so one thing I don't like about our app right now is that users can see the story while they're filling out the form. Normally in Mad Libs, you _can't_ see the story, which makes the end result more ridiculous. And the more ridiculous, the better!

So I'm going to keep the form in my `home.erb` file, but I'll create a new file called `story.erb` and _that's_ where the story will live. But now I need to send information from the `home.erb` file to the `story.erb` file.

Fortunately, HTML makes this pretty easy for us. We just have to add an `action` attribute to our opening `form` tag:

``` html
<form action="/story">
```

And then in `app.rb`, we'll point `/story` to `views/story.erb` with:

``` ruby
get '/story' do
  erb :story
end
```

And while I'm in this file, I actually want to rename `home.erb` now, since it has a more specific purpose. So let's update:

``` ruby
get '/' do
  erb :home
end
```

with:

``` ruby
get '/' do
  erb :generator
end
```

And then I'll rename `home.erb` in `views` to `generator.erb`. Since I've just changed a Ruby (`.rb`) file, I'll have to restart my app now. So I'll `Ctrl`+`C` and then rerun `bundle exec rackup`.

So now, whenever I submit the form at `/`, I should be redirected to `/story`, where values from the form will fill out the blanks in my story. And guess what? As an added bonus, all the information a user submits in the form is saved in the URL:

```
http://localhost:9292/story?animal=space%20zebra&adjective=disturbed&body_part=ankle&verb=elope&place=Zebranzibar&holiday=St.%20Patrick%27s%20Day
```

So they can copy and paste that link to share the zaney results with their friends!
