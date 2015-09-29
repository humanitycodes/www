## What's CSS?

__CSS (Cascading Style Sheets)__ are what make the difference between a plain, boring webpage and one that looks all sleek and pretty. For example, in the image below, the web page on the right has had all the styles removed. All the words are the same, but it all _looks_ different.

![The difference styles make](https://www.dropbox.com/s/pe0bjp0e20t8nay/Screenshot%202015-09-29%2014.57.32.png?dl=1)

If you want to see what other pages look like without styles, you can install the free [Web Developer browser extension](http://chrispederick.com/work/web-developer/) (for Chrome, Firefox, and Opera - if you're not using one of those, you can download and install one of them now).

Once installed, you can [follow these instructions](http://stackoverflow.com/questions/14046738/how-to-disable-css-in-browser-for-testing-purposes#answer-14046754) to temporarily disable all styles on a page and see the difference.

---

## Selectors, Properties, and Values

To change the way a page looks, we'll use __style rules__. Each rule is made up of __selectors__, __properties__, and a __value__ for each of those properties. It looks like this:

``` css
selector {
  property: value;
}
```

And here's a real example:

``` css
body {
  background-color: lightblue;
}
```

What do you think that does? Think about it, then open up your resume project and add the following code inside of your `head` element to see it work in action.

``` html
<style>
  body {
    background-color: lightblue;
  }
</style>
```

---

### Multiple selectors and properties

You can also have multiple selectors and multiple properties in a rule. For example:

``` css
selector1, selector2, selector3 {
  property1: value1;
  property2: value2;
  property3: value3;
}
```

And a real example:

``` css
p, ul, ol {
  background-color: lightgreen;
  color: orange;
  font-size: 20px;
}
```

Once again, if you want to see it in action, you'll have to put that code inside of a `style` element. The `style` element will be inside your `head`.

``` html
<style>
  p, ul, ol {
    background-color: lightgreen;
    color: orange;
    font-size: 20px;
  }
</style>
```

As you'll see, this code is kind of nice. Even before you open up your browser, you can start to guess what it might do.

---

## Selector specificity

Ok, now let's say you want most paragraph text to be black, like this:

``` css
p {
  color: black;
}
```

But what if there are _some_ paragraphs you want to stand out a little. Maybe it's important information, like a warning. Maybe you want that text to be a sort of light red.

We can use a special kind of HTML attribute called a __class__ to put elements into categories, which is _really handy_. It looks like this:

``` html
<p class="warning">Danger! This webpage is too hip for most eyes. Please consult a doctor before viewing.</p>
```

Then in our style element, we can define:

``` html
<style>
  p.warning {
    /* This is a CSS comment. I'm using it now
       to explain that I chose "lightcoral",
       because it's much easier on the eyes than
       the ugly "red" - it's yucky. */
    color: lightcoral;
  }
</style>
```

As you can see, __we define a special class on an element by preceding it with a period__. Try that out now in your own page. And try making up classes for other elements.

It's important to note though that a class name can't have any spaces - but you _can_ use dashes and underscores. Most people use dashes, like this: `my-class-name`.

---

## Freestyle practice

Using this knowledge, try applying some other properties to your document from [this list of common CSS properties](http://www.zell-weekeat.com/9-important-css-properties-you-must-know/).
