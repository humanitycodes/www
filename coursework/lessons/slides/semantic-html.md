## What are `semantic` HTML elements?

Elements like `h1`, `p`, and `img` are all semantic - meaning they specifically describe what they contain. An `h1` contains the highest-level heading on a page, a `p` contains a paragraph, and an `img` is an image.

Not all elements are semantic though. Much of the time, web developers use a generic, non-semantic structural element: the __div__ (short for _document division_). A `div` can be anything, like a blog article, a sidebar, or a navigation menu. It's an element we use when nothing else seems right, most often used as a container for other elements.

---

## When would we use a `div`?

Let's say we have an image and a caption and we'd like to place them both in a nice container with a different background. It wouldn't be uncommon to find something like this:

``` html
<div class="image-with-caption">
  <img src="http://imgs.xkcd.com/comics/cat_proximity.png" title="Yes you are! And you're sitting there! Hi, kitty!" alt="Cat Proximity">
  <p class="caption">source: <a href="http://xkcd.com/231/">xkcd.com</a></p>
</div>
```

Here's what that renders to:

<div style="display: inline-block; margin: 0 auto 20px; background: #393735; border-radius: 10px; padding: 15px 5px; ">
  <img src="http://imgs.xkcd.com/comics/cat_proximity.png" title="Yes you are! And you're sitting there! Hi, kitty!" alt="Cat Proximity" style="margin: 0; border: none; border-radius: 10px;">
  <p style="color: white; text-align: center; margin: 0;">source: <a href="http://xkcd.com/231/" style="color: #D9B259;">xkcd.com</a></p>
</div>

Oh, not lookin' too bad! In this case, we also added classes like `image-with-caption` and `caption`, since the tags themselves didn't tell the whole story, so weren't specific enough to apply styles to.

While this works for applying styles, it's not a perfect solution.

---

## The problem with "unsemantic" elements

__The main problem is search engines__. Classes like "image-with-caption", "blog-post", or "navigation-menu" - Google and other search engines have no idea what they mean. There is no standard for how to use classes, so they cannot be used to make sense of your website.

So semantic HTML elements bring consistency. And here are some other reasons:

- When screen readers and other assistive technologies are scanning your website, it's easier for them to organize. It's similar to making a building wheelchair accessible. You want _everyone_ to be able to use your website without having to ask for help.
- Some semantic elements (such as `video`) come with special attributes that give them extra power, unique to their context.
- When browsing your code, it's easier to tell at a glance what everything is.

---

## The list of semantic elements

Now using the full scope of HTML elements, we can rewrite that last block of code in a way that makes search engines happy:

``` html
<figure>
  <img src="http://imgs.xkcd.com/comics/cat_proximity.png" title="Yes you are! And you're sitting there! Hi, kitty!" alt="Cat Proximity">
  <figcaption>source: <a href="http://xkcd.com/231/">xkcd.com</a></figcaption>
</figure>
```

It's important to note that you can't just make _any_ word an element, like `<catpicture>`. It has to be in the  [official list of HTML elements](https://developer.mozilla.org/en-US/docs/Web/HTML/Element). Otherwise, web browsers won't know how to interpret it and your page could break.
