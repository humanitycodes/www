## Functions and parameters

This is a function:

``` js
alert()
```

Type that into the JavaScript console and press enter.

Did you see it? It should have made a little message box appear. But the message box was pretty boring. It didn't really say anything. To make it say something, you can pass this function an __argument__, like this:

``` js
alert("This is what I want the message box to say.")
```

In the case above, `"This is what I want the message box to say."` is the argument and we passed it into the function by placing it between the parentheses after the function's name. Now if we run that line, those words should show up in the message box.

---

## Strings

``` js
"This is what I want the message box to say."
```

That bunch of text above that we passed into the `alert` function - it's a __string__. It's short for a _string of characters_. And a __character__ is any letter, number, space, or symbol that you type. In this case, the characters are like physical beads on a string in a necklace. They have a specific start point, order, and end point.

![Beaded letter necklace](https://img0.etsystatic.com/018/1/6687230/il_340x270.544986570_9nyk.jpg)

But strings are more powerful than just normal text. Want to know how many characters are in the string above? Try this in your JavaScript console:

``` js
"This is what I want the message box to say.".length
```

It counts up all the characters for you automatically!

You can also add strings together with the `+` sign:

``` js
"My" + "favorite" + "color" + "is" + "green" + "."
```

That will add up to:

``` js
"Myfavoritecolorisgreen."
```

Huh. No spaces. In JavaScript, a space is just another character, so if you want one, you have to add it yourself, like this:

``` js
"My " + "favorite " + "color " + "is " + "green" + "."
```

That correctly returns:

``` js
"My favorite color is green."
```

---

## Storing values in variables

It's annoying and error prone to retype a string every time you want to refer to it. To make code easier to write and easier to read, we have __variables__. In JavaScript, you introduce a new variable with `var`, like this:

``` js
var myString = "This is a very long string that we don't have to have to retype every time we refer to it."
```

Try entering that into the JavaScript console. Then retrieve that value by entering:

``` js
myString
```

And now, let's put everything we've learned so far together!

---

## Storing values from functions in variables

There's one more function I'll introduce you to, similar to `alert`. It's called `prompt`.

``` js
prompt("What's your name?")
```

When you enter that into your JavaScript console, the message box should have a little input field where you can enter your name. Did you do it? Great!

Unfortunately, that last command doesn't do anything with your name. In order to actually use it, you need to store it somewhere. That means it's time for a variable, maybe called _name_?

``` js
var name = prompt("What's your name?")
```

Now let's put three strings together for a new message to the user:

``` js
alert("Hello " + name + "! I hope you're having a great day. :-)")
```

Nice!

<!-- Want to know the first letter?

``` js
"This is what I want the message box to say."[0]
```

What? Why did we put a 0 at the end there? It's not the 0th letter. It's the 1st letter. Shouldn't that be a 1? Ahh, that'd be nice, wouldn't it? Unfortunately, machines start counting lists of things with 0. So if we want the 1st thing, we put a 0. If we want the 2nd, we put a 1.

What about the 3rd letter?

``` js
"This is what I want the message box to say."[2]
``` -->
