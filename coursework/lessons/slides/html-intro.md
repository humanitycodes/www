## What is HTML?

You saw some HTML (__H__yper__t__ext __M__arkup __L__anguage) in the last lesson. But what is it exactly? We'll start with a joke from [XKCD](http://xkcd.com/).

[![How do you annoy a web developer?](http://imgs.xkcd.com/comics/tags.png)](http://xkcd.com/1144/)

``` html
<A>: Like </a>this.
```

Get it? If not, don't worry, I love explaining jokes.

---

## Tags and elements

``` html
<!doctype html>
<html>
  <head>
    <title>This is the title of the webpage!</title>
  </head>
  <body>
    <p>This is an example paragraph. Anything in the <strong>body</strong> tag will appear on the page, just like this <strong>p</strong> tag and its contents.</p>
  </body>
</html>
```

This code should look familiar from the last lesson. If you right-click on any webpage on the Internet, you can click on _View Page Source_ (or something similar) to see code like the above.

That's it. That's HTML. You may notice some patterns. First, there are a lot of groups of letters wrapped by a `<` and a `>` like this: `<body>`. Each of these is called a __tag__.

Most of the time, they'll come in pairs. An opening tag (e.g. `<body>`) and a closing tag (e.g. `</body>`). The only difference is the `/` at the beginning of the closing tag. Each pair is called an __element__. And everything between the opening and closing tag of an element is said to be inside of it.

---

## The `html`, `head`, and `title` elements

``` html
<!doctype html>
<html>
  <head>
    <title>This is the title of the webpage!</title>
  </head>
  <body>
    <p>This is an example paragraph. Anything in the <strong>body</strong> tag will appear on the page, just like this <strong>p</strong> tag and its contents.</p>
  </body>
</html>
```

Every HTML document starts with `<!doctype html>`. That just tells the web browser, "Hey, this is HTML here." And below that, every HTML document has a single `html` element, where everything else is located.

Inside of the `html` element, every page has a `head` element and a `body` element. The `head` has some information about the page that doesn't actually show up _on the page_. This information can help Google and other search engines find and categorize your website.

Inside the `head`, there's also always a `title`, which tells the web browser what to show in the browser tab and as the title of your website in search results.

Next, we'll cover the most interesting element!

---

## The `body` element

``` html
<body>
  <p>This is an example paragraph. Anything in the <strong>body</strong> tag will appear on the page, just like this <strong>p</strong> tag and its contents.</p>
</body>
```

Taking a closer look at just the body, you may have noticed that this is where everything that actually shows up on the page lives. Above, we can see a couple sentences inside a `p` element (short for _paragraph_), with some individual words wrapped in __strong__ tags (which most browsers translate as _bolded_).

Now let's go back to the joke.

---

## The joke explained

[![How do you annoy a web developer?](http://imgs.xkcd.com/comics/tags.png)](http://xkcd.com/1144/)

First, there's an opening `div` tag that's never closed and a closing `span` tag that's never opened. That's not valid HTML at all!

And that's why it's funny. To web developers, at least.

But what about the second half of the joke?

``` html
<A>: Like </a>this.
```

---

## Attributes

``` html
<A>: Like </a>this.
```

To understand this part, we have to first understand what a `a` element is. The `a` is short for anchor, which unfortunately is a pretty terrible name. What you should know is that these elements are almost always used for links.

Unfortunately, an anchor element by itself doesn't _mean_ anything. It doesn't link to anywhere. That's where __attributes__ come in. Let's say I want to link to google.com. I could rewrite opening tag above to:

``` html
<a href="http://www.google.com/">
```

Thanks to the `href` attribute (short for _hypertext reference_), clicking on `: Like ` will actually take you somewhere. Attributes are great for attaching more information to an element and you'll be introduced to more of them the more you work with HTML.

Now there are just a couple more annoying things in that code sample I'd like to go over.

---

## Code smells

``` html
<A>: Like </a>this.
```

A __code smell__ is code that makes you do this face:

![Grumpy cat](https://pbs.twimg.com/profile_images/616542814319415296/McCTpH_E_400x400.jpg)

In this case, the opening `a` tag is unnecessarily capitalized like this: `<A>`. Now that's not technically _wrong_ in HTML. It'll still work.

But it's not __convention__. You'll hear that word a lot. "It's not convention" just means, "It's not what most people do, so if other people see your code, they'll be confused. Technically, you can still do it if you want, but you better have a good reason."

That code is also annoying because this is what it renders to: [: Like&nbsp;](). Go ahead, put your mouse over it. It has unnecessary spaces on both sides and includes a colon before it. It looks like a typo.

Now you get the whole joke! Yay!

---

## Self-closing tags

There's one more kind of tag you'll see in the wild. It's the mystical __self-closing tag__, like the snake that eats its own tail.

![Snake that eats its own tail](http://www.adweek.com/fishbowlny/files/original/300px-Ouroboros.png)

Here are a few examples:

``` html
<hr>
<img src="http://www.lansing.codes/dist/images/icon-tall-square-fixed-300-transparent.png" alt="Lansing Code Lab Logo">
<input type="text" placeholder="Username">
```

You may also see them with the optional `/` at the end:

``` html
<hr/>
<img src="http://www.lansing.codes/dist/images/icon-tall-square-fixed-300-transparent.png" alt="Lansing Code Lab Logo"/>
<input type="text" placeholder="Username"/>
```

Since the slash isn't necessary in modern HTML though, I recommend leaving it off.

The `hr` element creates a line break, like this:

<hr>

The `img` element displays an image (or just "Lansing Code Lab Logo" if the image fails to load):

<img src="http://www.lansing.codes/dist/images/icon-tall-square-fixed-300-transparent.png" alt="Lansing Code Lab Logo">

The `input` element creates a text input with the placeholder text "Username":

<input type="text" placeholder="Username">

---

## 10 essential HTML tags

Last time I checked, there were 89 different HTML tags, but we're going to start with just the 10 most common. Check out [this list of the 10 essential HTML tags](http://www.99lime.com/_bak/topics/you-only-need-10-tags/). Then take a stab at the project below!
