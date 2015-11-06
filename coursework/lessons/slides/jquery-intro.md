## Why jQuery?

jQuery is by far the most popular JavaScript library. A lot of the things that jQuery helps with, you can do with plain JavaScript if you know how. The problem is, how to do something in JavaScript is sometimes... complicated, especially when it comes to changing things on a webpage.

Different browsers will actually interpret your JavaScript in different ways, so that your code might work in Firefox, for example, but break in Internet Explorer 9 and below. Even if we decide we only care about the browsers 98% of people use, that still leaves us with Chrome, Firefox, Internet Exporer, and Safari. And let's say we only want to support the last 3 versions of each. That's still 12 web browsers to test our code in.

Yikes! That's not fun. And that's where jQuery comes in. It helps us do a lot of common things with _less code_ that will work in _every_ browser. It even calls itself "The Write Less, Do More, JavaScript Library."

---

## Diving into a real example

Let's say you're developing the webapp for the Code Lab. In fact, it's the very same web app you're looking at right now. And you're hearing from a lot of students that they'd like to be able to highlight blocks of code on the page to point them out to mentors.

OK, so inspecting the page, it looks like the blocks of code are always in `code` elements wrapped in `pre` elements. What if we made a little border around the `pre` - and you know what? I'm feeling fancy, so we'll throw in some nice box shadow too.

I'm working in Google Chrome, so I'll right-click on a code block, then hit `Inspect Element`. Then I'll start playing with some CSS properties on one of the `pre` elements. I finally settle on:

``` css
border: 20px solid #A0C1A0;
box-shadow: 0 0 30px #A0C1A0;
```

That looks pretty good, but how do I make that CSS apply when I click on the `pre` element? We need to add behavior to the page, so it's JavaScript time! And specifically, I'll use jQuery.

---

## Targeting elements with jQuery

In jQuery, if you want to target something on the page, you can just use CSS selectors. So instead of:

``` js
document.getElementById('my-id')
```

You can simply target an id with:

``` js
$('#my-id')
```

What if you want to target all the `li`s with a class of `active` inside of a `ul` with a class of `links`? In plain JavaScript, this is where things get hairy. With jQuery, it's:

``` js
$('ul.links li.active')
```

Awesome! Now for our use case. We want to target `pre` elements, but only those that have a `code` element inside of them. Using a CSS selector, that's... huh. Impossible. There's no way to do that.

Not to fear, jQuery still has tricks up its sleeve:

``` js
$('code').parent('pre')
```

Excellent! jQuery is actually used on this page, but instead of using the dollar sign (`$`), we explicitly name it with `jQuery`. That means the code snippet above will instead look like this:

``` js
jQuery('code').parent('pre')
```

Open up the development console in your browser now and paste that code in to make sure it's working on this page. It should return a list of `pre` elements. As you put your mouse over each one, the corresponding code block on the page should highlight.

When you've confirmed that it's working, we'll move on making something happen when we click on it.

---

## Attaching "event handlers" to a "jQuery object"

Let's store our jQuery selector in a variable. We're grabbing all the code blocks on a page, so how about `codeBlocks`? Actually, let's also put a dollar sign in front of it:

``` js
var $codeBlocks = jQuery('code').parent('pre')
```

When using jQuery, the dollar sign in front is a convention. We use it for variables that contain a jQuery object, so that we know what we can call jQuery functions on, like the `on` function.

Whenever we want to make something happen when another thing happens, we'll use `on` to "handle" the "event" like so:

``` js
// Whenever one of the $codeBlocks is clicked,
// we do what's in the function
$codeBlocks.on('click', function(){
  console.log('You clicked on me!')
})
```

``` js
// Whenever one of the $codeBlocks is hovered over,
// we do what's in the function
$codeBlocks.on('hover', function(){
  console.log('You hovered over me!')
})
```

Now let's combine the last few code blocks. Try copying these lines into the developer console of this page:

``` js
var $codeBlocks = jQuery('code').parent('pre')

$codeBlocks.on('click', function(){
  console.log('You clicked on me!')
})

$codeBlocks.on('mouseenter', function(){
  console.log('You hovered over me!')
})
```

Then try putting your mouse over code blocks and clicking on them. Do you see the `console.log` messages show up in the developer console?

---

## Changing styles

