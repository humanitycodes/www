## Separating styles into separate files

---

In web development, we like to separate our __content__ from our __presentation__. The content belongs in your HTML document, inside the body element. Then we'll typically keep all our styles in a separate __style_sheet___, which we'll link to in our head element.

This is partly to keep that one file from getting too big, but also for [other, more philosophical reasons](http://alistapart.com/article/separationdilemma).

---

To put this into action, create a separate file that we'll call `style.css`. It has to be in the same folder as your `.html` file. If you haven't already created a project folder to keep all your website files in, now would also be a good time to do that.

Now, to include the styles in `style.css` in your webpage, you can add this line inside your head element.

``` html
<link rel="stylesheet" type="text/css" href="style.css">
```

## Setup

Before we get started, remember how we created a separate file just for our CSS? Well, guess where our JavaScript belongs? You guessed it. In yet another separate file. You can call this one `script.js` and once again, it should be in the same folder as your main `.html` file.

To include it, we'll use a **script** element:

<pre><code data-trim>&lt;script src="script.js"&gt;&lt;/script&gt;</code></pre>

If you're wondering why this tag isn't self-closing when it has no contents, it's because JavaScript can also go *between* the opening and closing tags. It's just cleaner to point to a source in a separate file.
