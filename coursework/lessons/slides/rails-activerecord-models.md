## Exploring your app in the Rails console

Remember `app/models/post.rb` in the previous lesson? It looked like this:

``` ruby
class Post < ActiveRecord::Base
end
```

At first glance, it doesn't seem to have much going on - but looks can be deceiving. These two lines give us the ability to interact with the `posts` table in our database.

We'll explore this ability with a new tool: the Rails console. It's like the interactive Ruby (IRB) console we've used before, but it loads up our app as well. You can access it in the terminal by `cd`ing into the directory for your last project, then running:

``` ruby
rails console
```

You should see something like:

``` output
Loading development environment (Rails 4.2.5)
irb(main):001:0>
```

Try entering `2 + 2`. Did you get this?

``` output
=> 4
```

If you did, then try:

``` ruby
Rails.application.class.parent_name
```

Did you get back something like this?

``` output
=> "RailsDatabaseIntro"
```

If so, everything's working! Just like with `irb`, you can get back to your normal terminal at any time with by entering `exit`.

---

## Interacting with the database through your model

Now for the fun part. If we want to create a new post in the Rails console, it's as simple as:

``` ruby
Post.create(title: '10 best cats', content: 'list of cats...')
```

If you run that (or the equivalent for your own model), you should see something like this:

``` output
   (0.2ms)  begin transaction
SQL (0.5ms)  INSERT INTO "posts" ("title", "content", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "10 best cats"], ["content", "list of cats..."], ["created_at", "2015-12-21 05:53:18.450963"], ["updated_at", "2015-12-21 05:53:18.450963"]]
   (4.0ms)  commit transaction
=> #<Post id: 2, title: "10 best cats", content: "list of cats...", is_published: false, created_at: "2015-12-21 05:53:18", updated_at: "2015-12-21 05:53:18">
```

That's Rails telling the database to create a new post, then some "SQL" (Structured Query Language) is run to insert a new record into the `posts` table. SQL is the language that many databases use, but don't worry - you don't need to know any SQL right at this moment. Rails is writing the SQL to talk to the database _for you_!

Now let's try to pull up that last post we just created:

``` ruby
Post.last
```

That should return:

``` output
  Post Load (2.4ms)  SELECT  "posts".* FROM "posts"  ORDER BY "posts"."id" DESC LIMIT 1
=> #<Post id: 1, title: "10 best cats", content: "list of cats...", is_published: false, created_at: "2015-12-21 05:53:18", updated_at: "2015-12-21 05:53:18">
```

You can see that it pulled up the post with all its attributes. And if we want a specific attribute, we can run:

``` ruby
Post.last.title
```

which should return:

``` output
=> "10 best cats"
```

And this is just the start. Here are some other common commands to interact with the database.

``` ruby
Post.all
# returns a list of all posts

Post.order(created_at: :desc)
# returns a list of all posts, listed in descending order by when they
# were created (i.e. showing most recently created posts first)

Post.count
# returns the number of posts in our database

Post.pluck(:title)
# returns a list of all post titles

Post.first
# returns the first created post

Post.last
# returns the last created post

Post.last.destroy
# deletes the last created post

Post.find_by(title: '10 best cats')
# returns the first post found with a title of "10 best cats"

Post.where(is_published: false)
# returns a list of all unpublished posts
```

It gets especially powerful when you chain methods together. For example, here's how you can find all the published posts, in descending order of when they were created.

``` ruby
Post.
  where(is_published: true).
  order(created_at: :desc)
```

