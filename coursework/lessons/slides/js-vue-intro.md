## The problem with building interfaces with JavaScript

We've built some cool stuff with JavaScript so far! But you may have already noticed that as applications grow more complex, new features can become... frightening. You find yourself spending a lot of time doing this:

![Staring at computer](https://pixabay.com/static/uploads/photo/2015/11/26/22/27/girl-1064658_960_720.jpg)

That's because you have to do a _lot_ of thinking. You have to ask yourself:

- Which elements do I need to keep track of?
- Should I give those elements `id`s or `class`es?
- What names should I give my `id`s and `class`es?
- How should I organize the code?
- How do I keep the page in sync with my latest data?
- Which events can I attach directly to elements and which require delegation?

On top of that, you have to move any "smart" HTML into your JavaScript, so that you have to look all over the place just to see what kind of app you have. Take a look at this for example:

``` html
<p>What's your name?</p>
<input type="text" id="name-input">
<div id="response-to-name"></div>

<script>
  var input = document.getElementById('name-input')
  var response = document.getElementById('response-to-name')

  input.oninput = function (event) {
    var userName = event.target.value
    response.innerHTML = '<p>' +
      'Hi, ' +
      '<strong>' + userName + '</strong>' +
    '</p>'
  }
</script>
```

It's a fairly simple app that asks you for your name. And when you type it in, it uses your name to greet you. Try that out in your own HTML file now.

So most of our HTML is here:

``` html
<p>What's your name?</p>
<input type="text" id="name-input">
<div id="response-to-name"></div>
```

But then our actual response is in our JavaScript, set with:

``` js
response.innerHTML = '<p>' +
  'Hi, ' +
  '<strong>' + userName + '</strong>' +
'</p>'
```

It's slightly annoying, especially with all those quotes and pluses, but not _too_ bad overall. But then a new feature gets requested. Someone noticed that if they delete their name in the `input`, it still shows `Hi,` - which is kind of weird. It should disappear.

Fixing that isn't too bad. We can just add an if statement to check if the user has typed anything in. Like this:

``` html
<p>What's your name?</p>
<input type="text" id="name-input">
<div id="response-to-name"></div>

<script>
  var input = document.getElementById('name-input')
  var response = document.getElementById('response-to-name')

  input.oninput = function (event) {
    var userName = event.target.value
    if (userName) {
      response.innerHTML = '<p>' +
        'Hi, ' +
        '<strong>' + userName + '</strong>' +
      '</p>'
    } else {
      response.innerHTML = ''
    }
  }
</script>
```

And now they want a "Clear" button to delete the name. OK, so to do that, we'll have to:

- Add the `button` in the HTML
- Give the `button` an `id`
- Get that element by its `id` in our JavaScript
- Add an `onclick` function for the "Clear" button
- Pull out the code that changes the page into a separate `render` function, since we now have two events that need access to update our state

``` html
<p>What's your name?</p>
<input type="text" id="name-input">
<button id="clear-name-button">Clear</button>
<div id="response-to-name"></div>

<script>
  var input = document.getElementById('name-input')
  var response = document.getElementById('response-to-name')
  var clearButton = document.getElementById('clear-name-button')

  function render (userName) {
    if (userName) {
      response.innerHTML = '<p>' +
        'Hi, ' +
        '<strong>' + userName + '</strong>' +
      '</p>'
    } else {
      response.innerHTML = ''
    }
  }

  input.oninput = function (event) {
    render(event.target.value)
  }

  clearButton.onclick = function () {
    render('')
  }
</script>
```

That's _almost_ enough. The input itself is still dumb. But if we just add `input.value = userName`, then we get some really weird stuff happening.

When we type anywhere except at the end of that input, the cursor is automatically reset to the end. That's because every time we type, `render` is overriding the value of the input with the exact same contents, forcing us out of our place.

It's annoying, but the fix isn't too bad. We'll just update our `render` function so that we _only_ update `input.value` when it's _not_ already equal to `userName`.

``` js
function render (userName) {
  // INPUT
  if (input.value !== userName) {
    input.value = userName
  }
  // RESPONSE
  if (userName) {
    response.innerHTML = '<p>' +
      'Hi, ' +
      '<strong>' + userName + '</strong>' +
    '</p>'
  } else {
    response.innerHTML = ''
  }
}
```

So everything works now, but even that relatively simple example seemed like it was a lot harder than it should be. The fact that we had to troubleshoot just to get a "Clear" button working is not a good sign. I don't know about you, but I'm already dreading the next feature request!

![Dreading another feature request](https://pixabay.com/static/uploads/photo/2015/11/26/22/27/girl-1064659_960_720.jpg)

And you know what else I don't like? Without looking at our JavaScript, it's impossible to tell what our app _actually does_. We have to keep jumping around between the HTML and JavaScript and keeping stuff in our heads.

Ready for the solution?

---

## A brief overview of Vue

Now let's build that same app using the __Vue__ library. This will be a brief tour of a few commonly used features, to give you a taste of how Vue makes things easier. It'll be an overVue. Get it? Like an over_view_ of _Vue_?

For now, sit back, relax, enjoy the puns, and get a taste for the workflow. Afterwards, we'll go over each feature in more detail.

Since Vue is a library, let's include it in our app by adding this line to our `head`:

``` html
<script src="https://cdn.jsdelivr.net/vue/latest/vue.js"></script>
```

And before we build anything, Vue likes to know which part of HTML we're going to be working in. So we'll create an element with an `id` - I'll use `app`.

``` html
<div id="app">
</div>
```

Then below that, we'll create a `script` element. Inside it, we'll create a new Vue component and tell it to add some Vue magic to the `#app` `el`ement (notice we're using a handy CSS selector to target the element).

``` html
<script>
  new Vue({
    el: '#app'
  })
</script>
```

And altogether, we get:

``` html
<div id="app">
</div>

<script>
  new Vue({
    el: '#app'
  })
</script>
```

Now let's get started.

First, we'll just have the greeting show up if the user has typed a `userName`. We'll use 3 of Vue's features to accomplish this:

1. `v-model`: a special attribute that Vue provides for `input`s and `textarea`s. By setting `v-model="userName"`, we're telling Vue we want to keep track of what's typed in here and call it `userName`.
2. `v-if`: only renders an element if something is "truthy" (i.e. exists - things that don't exist, like `null` or an empty string are "falsy")
3. `{{ ... }}` allows us to inject JavaScript directly in our HTML. For example, `{{ userName }}` will show the value of `userName` at that place in the page.

And here's what that looks like:

``` html
<div id="app">
  <p>What's your name?</p>
  <input type="text" v-model="userName">
  <div v-if="userName">
    <p>Hi, <strong>{{ userName }}</strong></p>
  </div>
</div>

<script>
  new Vue({
    el: '#app'
  })
</script>
```

A few things worth noting:

- Apart from our container element, we didn't have to give _anything_ an id or class just to make it work with JavaScript.
- We didn't have to worry about events and rendering. When the data updates, the view _automatically_ updates.
- All our HTML is in one place (no clunky adding together strings in JavaScript!)
- Looking at our HTML, we can tell _exactly_ what our app does.
- We haven't even had to _add_ any JavaScript specific to our app yet, because our app is _that_ simple.

Feeling pumped yet?! Are you starting to see the light? Let's commemorate this moment.

![Look ma, I'm using Vue!](https://pixabay.com/static/uploads/photo/2015/11/26/22/27/notebook-1064660_960_720.jpg)

Now before we move on, there's one more thing I like to do when I start working with data in Vue apps. It's set a default value with the `data` option. Like this:

``` html
<script>
  new Vue({
    el: '#app',
    data: {
      userName: ''
    }
  })
</script>
```

That just means when we first load our app, the `userName` should be an empty string.

Now for that pesky "Clear" button that caused us so much trouble before. Well, it won't be any trouble now. You can do it one line:

``` html
<button v-on:click="userName = ''">Clear</button>
```

_That's it._ When we want to bind events to an element, Vue gives us special attributes that start with `v-on`. `v-on:click` makes something happen when we click. Inside the contents of the attribute, we can run some JavaScript to set the `userName` to `''`. And we're done.

While this is pretty great though, I like to keep things a little more organized. That's why Vue comes with a `methods` option, so that we can define functions for logic we want to move out of the HTML.

So I'll define a function called `clearUserName`, which does the exact same thing: set `userName` to `''`. You'll notice that inside our methods, when we want to refer to our data (or other methods), we can access them with `this`. For example: `this.userName`.

``` html
<script>
  new Vue({
    el: '#app',
    data: {
      userName: ''
    },
    methods: {
      clearUserName: function () {
        this.userName = ''
      }
    }
  })
</script>
```

Now to update our HTML:

``` html
<button v-on:click="clearUserName">Clear</button>
```

This way, when we're browsing our HTML, we don't have to look at JavaScript code and figure out what it's doing. We can just _read_ what happens. `v-on:click="clearUserName"` basically reads, _When __click__ed, it will __clear__ the __user name__._

And finally, this is what we end up with in our finished app:

``` html
<div id="app">
  <p>What's your name?</p>
  <input type="text" v-model="userName">
  <button v-on:click="clearUserName">Clear</button>
  <div v-if="userName">
    <p>Hi, <strong>{{ userName }}</strong></p>
  </div>
</div>

<script>
  new Vue({
    el: '#app',
    data: {
      userName: ''
    },
    methods: {
      clearName: function () {
        this.userName = ''
      }
    }
  })
</script>
```

---

## Review of features so far

### What _every_ Vue app needs

First, it needs Vue! So typically in your `head`, you'll include:

``` html
<script src="https://cdn.jsdelivr.net/vue/latest/vue.js"></script>
```

Then you'll create a container element for Vue to work inside of. You have to give it an `id`, but it doesn't matter what that `id` is.

``` html
<div id="app">
</div>
```

Finally, we'll create another `script` element _after_ our container element and initialize it as a Vue component, like so:

``` html
<script>
  new Vue({
    el: '#app'
  })
</script>
```

Altogether, that'll look something like this:

``` html
<!DOCTYPE html>
<html>
  <head>
    <title>My App</title>
    <script src="https://cdn.jsdelivr.net/vue/latest/vue.js"></script>
  </head>
  <body>
    <div id="app">
    </div>

    <script>
      new Vue({
        el: '#app'
      })
    </script>
  </body>
</html>
```

### Basic Vue options: `el`, `data`, and `methods`

- `el` is a string of the CSS selector for the element that contains the Vue app
- `data` is an object, with any data we want to keep track of in our app, along with starting values
- `methods` is an object, with any functions we want to use in our app

For example:

``` js
new Vue({
  el: '#app',
  data: {
    backgroundColor: 'lightblue'
  },
  methods: {
    updateBackgroundColor: function (newColor) {
      this.backgroundColor = newColor
    }
  }
})
```

### `v-model`

Whenever we have data that we want to automatically update when we change a form, `v-model` is used to specify that data. For lots of examples with a variety of form inputs, check out the [_Form Input Bindings_ documentation](http://vuejs.org/guide/forms.html#Basics_Usage).

### `v-if`

When we only want an element to display _some_ of the time, we can use `v-if` with an expression that will either be true or false. For examples and more information, check out the [_Conditional Rendering_ documentation](http://vuejs.org/guide/conditional.html).

### `{{ ... }}`

Whenever we want our data to appear on the page, we'll use `{{` and `}}` in our HTML, where we want the value of the data to appear. For example:

``` html
<div id="app">  
  My name is {{ firstName }}{{ lastName }}. I live in {{ city }}, {{ state }} and my favorite food is {{ favoriteFood }}.
</div>

<script>
  new Vue({
    el: '#app',
    data: {
      firstName: 'Chris',
      lastName: 'Fritz',
      city: 'Lansing',
      state: 'Michigan',
      favoriteFood: 'stinky cheese'
    }
  })
</script>
```

### `v-on`

If you want something to happen in response to an event - like a mouse click or the press of a particular key, `v-on` is how you'll do it.

For example, to run `myMethod` when clicking on a button, you could write:

``` html
<button v-on:click="myMethod">Click me!</button>
```

Now think back to your todo app. We had to detect whether the _enter_ key was pressed, remember? So _every_ time we pressed a key, we had to check if it was key 13 - which apparently the computer understands as the _enter_ key. It looked something like this:

``` js
// When a key is pressed down in the #my-input element
document.getElementById('my-input').onkeyup = function (event) {
  // If the ENTER key is pressed...
  if (event.which === 13) {
    myMethod()
  }
}
```

Well with `v-on`, you can add a dot (`.`) to the `keyup` and `keydown` events, then add the number representing the specific key. So that looks like:

``` html
<input type="text" v-on:keyup.13="myMethod">
```

Much cleaner. But... it gets _way_ better than that! Why the heck should we have to remember that the _enter_ key is key 13? Isn't that pretty dumb? Shouldn't the _computer_ remember that for us? With Vue, it does.

For the _enter_ key and many other common keys, you can simply write its normal name, like this:

``` html
<input type="text" v-on:keyup.enter="myMethod">
```

Nice, right?! For more examples and other tricks, check out the [_Methods and Event Handling_ documentation](http://vuejs.org/guide/events.html).

---

## Learning more about Vue

With what you've learned about Vue in this lesson, you can already do quite a lot, but we've just scratched the surface. That means we'll dive into it further in future lessons - but guess what? You don't have to wait.

One of the things I love about Vue is its great community. The website features [very thorough documentation](http://vuejs.org/guide/) and an [active forum](http://forum.vuejs.org/), full of friendly people. Many of those friendly people are also in [the chat room](https://gitter.im/vuejs/vue), which anyone can join for live help.

So here's what you can do if you get stuck or want to do something you're not sure how to do:

1. __Visit [the documentation](http://vuejs.org/guide/)__.
  1. Browse section titles in the sidebar, looking for something related to my question.
  2. If none of the section titles look relevant, use the search in the menu at the top.
2. __Ask someone you know with more experience.__ If you're on the Lansing Codes Slack, [send me a message](https://lansingcodes.slack.com/messages/@chrisvfritz/) with your question. If you're _not_ on the Slack, [get an invite here](http://slack.lansing.codes/).
3. __Seek help from the community__.
  1. If my question is simple, I'll ask it in [the chat room](https://gitter.im/vuejs/vue).
  2. If my question seems complex, I'll post it in [the forum](http://forum.vuejs.org/)
4. If no one else is able to answer your question, leaving you with either a bug or a feature request, __seek help from Evan You (the creator of Vue)__. [Open an issue](https://github.com/vuejs/vue/issues) describing exactly what you're experiencing. As of writing, Evan resolves issues in an [average of 8 hours](http://issuestats.com/github/vuejs/vue), which is amazing!
