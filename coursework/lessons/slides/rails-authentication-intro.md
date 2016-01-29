## What is authentication and authorization?

Almost every application will have the ability for users to create accounts, sign in, sign out, reset their password - things like that. __The ability to recognize individual users is authentication.__ On its own, that's not very useful though. __Authorization is when we use our ability to identify individual users to decide who gets to do what in our app.__

So why are these important?

Well, the idea of anyone on the Internet being able to add, change, and delete _anything_ in our database is... frightening. What if you spent a week entering in records for all 649 pokémon in the best pokédex ever created, only to discover that someone came by and just deleted _everything_ one day?

Or what if you created a social network - like a Facebook for [ninja turtle cosplayers](https://www.google.com/search?q=ninja+turtle+cosplay&tbm=isch). If any turtle could post as any other turtle and see everyone else's information, they'd probably all quit the service.

### The solution

To solve this problem, we need a `User` model. Then we need the ability to control who can be a user, what users can do, and what non-users (or guests) can do. That's what we'll be implementing now.

---

## Authentication from scratch vs authentication gems

There are many popular gems for Rails, such as [`devise`](https://github.com/plataformatec/devise), which can help you get an authentication system up and running very quickly, including _Forget your password_ links, email confirmations, and everything else you're used to when signing up for a new web service.

When you need to get a full-featured authentication system up and running quickly, `devise` is a fantastic option. It has great documentation and continues to be refined based on the latest security best practices.

The problem is, when you've never built an authentication system before, a gem like that can be a little overwhelming when you want something _a little_ different. And we do. We want to turn our blogging platform into an exclusively club, where only people we authorize can have an account and post content.

Building this from scratch will help us learn much more about how authentication works - and is actually less complicated than you might think.

---

## Managing passwords

First, we need a gem that will allow us to securely store passwords. Fortunately, Rails _sort of_ comes with an excellent gem for this.

### Installing `bcrypt`

Let's head over to our `Gemfile` and uncomment this line (you can comment/uncomment lines in Atom with `Cmd`+`/` in OS X or `Ctrl`+`/` in Windows or Linux):

``` ruby
# gem 'bcrypt', '~> 3.1.7'
```

It should now look like this:

``` ruby
gem 'bcrypt', '~> 3.1.7'
```

<div class="callout callout-info">

  <h4>Note</h4>

  <p>If the version number is a higher than `3.1.7`, that's OK. That just means you're reading this lesson _from the future_ and have a version that's been updated for the latest security concerns!</p>

</div>

Now run `bundle install --without production` to install it. We'll see what this gem has given us when we create our `User` model.

### Creating our `User` model

We can create our model with Rails' model generator:

```
rails generate model User email:string password:digest
rake db:migrate
```

Note that we're using a new data type for the `password` called `digest` (provided by `bcrypt`). A digest is just an encrypted version of the password. This will allow us to check if a user's password is correct, _without_ actually knowing what it is. That means if we get a disgruntled employee or are hacked, our users' password information will remain quite safe.

### Testing out our password encryption

Now we have a `User` model, but there’s no way for the outside world to create and destroy users. We however, are mighty developers! We don't need no stinkin' front-end. Let's open up the `rails console` in the terminal:

```
rails console
```

Now let's create a new user:

``` ruby
User.create(email: 'hello@lansingcodelab.com', password: '123456')
```

Did you get something like this back?

``` output
=> #<User id: 1, email: "hello@lansingcodelab.com", password_digest: "$2a$10$OGlBpyqzLOuQtisZ/vviR.wgJzi6.RQvyOeaoO1T8hN...", created_at: "2016-01-24 20:35:01", updated_at: "2016-01-24 20:35:01">
```

Notice that instead of storing a `password` field, we have a `password_digest` which has a really long string. That string is like a lock that only the real password can open. Or like one side of a code phrase used by secret agents.

![The eagle has left the nest.](https://imgs.xkcd.com/comics/eagle.png)

---

## Allowing users to sign in and out

As we implement this next feature, there will be _quite a few steps_ before we finally arrive at a working app for users to sign in and out. The project for this lesson will simply require completing these steps, so build off an old project with at least 1 model in it.

---

## Generating a sessions controller

So now we have a way to create and delete users, but how do existing users actually sign in and out? To manage all this, let's generate a new sessions controller with 3 actions:

- `new` (to display the sign in form)
- `create` (where we'll submit the sign in form to)
- `destroy` (to sign out a signed in user)

We can do this with the following generator:

```
rails generate controller Sessions new create destroy
```

This generates the following output:

``` output
create  app/controllers/sessions_controller.rb
 route  get 'sessions/destroy'
 route  get 'sessions/create'
 route  get 'sessions/new'
invoke  erb
create    app/views/sessions
create    app/views/sessions/new.html.erb
create    app/views/sessions/create.html.erb
create    app/views/sessions/destroy.html.erb
invoke  helper
create    app/helpers/sessions_helper.rb
invoke  assets
invoke    coffee
create      app/assets/javascripts/sessions.coffee
invoke    scss
create      app/assets/stylesheets/sessions.scss
```

So the main things that were added were:

- an `app/controllers/sessions_controller.rb` file
- routes for our 3 actions in `config/routes.rb`
- views for our 3 actions in `app/views/sessions/`

And then some other, less essential files were also generated:

- `app/helpers/sessions_helper.rb`
- `app/assets/javascripts/sessions.coffee`
- `app/assets/stylesheets/sessions.scss`

There's still a bit of work we'll want to do with the files that creates, but now we at least have a skeleton.

### Modifying the sessions controller

Let's go through one action at a time, because there will be a bit of explaining to do as we go.

#### The `new` action

First, the `new` action, which we don't have to touch at all. Yay! It already does what it needs to do, which is to simply serve up the `new.html.erb` view.

``` ruby
def new
end
```

#### The `create` action

The create action is the most complicated. But below in the comments, I explain line by line exactly what we're doing.

``` ruby
def create
  # Looking for a user with the given email address and storing either that
  # user (if a user was found) or `nil` (if no user was found) in the `user`
  # variable
  user = User.find_by(email: params[:email])
  # If we found a user with that email address AND the given password works
  # with our password digest
  if user && user.authenticate(params[:password])
    # Store the user's id in the session, to keep track of who's signed in
    # (to learn more about this seemingly magical `session` variable Rails
    # provides, [check out these docs](http://guides.rubyonrails.org/security.html#sessions))
    session[:user_id] = user.id
    # Redirect to the `root_url` and display a notice that the user has
    # successfully signed in
    redirect_to root_url, notice: 'Successfully signed in!'
  # If the email or password were wrong
  else
    # Alert the user that their credentials are bad
    flash.alert = 'Invalid email/password combination. Please try again.'
    # Render `new.html.erb` in `app/views/sessions/`
    render :new
  end
end
```

#### The `destroy` action

The destroy action isn't as complicated. It just replaces the user id we saved in the session with `nil` (Ruby's way of saying "nothing"), then redirects to the `root_url` with a notice that the user did indeed successfully sign out.

``` ruby
def destroy
  # Set the `:user_id` stored in the `session` back to `nil`, essentially
  # forgetting about the user that was signed in
  session[:user_id] = nil
  # Redirect to the `root_url` and display a notice that the user has
  # successfully signed out
  redirect_to root_url, notice: 'Successfully signed out!'
end
```

### Modifying the views

The only view we actually need is the `new` view, to show our sign in form. Once a user signs in (with the `create` action) or signs out (with the `destroy` action), we'll probably just redirect them to the homepage. So let's delete the `create.html.erb` and `destroy.html.erb` view files.

Then in `new.html.erb`, we'll set up our sign in form:

```
<h1>Log In</h1>

<%= form_tag sessions_path do %>

  <div class="field">
    <%= label_tag :email %><br>
    <%= text_field_tag :email %>
  </div>

  <div class="field">
    <%= label_tag :password %><br>
    <%= password_field_tag :password %>
  </div>

  <div class="actions">
    <%= submit_tag "Log In" %>
  </div>

<% end %>
```

---

## Creating more intuitive routes

Right now, `config/routes.rb` lists these routes.

``` ruby
get 'sessions/new'
get 'sessions/create'
get 'sessions/destroy'
```

That means, for example, that when a visitor goes to `/sessions/new`, they'll be directed to the `new` action in the `sessions` controller. These aren't great routes though, so we're going to delete them and create our own.

Now let's replace them with:

``` ruby
resources :sessions, only: [:new, :create, :destroy]
```

When we run `rake routes`, we can see that this single line creates the following paths:

```
   sessions POST   /sessions(.:format)     sessions#create
new_session GET    /sessions/new(.:format) sessions#new
    session DELETE /sessions/:id(.:format) sessions#destroy
```

I actually like nice `/sign-in` and `/sign-out` paths though, so let's set those up too:

``` ruby
get '/sign-in' => 'sessions#new'
delete '/sign-out' => 'sessions#destroy'
```

Now when we run `rake routes`:

```
     Prefix Verb   URI Pattern             Controller#Action
   sessions POST   /sessions(.:format)     sessions#create
new_session GET    /sessions/new(.:format) sessions#new
    session DELETE /sessions/:id(.:format) sessions#destroy
    sign_in GET    /sign-in(.:format)      sessions#new
   sign_out DELETE /sign-out(.:format)     sessions#destroy
```

We can see that we now have access to `sign_in_path` and `sign_out_path` helpers, linking to very intuitive paths in our app. Yay!

---

## Showing the user something happened

Signing in should technically work now, but our controller notice saying `Successfully signed in!` and the alert saying `Invalid email/password combination. Please try again.` don't actually appear on the page yet... so it would be difficult for the user to know anything actually _happened_.

Both notices and alerts are part of a Rails feature called __flash messages__. Flash messages are a great way of displaying a message we only want to show a visitor once, then have it disappear. Since we're using flash messages (`notice` and `alert`) in our sessions controller, let's actually give them a place to appear.

Since we want them to work on every page of our app, let's put the code we need somewhere in our layout file: `layouts/application.html.erb`.

```
<!-- For each flash message -->
<% flash.each do |type, content| %>
  <!--
    Display a `div` element with a class of `type`, so that we can
    give different styles to alerts (which are usually errors or when
    something has gone wrong) than to notices (which are usually)
    just informational, like letting a user know something was
    successful.
  -->
  <div class="<%= type %>">
    <!-- Display the content of the message inside a `p` element. -->
    <p><%= content %></p>
  </div>
<% end %>
```

As you can see, Rails stores these messages in an object called `flash`. Each message in `flash` has a `type` and `content`, so we iterate through each one and render some HTML to display the message.

---

## Figuring out who's signed in (if anyone)

Now that we can detect a signed in user, let's create a way for our controllers and views to easily access it. I usually like to  add `current_user` and `user_signed_in?` helper methods in my application controller:

``` ruby
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

# Anything that ISN'T an action attached to a route should be
# in a `private` section of a controller.
private

  def current_user
    # Looks for a user with the id stored in the session, if there
    # is one. If `session[:user_id]` is `nil`, then the `find_by`
    # will also return `nil`.
    User.find_by(id: session[:user_id])
  end
  # Turns this private method into a helper method that can be
  # used not only in our controllers, but also in our views.
  helper_method :current_user

  def user_signed_in?
    # Takes `current_user`, which will either contain a valid user
    # (which would be "truthy") or `nil` (which would be "falsy")
    # and gets a `true` or `false` value from those, respectively.
    !!current_user
  end
  # Turns this private method into a helper method that can be
  # used not only in our controllers, but also in our views.
  helper_method :user_signed_in?

end
```

---

## Adding "Sign in" and "Sign out" links

_Finally_, let's add sign in and sign out links to our app's menu in `layouts/application.html.erb`.

```
<div class="user-status">
  <% if user_signed_in? %>
    Signed in as <%= current_user.email %>.
    <%= link_to "Sign out", sign_out_path, method: :delete %>
  <% else %>
    <%= link_to "Sign in", sign_in_path %>
  <% end %>
</div>
```

---

## Testing out authentication in our app

If you haven't already, create a new user in the rails console. Then launch your app with `rails server` and try to sign in and out. You'll know it's working if there's:

- a "Sign in" link on every page, when not signed in
- an error message when trying to sign in with bad credentials
- a notice that we successfully signed in when it worked
- the email address for the signed in user and a "Sign out" link on every page, when signed in
- a notice that the user successfully signed out when signing out

---

## Authorization

Now that we can authenticate (i.e. recognize) users, now would be a good time to prevent random visitors from messing with our database. First, let's add this method below the other methods we created in our application controller:

``` ruby
def only_allow_signed_in_users
  unless user_signed_in?
    redirect_to sign_in_url, notice: 'You must sign in to access this part of the app.'
  end
end
```

Then in the controllers for any models you want to protect, you can set this method to run before every action, except the ones you want to specifically allow. I usually place `before_action`s at the top of my controllers.


``` ruby
before_action :only_allow_signed_in_users, except: [:index, :show]
```