There are many other events that jQuery's `on` function can handle, but we'll save that for another lesson. Now how do we apply that CSS when a code block is clicked on?

Fortunately, jQuery has a `css` function, which allows you to use what you already know about CSS to programmatically apply styles! And in order to apply styles to just the code block that was clicked on, we can create a jQuery object from `this`, which is a special word in JavaScript used for the context of a function. In the case of `on`, it refers to the element that the event happened on.

Here's what the result looks like:

``` js
var $codeBlocks = jQuery('code').parent('pre')

$codeBlocks.on('click', function(){
  jQuery(this).css('border', '20px solid #A0C1A0')
  jQuery(this).css('box-shadow', '0 0 30px #A0C1A0')
})
```

This works, but it can be improved a little. Since we're mentioning `#A0C1A0` in two related commands, let's assign it to a variable. That way, if we decide to change the color, we only have to change it in one place.

``` js
var $codeBlocks = jQuery('code').parent('pre')

$codeBlocks.on('click', function(){
  var highlightColor = '#A0C1A0'

  jQuery(this).css('border', '20px solid ' + highlightColor)
  jQuery(this).css('box-shadow', '0 0 30px ' + highlightColor)
})
```

And finally, there's _one more_ change I'd like to make. We're creating a jQuery object out of `this` twice with `$(this)`. That's not only unnecessary duplication, but it's also relatively slow. To clean up our code and speed things up, we could assign `$(this)` to a variable, like we did with `$codeBlocks` - or, we could _chain_ these functions.

That looks like this:

``` js
var $codeBlocks = jQuery('code').parent('pre')

$codeBlocks.on('click', function(){
  var highlightColor = '#A0C1A0'

  jQuery(this)
    .css('border', '20px solid ' + highlightColor)
    .css('box-shadow', '0 0 30px ' + highlightColor)
})
```

As you can see, we're just calling these functions right after each other. We can do this because each `css` function returns the object that it was called on. If that doesn't make sense right now though, that's OK. All you have to remember is that it makes it easy to set several CSS properties at once!

---

## Adding and removing classes

So we shipped that code and students like it a lot, but they have a few problems with it:

1. They want to be able to _unselect_ a code block by clicking it again once it's selected.
2. When they click on another code block, they want any previously highlighted code blocks to first unselect.

This is starting to turn into a headache. Where to even start? Fortunately, jQuery has our back even now!

First, let's move our CSS into a class in a stylesheet:

``` css
pre.selected {
  border: 20px solid #A0C1A0;
  box-shadow: 0 0 30px #A0C1A0;
}
```

Great, now we can just add and remove that class to elements instead of manually keeping track of styles for multiple code blocks on a page.

First, let's use the very useful `toggleClass` to alternately add or remove the `selected` class from the clicked-on code block:

``` js
var $codeBlocks = jQuery('code').parent('pre')

$codeBlocks.on('click', function(){
  jQuery(this).toggleClass('selected')
})
```

Fantastic! That's our first criterion out of the way. Now to unselect any other previously selected code blocks. Well, how about this:

``` js
var $codeBlocks = jQuery('code').parent('pre')

$codeBlocks.on('click', function(){
  jQuery('.selected').removeClass('selected')
  jQuery(this).toggleClass('selected')
})
```

That's _almost_ right. It meets the second criterion, but breaks the first one, because whenever we click on an item that's already been selected, the `selected` class is first removed, then added again by `toggleClass`, making it look like nothing is happening.

Really, we want to remove the `selected` class for any elements _except_ the one that was clicked on. To do that, we can chain `not(this)` onto our `$('.selected')` selector:

``` js
var $codeBlocks = jQuery('code').parent('pre')

$codeBlocks.on('click', function(){
  jQuery('.selected').not(this).removeClass('selected')
  jQuery(this).toggleClass('selected')
})
```

Now it works perfectly! Go ahead and try it in the developer console to confirm (don't worry, the CSS is loaded into this page in a style tag).

And before you move on to the project, there's one more thing I want to cover. You've seen `toggleClass` and `removeClass`, so can you guess the method we use to _add_ a class? That's right: `addClass`. Isn't it nice when things are intuitive?

<style>
  pre.selected {
    border: 20px solid #A0C1A0;
    box-shadow: 0 0 30px #A0C1A0;
  }
</style>
