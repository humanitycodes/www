## Models: how we think about and save information in our app

Rails is often referred to as an "MVC framework" - meaning it's a web framework that organizes code into __M__odels, __V__iews, and __C__ontrollers. We've used views. That's where we keep our HTML. And we've used controllers. That's where we organize our actions - where we run some code _before_ rendering our view and where we decide _which_ view to use.

But what about __models__? Well, each model is a kind of _thing_ we want to save information about in our app. For example, Twitter will save information about users and tweets. Email services will need to save information about users, emails, attachments, and contacts. We'll have a model for each of these that defines which details we want to keep track of in our database.

To better wrap our heads around this, let's walk through a complete, hypothetical model for blog posts. As we do, it'll be helpful to have a dummy app you can play around with now and delete afterwards. Go ahead and create that now in your Code Lab directory:

``` bash
rails new models_practice --skip-test-unit
```

---

## What's in a post?

The first step to defining a new model is figuring out which information we want to keep track of. Thinking about this, we realize that for each post, we might want to save:

- the title
- the content
- whether it's published or not

And now to give these more Ruby-friendly names, where each word is separated by an underscore:

- `title`
- `content`
- `is_published`

Great! Now that we know what kind of information we want to keep track of, let's take a tour of some of the most common data types we have available in Rails.

