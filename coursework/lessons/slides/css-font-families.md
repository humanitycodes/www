## serif and sans-serif

To change the font of all the text in our page, we can assign a font-family to the body class, like this:

``` css
body {
  font-family: serif;
}
```

`serif` is one of the two major kinds of fonts. It looks like this:

![serif](https://upload.wikimedia.org/wikipedia/commons/8/8c/Serif_and_sans-serif_02.png)

The other kind of font is `sans-serif`:

``` css
body {
  font-family: sans-serif;
}
```

It looks like this:

![sans-serif](https://upload.wikimedia.org/wikipedia/commons/a/a0/Serif_and_sans-serif_01.png)

The difference is that `serif` fonts have little ornamentations that are extraneous to the essential lines that make up that letter. Here are those ornamentations highlighted:

![serif highlighted](https://upload.wikimedia.org/wikipedia/commons/9/91/Serif_and_sans-serif_03.png)

`sans-serif` fonts do not have those ornamentations. The "sans" in `sans-serif` is actually French for "without" - meaning "without serifs".

You can use these two fonts _anywhere_. In any web browser, on any device. The problem is: they're boring.

---

## Font fallbacks

Good news! The `font-family` property can accept a comma-separated list of fonts, like below:

``` css
body {
  font-family: "Open Sans", "Helvetica Neue", Helvetica, Verdana, Arial, sans-serif;
}
```

That line will make the browser go through this list of instructions:

1. Try to use the `Open Sans` font if it's available on this system
2. If the previous font isn't available, try to use `Helvetica Neue`
3. If the previous font isn't available, try to use `Helvetica`
4. If the previous font isn't available, try to use `Verdana`
5. If the previous font isn't available, try to use `Arial`
6. If the previous font isn't available, try to use `sans-serif`

The general idea is that we specify our first choice, and if that one isn't available, we choose the next closest alternative, then the next closest, etc.

It's also important to note that for font names with a space in them, we had to wrap the name in quotes for it to work.

---

## Including an external font

I like Open Sans. It's a very nice font. And it's free too! The problem is it doesn't come with any operating system I know of. That means if we just specify it in a `font-family` property, even in the first position, it'll probably never actually be used. Because it'll never be available.

So let's make it available! [Google Web Fonts](https://www.google.com/fonts) is one website that hosts fonts for free and they happen to [have Open Sans](https://www.google.com/fonts#UsePlace:use/Collection:Open+Sans).

The easiest and usually best way to include the font is by adding a `link` element to the `head` of a page, like so:

``` html
<link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
```

Then when we specify it in our CSS, the text on our page should actually use it!

``` css
body {
  font-family: "Open Sans", "Helvetica Neue", Helvetica, Verdana, Arial, sans-serif;
}
```

But now that we're manually including Open Sans, do we still need to list fallbacks, like `Helvetica Neue`, `Helvetica`, etc? The answer is yes, for the following reasons:

- It may take a little time for the font to download on a user's first visit and we want what appears until then to be as close to Open Sans as possible.
- Google's font servers may not always work properly, making Open Sans temporarily unavailable.

---

## Including a local font

If you download a font you'd like to use, for example from [dafont.com](http://www.dafont.com/), then you'll need use the `@font-face` CSS rule to allow your stylesheet to use it. [This tutorial](https://css-tricks.com/snippets/css/using-font-face/) describes how.
