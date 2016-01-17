## Where every page knows your name

It's pretty great that we can get information from a user with JavaScript. But you know what stinks about this code below?

``` js
var firstName = prompt("What's your first name?")
document.getElementById('greeting').innerHTML = 'Hi, ' + firstName
```

It has no _memory_. When you refresh the page, it'll ask for your name all over again, as if you'd never met. Kind of defeats the purpose of the personal touch, doesn't it?

Fortunately, browsers have a way for you to store and retrieve strings across page reloads: __`localStorage`__. And the way it works is relatively simple. There are only two main functions: `setItem` and `getItem`.

Here's an example of how we might use those two functions to build a website that remembers your name:

``` html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Cheers</title>
  </head>
  <body>
    <h1 id="greeting"></h1>
    <script>
      var firstName = localStorage.getItem('firstName')

      if (firstName === null) {
        firstName = prompt("What's your first name?")
        localStorage.setItem('firstName', firstName)
      }

      document.getElementById('greeting').innerHTML = 'Hi, ' + firstName
    </script>
  </body>
</html>
```

Before we dive into that, create a temporary folder with an `index.html` file inside, then paste that code into the file. Make sure to launch the page with `live-server`, because `localStorage` doesn't work with the `file://` protocol in some browsers.

Did you try it? It should have asked you your name, then displayed a greeting with your name on the page.

Now... try refreshing! Did it ask for your name again? It shoudn't have. When you told it your name the first time, is saved you information with `localStorage.setItem`. Then when you refreshed, it ran `localStorage.getItem` to see if it already had a name for it - and it did. So it just displayed it.

Now let's walk through the code line by line, to see _exactly_ how we're achieving this miracle of cyber-friendliness.

``` js
var firstName = localStorage.getItem('firstName')
```

We're using `localStorage.getItem` to look for a `firstName` and then we assign the result to a variable. `getItem` takes one parameter, which is a string with the name of the item we want to retrieve from storage.

`getItem` will return a string if we've saved a `firstName` earlier. Otherwise, it'll return `null`, which would mean no value called `firstName` was found.

``` js
if (firstName === null) {
  firstName = prompt("What's your first name?")
  localStorage.setItem('firstName', firstName)
}
```

So if the `firstName` is `null`, which again, means it couldn't find a `firstName`, then we get it from the user with `prompt`. After that, we save what we get from the user with `localStorage.setItem`.

`setItem` takes two parameters:

1. the name of the item we want to set into storage
2. the value we want to store

In our case, the value we want to store is in the variable `firstName`.

``` js
document.getElementById('greeting').innerHTML = 'Hi, ' + firstName
```

Finally, we find the element with an id of `greeting` and set it's `innerHTML` (i.e. contents) to `Hi, `, plus whatever the first name of the visitor is.

---

## FAQ

At this point, you may have some questions.

### Where is data stored with `localStorage`?

Instead of saving information on a server somewhere, like many web applications do, data in `localStorage` is stored _locally_ - on the user's computer.

### Can I see stuff stored by other websites?

No, you can't. `localStorage` data is scoped to the domain. So if your website is at `example.com`, you can only see data saved at pages on `example.com`.

And actually, it's even more specific than that. Information isn't even shared across _subdomains_. So data stored by `wary-wilderness.surge.sh` isn't accessible to `funny-mountain.surge.sh`.

### How much data can I put in `localStorage`?

Between 2MB and 10MB, [depending on the browser](http://www.html5rocks.com/en/tutorials/offline/quota-research/). If you're thinking, "2MB doesn't sound like very much...", it's probably more than you think when you're just storing strings.

To get a better idea of how much text is in 2MB, check out [the text file in this ZIP](https://gist.github.com/chrisvfritz/6880d96c100a9a3ad825/archive/a8dbce78fba793fc5254cd3bc1d031d27ec17c6b.zip). It's exactly 2MB. 2 million characters. 14,285 tweets. It's not _quite_ enough to fit Tolstoy's famously long _War and Peace_, but you can fit most of it. Shave off the boring bits and you're good.

### How long will `localStorage` data stay on a user's computer?

`localStorage` data never expires, so it'll stay on the computer until a user goes into their browser settings and manually clears their entire browser cache or the cache for your website.

### Is `localStorage` like cookies?

It's similar in that data is stored on the user's computer, but cookies work somewhat differently and serve a different purpose. You can [read this](http://stackoverflow.com/questions/3220660/local-storage-vs-cookies) if you're really curious about cookies, but for now, you're not expected to know anything about them.

---

## Can I save _anything_ in `localStorage`?

This one gets its own page, because the answer takes a bit more explaining. The good news is, you _can_ save anything! There's just one catch. Whatever you save will be turned into a string if it isn't already one.

That means if I save a number, for example like this:

``` js
localStorage.setItem('myNumber', 1)
```

Then this...

``` js
localStorage.getItem('myNumber')
```

...won't return `1` (the number), but `"1"` (the string).

So why is that important? Well, what do you think the following line will return?

``` js
localStorage.getItem('myNumber') + 1
```

`1 + 1` is `2`, right? Yes... but `"1" + 1` is `"11"`, because if you add a string and a number together, JavaScript will turn the number into a string and combine them into a single string.

But! _Every other operator_ will do the opposite, trying to turn your string into a number, then performing the operation to give you a number. So for example, `("1" + 1) * 2` will first create `"11"` then turn it into `11` and times it by `2`, giving you `22` - which _is_ a number like you were expecting, but a wildly wrong number!

If you work with `localStorage` forgetting that it always saves as a string, you'll grow very frustrated, very quickly. Heck, you'll probably end up questioning your sanity and basic math skills.

So here's how to save yourself.

### How to convert stringified values back to their original type

For integers, use `parseInt`:

``` js
localStorage.setItem('myNumber', 1)
var myNumber = parseInt( localStorage.getItem('myNumber') )
```

For booleans, check if it's equal to `'true'`:

``` js
localStorage.setItem('myBoolean', true)
var myBoolean = localStorage.getItem('myBoolean') === 'true'
```

### What about arrays and objects?

![Patience, young grasshopper](https://media.licdn.com/mpr/mpr/p/3/005/075/1a2/3ed20a3.jpg)

Don't worry about them yet. In fact, you don't even have to know what they _are_ for this lesson. You'll learn about these data types in a later lesson, then learn how to use them with `localStorage`.

---

## Other `localStorage` functions

These are some other functions you'll probably use less often, but will still come in handy in specific situations. Try them out in the JavaScript console, on the name-remembering page we were just playing with.

### `localStorage.valueOf()`

Retrieves all the data in `localStorage` for a website. If you're curious, you can open websites you often visit and run this in the JavaScript console to see if they're storing anything.

### `localStorage.removeItem('firstName')`

Resets the value for the item called `firstName` back to `null`.

### `localStorage.clear()`

Clears _all_ the data in `localStorage` for the current domain.