<div class="callout callout-info text-muted">

  <h4>Note</h4>

  <p>Although it's certainly not necessary for this lesson, if you happen to have experience working directly with databases, note that these general types correspond to more specific types in specific databases. Since implementations vary between databases, the advice I give will not be universally true. Instead, I'll be assuming you're using PostgreSQL, which is a popular and very powerful open source database.</p>

  <p>This is also not [a complete list of data types available](http://stackoverflow.com/questions/17918117/rails-4-datatypes#answer-22725797), but rather a simplified list of the most common types.</p>

</div>

OK, let's dive in.f

<hr>

### `string` and `text`

The `string` type is for shorter text (typically less than 255 characters), such as names and email addresses, while the `text` type is for longer text, such as blog posts or comments.

The main practical difference (assuming you're using PostgreSQL) is that by default, Rails will display an `<input type="text">` for `string` and a `<textarea>` for `text`.

### `boolean`

The `boolean` type is for something that can be either true or false, such as whether a todo item is complete or whether a blog post is published. In fact, if your description of the attribute starts with _whether_, it's a safe bet that should be boolean.

### `integer` and `decimal`

The `integer` type is useful for - you guessed it - integers. This may include the number of an item you have in stock, a shoe size, or a counter for how many times a video has been viewed.

The `decimal` type is useful for real numbers, such as for money, longitude/latitude, or exact temperature.

### `date`, `time`, and `datetime`

The `date` type stores a date, the `time` type stores a time, and the `datetime` type stores both together. Pretty self-explanatory.

<hr>

Now let's go back to our data for blog posts and figure out which Rails data types we want to use.

- `title` will be shorter text, so the `string` type is probably most appropriate
- `content` will be longer text, so let's use the `text` type there
- `is_published` will only either be `true` or `false`, so `boolean` fits perfectly

---

## Generating a scaffold for our model

Now we've defined:

- our model,
- which information we want to keep track of for that model,
- and the Rails data types we want to use for each piece of information

So... what's next? Believe it or not, the hard part is over! Remember that nifty generator we used to create all the files and lines we'd need for a new controller? Well, we're going to use another generator, this time to create a __scaffold__.

A scaffold is "a full set of __model__, __database migration__ for that model, __controller__ to manipulate it, __views__ to view and manipulate the data, and a test suite for each of the above."[*](http://guides.rubyonrails.org/command_line.html) We're not using a test suite this time (remember `--skip-test-unit` when we ran `rails new`?), but we'll get everything else, all with this one terminal command:

``` bash
rails generate scaffold Post title:string content:text is_published:boolean
```

Notice that for each post attribute, we're attaching a data type with a colon. That colon can be read as "of type" (e.g. our `Post` has a `title` of type `string`, `content` of type `text`, etc).

Now let's run that command and check out the output:

``` output
invoke  active_record
create    db/migrate/20150311150401_create_posts.rb
create    app/models/post.rb
invoke  resource_route
 route    resources :posts
invoke  scaffold_controller
create    app/controllers/posts_controller.rb
invoke    erb
create      app/views/posts
create      app/views/posts/index.html.erb
create      app/views/posts/edit.html.erb
create      app/views/posts/show.html.erb
create      app/views/posts/new.html.erb
create      app/views/posts/_form.html.erb
invoke    helper
create      app/helpers/posts_helper.rb
invoke    jbuilder
create      app/views/posts/index.json.jbuilder
create      app/views/posts/show.json.jbuilder
invoke  assets
invoke    coffee
create      app/assets/javascripts/posts.coffee
invoke    scss
create      app/assets/stylesheets/posts.scss
invoke  scss
create    app/assets/stylesheets/scaffolds.scss
```

Some of these should look familiar from the last lesson, though some will not. Once again, we'll take a tour of the files we just generated to better understand what each one does and how they interact with each other.

---

### The database migration

``` output
create    db/migrate/20150311150401_create_posts.rb
```

Oh, a new kind of file, in a `db/migrate` folder! The `db`, in this case, stands for _database_ and `migrate` is a fancy term for _making a change_ to our database.

Taking a look inside that file, we'll see something like this:

``` ruby
# db/migrate/20150311150401_create_posts.rb
class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.boolean :is_published

      t.timestamps null: false
    end
  end
end
```

This __database migration__ describes the changes we'll be making to our database. In this case, we're creating a "posts" __table__ with all the __columns__ we want to store data for.

You'll also notice that Rails added a line for timestamps. This creates two additional columns, `created_at` and `updated_at`, that are automatically filled in by Rails whenever we create or update a __record__.

There's a lot of new language here: tables, columns, and records. Fortunately, it's not as complicated as it sounds. You can think of a table as a spreadsheet, each column an actual column in that spreadsheet, and each record as a row, like this:

<table class="table table-striped">
  <thead>
    <tr>
      <th colspan="4" class="text-center">POSTS</th>
    </tr>
    <tr>
      <th>title</th>
      <th>content</th>
      <th>is_published</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>"10 cutest cats"</code></td>
      <td><code>"Here are a list of cats..."</code></td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td><code>"1 weird trick"</code></td>
      <td><code>"All you have to do is..."</code></td>
      <td><code>true</code></td>
    </tr>
    <tr>
      <td><code>"TODO: Think of title"</code></td>
      <td><code>"Super inspiring content..."</code></td>
      <td><code>false</code></td>
    </tr>
  </tbody>
</table>

Also note that while it's not listed here, __Rails will also give every record an `id` column, allowing us to uniquely identify each record__. It will automatically give our first post an `id` of 1, then second an `id` of 2, etc.

---

## How Rails and the database talk about information

Let's stop for a moment and clarify some more language.

When I first started using Rails, something that confused me was that tables and models seemed to be the same thing. But when talking about a Ruby file, I'd describe my "Post table" and people would correct me - "You mean model?" And I would ask, "Wait, don't I have a Post table?" And they'd say, "You _do_, but in this case, you're talking about your model."

Here's the distinction: __"table" describes how information is organized in the database, whereas "model" describes the Ruby we use to interact with that table__. That might not click right at this moment, but it doesn't have to. What you _do_ have to understand is this:

__When we're working in a database migration or writing SQL (the language of the database), we'll use database words (like "table"). Everywhere else in our app, we'll typically use Rails' language (like "model").__

And just as tables corresponds to models, columns correspond to attributes:

<table class="table">
  <thead>
    <tr>
      <th>Database</th>
      <th>Rails</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Table</td>
      <td>Model</td>
    </tr>
    <tr>
      <td>Column</td>
      <td>Attribute</td>
    </tr>
  </tbody>
</table>

---

## Modifying our migration

Back to our migration file!

So what Rails generated is pretty good, but let's modify this file a little to better represent how our post should behave. We'll figure out how to modify it by asking this one question: __Will there ever be a case when the value of one of these columns should be `null` (i.e. N/A)?__

Often, the answer is no. In the case of our `title` and `content`, these might be _empty_, but they'll never be _non-existent_ for most blogs. Likewise, `is_published` should never be _nothing_. Rather, it should start out as `false`.

If we had a `published_at` column, which stored a `datetime` of when the post was published, sometimes that _would_ `null`. If a post hasn't been published yet, asking the question, "When was it published?" doesn't have an answer.

But for all three of our current column, we can better describe them with these two parameters: `null: false` and `default: ...`. Check out how I've modified the migrations below:

``` ruby
# db/migrate/20150311150401_create_posts.rb
class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string   :title,        null: false, default: ''
      t.text     :content,      null: false, default: ''
      t.boolean  :is_published, null: false, default: false

      t.timestamps null: false
    end
  end
end
```

`null: false` means that column's value should never be `null`. `default: ...` defines what we want the default starting value to be.

And that's it. Our migration is complete!

__Now for a database migration to actually go in and change our database, we need to run `rake db:migrate` in the terminal.__ Go ahead and do that now. The command should return something like this:

``` output
== 20151216165354 CreatePosts: migrating ======================================
-- create_table(:posts)
   -> 0.0041s
== 20151216165354 CreatePosts: migrated (0.0042s) =============================
```

---

## You're done!

Hey, what's that skeptical look for? Oh, you can see there are quite a few pages to go, right? Don't worry about that. We'll get to the other generated files in a second.

First, let's enjoy the fruits of our labor so far. Fire up your server with `rails server`, then visit `localhost:3000/posts` in your web browser. Do you see a "New Post" link? Click on it!

Fill out the form to create a new post. After you do so, checking back at [the `/posts` page](http://localhost:3000/posts), you should see that any posts you created have been saved to the database!

Now even though we won't necessarily be changing anything else, let's browse through the other files to see how they're contributing to making this magic happen.

---

## The model

``` output
create    app/models/post.rb
```

``` ruby
# app/models/post.rb
class Post < ActiveRecord::Base
end
```

It doesn't look like much. It's an empty `Post` class that _inherits from_ (`<`) `ActiveRecord::Base`. Inheriting from `ActiveRecord::Base` gives our humble `Post` some super powers, allowing us to access information in our database and save new information, all from Ruby.

We won't get into them now, but you can already see some of it in `app/controllers/posts_controller.rb` whenever you see __Post._something___.

---

## The routes

``` output
route    resources :posts
```

``` ruby
# config/routes.rb
resources :posts
```

What? That's it? This is another line that's more powerful than you might think. If you run `rake routes` in your terminal, you'll see that this one line has single-handedly created _eight_ routes.

``` output
   Prefix Verb   URI Pattern               Controller#Action
    posts GET    /posts(.:format)          posts#index
          POST   /posts(.:format)          posts#create
 new_post GET    /posts/new(.:format)      posts#new
edit_post GET    /posts/:id/edit(.:format) posts#edit
     post GET    /posts/:id(.:format)      posts#show
          PATCH  /posts/:id(.:format)      posts#update
          PUT    /posts/:id(.:format)      posts#update
          DELETE /posts/:id(.:format)      posts#destroy
```

<div class="callout callout-info text-muted">

  Note

  <p>You can [learn more about the command here](http://guides.rubyonrails.org/routing.html#resources-on-the-web), if you're curious. Otherwise, we'll be diving into it more deeply in a later lesson.</p>

  <p>It's also worth noting that the routes generated by the `resources` command are said to be __RESTful__. REST stands for Representational State Transfer. I know. That doesn't clarify anything, does it? If you want to dive into REST, I recommend checking out [this discussion on Stack Overflow](http://stackoverflow.com/questions/671118/what-exactly-is-restful-programming). I only mention it now because you're likely to hear this acronym a lot.</p>

</div>

Otherwise, you can just remember for now that it's The Right Way to build out routes for a model in your database. If you're not using the `resources` command for a model, you're probably doing it wrong.

---

## The controller

```
create    app/controllers/posts_controller.rb
```

Wow, we have a whopping 74 lines generated for us in our new posts controller. That's too much to even show here, so go check it out now in your own text editor.

This file defines all the actions that our routes point to. And guess what? We get not only HTML endpoints, but also JSON endpoints. You hear that? We just got a free API! If that doesn't mean anything to you, that's OK. It will when it matters.

A lot of other stuff is going on in this file too, but guess what? You don't have to understand it all yet.

---

## The HTML views

```
create      app/views/posts
create      app/views/posts/index.html.erb
create      app/views/posts/edit.html.erb
create      app/views/posts/show.html.erb
create      app/views/posts/new.html.erb
create      app/views/posts/_form.html.erb
```

We have a view for the:

- index action, to list posts
- edit action, to show a form for a single, existing post
- show action, to show information for a single post
- new action, to show a form for a single, new post

And we also have a view __partial__ (`_form.html.erb`). Partials always start with an underscore and contain view code that isn't tied to a specific action. Instead, it's rendered into one or more views with a `render` helper, like this:

``` html
<%= render 'form' %>
```

Partials are useful for DRYing up your view code or to make it more modular. In this case, the `_form.html.erb` partial is rendered in the views for both the `new` and `edit` actions, since both of them need the same form.

---

## The JSON views

```
create      app/views/posts/index.json.jbuilder
create      app/views/posts/show.json.jbuilder
```

JSON? Huh? You can go right ahead and skip this page if you want, as you won't have to know anything about JSON for quite a while.

But... if you're curious, JSON stands for "JavaScript Object Notation". It's a special format that webapps often use to talk to _each other_ and to _themselves_. It looks like this:

``` json
[{"id":1,"title":"Test","content":"post content","is_published":false,"url":"http://localhost:3000/posts/1.json"}]
```

These two files set up what JSON will be shown for the `index` and `show` actions. They're in a new format you haven't seen before, called [`jbuilder`](https://github.com/rails/jbuilder). You don't have to worry too much about it for now.

---

## The helpers

```
create      app/helpers/posts_helper.rb
```

Just like the helper that was created for our static controller, it starts out empty.

---

## The assets

```
invoke  assets
invoke    coffee
create      app/assets/javascripts/posts.coffee
invoke    scss
create      app/assets/stylesheets/posts.scss
invoke  scss
create    app/assets/stylesheets/scaffolds.scss
```

Once again, we have a file for JavaScript and SCSS for posts, but we also have one other file: `scaffolds.scss`. This file just provides some basic styling to make your app look a little less ugly by default. Once I start adding my own styling, I always delete it.

---

## Deploying to Heroku

The only thing we have to keep in mind for Heroku is that just like we had to run a command to migrate our database locally, we'll have to run a command to migrate our database _after we deploy_.

You can run commands on your Heroku app with `heroku run`. In this case, we'll use:

``` bash
heroku run rake db:migrate
```
