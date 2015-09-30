## Separating styles into a separate file

It's often helpful organizationally to separate our CSS from our HTML, so many developers will keep all their styles in a separate __style_sheet___, which we'll link to in our `head` element.

This is partly to keep that one file from getting too big, but also for [other, more philosophical reasons](http://alistapart.com/article/separationdilemma).

To put this into action, create a separate file that we'll call `style.css` and put it in the same folder as your HTML file. Then put all your styles in that file.

Now, to include the styles from your `style.css` file into the webpage, add this line inside your `head` element:

``` html
<link rel="stylesheet" type="text/css" href="style.css">
```

---

## Separating scripts into a separate file

Just like we pulled out our CSS, it's often helpful to separate our JavaScript into another file. You can call this one `script.js` and once again, let's put it in the same folder as your main HTML file.

To include it, we'll use a __script__ element with a `src` attribute, but nothing inside of it:

``` html
<script src="script.js"></script>
```