This is by no means a complete list of methods available, but you can [skim the rest of them here](http://guides.rubyonrails.org/active_record_querying.html).

---

## A little SQL can go a long way

Every database uses a slightly different flavor of SQL, but there's a _very tiny_ amount of pretty generic SQL you can use for even more powerful queries.

Let's take this line for example:

``` ruby
Post.where(is_published: true)
```

It's actually a shorter version of this:

``` ruby
Post.where('is_published = ?', true)
```

And you see that string in the first parameter? _That's_ some SQL. It's checking if the `is_published` column `=` (i.e. is equal to) `?`. The `?` is a stand-in for our second parameter, `true`. So in total, it's getting all the posts where `is_published` is equal to `true`. Not so scary, eh?

<div class="callout callout-warning">

  <h4>Note</h4>

  <p>In Ruby and most other programming languages, `=` is an _assignment_ operator, which means it's used to change the value of a variable. It sets the variable to the left of the `=` to the value of whatever's to the right of it. In contrast, `==` is a more typical _equality_ operator.</p>

  <p>Just... not in SQL. SQL is the very rare language that has no assignment operator, so uses `=` for its equality operator.</p>

</div>

Here's a list of generic SQL comparison operators:

<table class="table table-striped">
<thead>
  <tr>
    <th>Operator</th>
    <th>Meaning</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td><code>=</code></td>
    <td>is equal to</td>
  </tr>
  <tr>
    <td><code>&lt;</code></td>
    <td>is less than</td>
  </tr>
  <tr>
    <td><code>&lt;=</code></td>
    <td>is less than or equal to</td>
  </tr>
  <tr>
    <td><code>&gt;</code></td>
    <td>is greater than</td>
  </tr>
  <tr>
    <td><code>&gt;=</code></td>
    <td>is greater than or equal to</td>
  </tr>
  <tr>
    <td><code>!=</code></td>
    <td>is not equal to</td>
  </tr>
</tbody>
</table>

These operators can allow you to do more than just check for equality, which is pretty common. For example, let's say there's a post I was working on some time in the last week. I can bring up all the posts created _after_ (i.e. greater than) a week ago with:

``` ruby
Post.where('updated_at > ?', 1.week.ago)
```

Or maybe I have a goal to write 10 posts every month and so as a motivational tool, I want to display the number of posts I've created and published since the beginning of the month. I can get that number with:

``` ruby
Post.
  where(is_published: true).
  where('created_at > ?', Time.now.beginning_of_month).
  count

# I've spread this out across multiple lines to make it easier
# to see the individual methods being called. I'll often do this
# in real code too, to make it more easily readable.
```

I might also decide that any post I haven't published or even _touched_ in 2 years is probably a post that realistically, I'll never actually finish. I could find and delete all those posts with something like:

``` ruby
Post.
  where(is_published: false).
  where('updated_at < ?', 2.years.ago).
  destroy
```

__SQL also has `AND` and `OR` operators.__ Let's say I wanted to find all the unpublished posts that have a blank title _or_ blank content. This would do the trick:

``` ruby
Post.
  where(is_published: false).
  where('title = ? OR content = ?', '', '')
```

Notice also that for each `?`, I need to include a new parameter.

---

## Implementing a simple text search for an `index` action

There's one other very common use case you might want to use some SQL for: searching your database using text a user entered in a search box.

Let's say I've been doing really well on my 10 posts per month goal and now I have hundreds of blog posts. Many of my readers have requested a search box to help them find older posts. The simplest way is to do something like this is with `LIKE` and `LOWER`:

``` ruby
title_search = 'Cat'
Post.where('LOWER(title) LIKE LOWER(?)', "%#{title_search}%")
```

Here, I'm comparing a lowercased version of the title with a lowercased version of the search query, which in this case, is `"cat"`.

You'll also notice that in the second parameter, I've included a `%` on other side of my query. Those are wildcard operators and they're saying there may be some text _before_ our query and there may be some text _after_ it.

If we don't include those, `LIKE` will behave just like `=`. One major difference between `LIKE` and `=` is that `LIKE` supports wildcards, whereas `=` is only for finding _exact_ equality.

<div class="callout callout-info text-muted">

  <h4>Note</h4>

  <p>You may find people on the Internet warning that `LIKE` is very slow, so should be used with caution. That's true, but "very slow" is very relative in databases designed to handle many millions of records per table.</p>

  <p>Let's say you've written a whopping 50,000 blog posts, which is 1 post per day for about 137 years. But somehow, you managed it. And your blog is more popular than ever, because everyone wants to know the secret to your longevity. Even in this case, running this search with `LIKE` might take about 100 milliseconds (1/10th of a second), which isn't too bad.</p>

  <p>So until you start working at a very large scale, either in records or users, or you actually _notice_ that it's slow...</p>

  <img src="https://www.dropbox.com/s/pxo0a3e5xzrhrwq/Screenshot%202015-12-21%2014.27.57.png?dl=1" alt="Don't worry about it">

</div>

Now let's get out of the Rails console and start changing our app's files to implement this search feature. First, we'll add a search box somewhere on our index page, using [Rails' form tag helpers](http://api.rubyonrails.org/classes/ActionView/Helpers/FormTagHelper.html):

```
<!-- app/views/posts/index.html.erb -->
<%= form_tag posts_path, method: :get do %>
  <%= text_field_tag :title_search, params[:title_search] %>
<% end %>
```

<div class="callout callout-info text-muted">

  <h4>Note</h4>

  <p>Wait... why couldn't we just write that out in HTML? Why are we learning new Rails helpers to generate HTML that we _already_ know how to write? Aren't we adding an unnecessary step?</p>

  <p>That's what I thought too, when I first started using Rails. But there _are_ a few good reasons:</p>

  <ul>
    <li>Rails will add a hidden field (`authenticity_token`) to certain forms for security purposes, automatically protecting you from attacks you didn't even know were possible.</li>
    <li>The aforementioned security feature also protect against some forms of spam.</li>
    <li>Rails will add another hidden parameter (`utf8`) to enforce standard text encoding, which solves some cross-browser compatibility issues.</li>
    <li>As the web evolves and new security threats and best practices arise, all you'll have to do is update your version of Rails to take advantage of them.</li>
  </ul>

  <p>There are a lot of form helpers, but __you do not have to memorize them__. As you're building forms, you can just look up helpers [on this page](http://api.rubyonrails.org/classes/ActionView/Helpers/FormTagHelper.html) as you need them.</p>

</div>

OK, so we're halfway done! Now to update our `index` action in `posts_controller.rb`:

``` ruby
# app/controllers/posts_controller.rb
def index
  if params[:title_search].present?
    @posts = Post.
      where(is_published: true).
      where('LOWER(title) LIKE LOWER(?)', "%#{params[:title_search]}%").
      order(created_at: :desc)
      # returns all the published posts where the value of
      # `params[:title_search]` case-insensitively matches the
      # title of the post, with results listed in descending
      # order by when they were created (i.e. showing most
      # recently created posts first)
  else
    @posts = Post.all
  end
end
```

If a search query is present (i.e. has been submitted in the form), we run a search and store the results in `@posts`. Otherwise, we just store all the posts in `@posts`. That's all you need to add a great search feature.

Now you have the rest of the day to figure out how to look busy.

![Practicing your urgent-looking walk](http://i.imgur.com/6SvPK6L.jpg)
