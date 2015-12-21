## How we used to lay out websites

Once upon a time, in the early days of the web, people would use tables to lay out websites. Because... well, that was kind of the only option. But `table` is a _semantic_ element; it actually says something about the information inside of it - that it's a table of data. So we don't do that anymore, [except in emails](https://css-tricks.com/ideas-behind-responsive-emails/).

The `float` property, which is meant to help text flow around a webpage, has also been [abused pretty extensively for layouts](https://css-tricks.com/ideas-behind-responsive-emails/), but it's really tricky and can cause _so many_ problems. I still shudder, just thinking of those days.

But without tables or floats, how did people in recent history get layouts to work? Let's take this common example, for instance:

``` html
<div class="row">
  <div class="column">
    This is the 1st column.
  </div>
  <div class="column">
    This is the 2nd column.
  </div>
</div>
```

We have a row, with two columns inside it. In our case, we'd like these columns to show up side by side, each one taking up half the width of the containing row. We might code up some CSS like:

```
.column {
  width: 50%;
}
```

That should work, right? I'll add a few more styles, such as padding on the top and bottom of the row and some nice backgrounds to help us distinguish everything.

<p><div style="box-sizing:content-box;background:#efefef;padding: 10px 0;">
  <div style="background:rgb(127,178,189);width:50%;">
    This is the 1st column.
  </div>
  <div style="background:rgb(119, 175, 105);width:50%;">
    This is the 2nd column.
  </div>
</div></p>

Uhh... it didn't work. Inspecting the first column with your web browser's developer tools, you can see that there's a right margin being added to fill up the rest of the row:

![Implicit margin on display block](https://www.dropbox.com/s/tl8hr72c7yypfgo/Screenshot%202015-12-19%2012.08.02.png?dl=1)

That's because `div`s, by default, have the property `display: block`, which means they should take up the entire width of their container. The browser fills in a margin to make sure nothing shows up alongside the `div`.

To fix this, we can change how our items display with: `display: inline-block`. So now we have:

```
.column {
  display: inline-block;
  width: 50%;
}
```

<p><div style="box-sizing:content-box;background:#efefef;padding: 10px 0;">
  <div style="background:rgb(127,178,189);display:inline-block;width:50%;">
    This is the 1st column.
  </div>
  <div style="background:rgb(119, 175, 105);display:inline-block;width:50%;">
    This is the 2nd column.
  </div>
</div></p>

What?! That didn't work either? Inspecting the first column, we can see there isn't any margin added. So... just to experiment, let's temporarily change the width of columns to `40%`:

```
.column {
  display: inline-block;
  width: 40%;
}
```

And we get:

<p><div style="box-sizing:content-box;background:#efefef;padding: 10px 0;">
  <div style="background:rgb(127,178,189);display:inline-block;width:40%;">
    This is the 1st column.
  </div>
  <div style="background:rgb(119,175,105);display:inline-block;width:40%;">
    This is the 2nd column.
  </div>
</div></p>

What's that space between the two columns? It doesn't seem to be a margin. Googling, "display inline-block space between elements", it looks like [we're not the only ones to encounter this problem](https://css-tricks.com/fighting-the-space-between-inline-block-elements/). The newline between our columns is being interpreted as a space. So we could change our HTML to:

``` html
<div class="row">
  <div class="column">
    This is the 1st column.
  </div><div class="column">
    This is the 2nd column.
  </div>
</div>
```

Let's see if it worked:

<p><div style="box-sizing:content-box;background:#efefef;padding: 10px 0;">
  <div style="background:rgb(127,178,189);display:inline-block;width:40%;">
    This is the 1st column.
  </div><div style="background:rgb(119, 175, 105);display:inline-block;width:40%;">
    This is the 2nd column.
  </div>
</div></p>

Alright, so we that got rid of the space. But... changing our HTML to affect the styling of our page seems weird. And it'd be too easy for someone else to see that, assume it's a typo, and change it back.

So there's another solution we can use. There won't be any space if the font size is 0. So we set the font-size on the row to 0, then font size on the column back to `16px`, so that we can still see our column text.

```
.row {
  font-size: 0;
}
.column {
  display: inline-block;
  width: 40%;
  font-size: 16px;
}
```

<p><div style="box-sizing:content-box;background:#efefef;padding: 10px 0;font-size:0">
  <div style="background:rgb(127,178,189);display:inline-block;width:40%;font-size:16px">
    This is the 1st column.
  </div><div style="background:rgb(119, 175, 105);display:inline-block;width:40%;font-size:16px">
    This is the 2nd column.
  </div>
</div></p>

Excellent! Still hacky, but it looks slightly better. Now that we have a working solution, let's change our css back to `width: 50%`.

```
.row {
  font-size: 0;
}
.column {
  display: inline-block;
  width: 50%;
  font-size: 16px;
}
```

And just to make sure it still works:


<p><div style="box-sizing:content-box;background:#efefef;padding: 10px 0;font-size:0">
  <div style="background:rgb(127,178,189);display:inline-block;width:50%;font-size:16px">
    This is the 1st column.
  </div><div style="background:rgb(119, 175, 105);display:inline-block;width:50%;font-size:16px">
    This is the 2nd column.
  </div>
</div></p>

Beautiful! That seemed a lot more painful than it should have been, but it works now.

---

## This is why we can't have nice ~~things~~ layouts

Now let's just add a little padding to columns, so that the text isn't right up against the edge:

```
.row {
  font-size: 0;
}
.column {
  display: inline-block;
  width: 50%;
  padding: 10px;
  font-size: 16px;
}
```

And looking at the result:

<p><div style="box-sizing:content-box;background:#efefef;padding: 10px 0;font-size:0">
  <div style="box-sizing:content-box;background:rgb(127,178,189);display:inline-block;width:50%;font-size:16px;padding:10px">
    This is the 1st column.
  </div><div style="box-sizing:content-box;background:rgb(119, 175, 105);display:inline-block;width:50%;font-size:16px;padding:10px;">
    This is the 2nd column.
  </div>
</div></p>

Are you @#%&ing kidding me?! Padding breaks everything?

After some more desperate Googling, we stumble on the `box-sizing` property. There are two possible values: `content-box` and `border-box`. The default is `content-box`. This is the difference:

[![content-box vs border-box](http://www.binvisions.com/wp-content/uploads/2011/09/css-box-model-border-content_590x328.jpg)](http://www.binvisions.com/articles/box-sizing-property-difference-content-border/)

So in our layout, let's say our row is 500 pixels wide. Each column is set to be 50% the width of its container, so that's 250 pixels. How `box-sizing: content-box` works, is it adds our padding _after_ calculating our width, instead of including it in the calculation.

So the _real_ width of our columns becomes 250 pixels _plus_ 20 pixels (10 on each side), totaling 270 pixels wide each. This makes our columns once again stack on top of each other, because they won't fit next to each other.

This default setting has caused so much frustration that Chris Coyier has declared February 1st [International `box-sizing` Awareness Day](https://css-tricks.com/international-box-sizing-awareness-day/).

[![border-box 4lyfe](https://cdn.css-tricks.com/wp-content/uploads/2014/02/mega-protest-city-yah1.svg)](https://css-tricks.com/international-box-sizing-awareness-day/)

CSS frameworks like [Bootstrap](http://getbootstrap.com/) and [Foundation](http://foundation.zurb.com/) actually override `box-sizing` to be use `border-box` everywhere. I recommend you do the same with:

```
html {
  box-sizing: border-box;
}
*, *:before, *:after {
  box-sizing: inherit;
}
```

So now with our updated CSS:

```
html {
  box-sizing: border-box;
}
*, *:before, *:after {
  box-sizing: inherit;
}
.row {
  font-size: 0;
}
.column {
  display: inline-block;
  width: 50%;
  padding: 10px;
  font-size: 16px;
}
```

And now we have have our padding without messing up the layout!

<p><div style="background:#efefef;padding: 10px 0;font-size:0">
  <div style="background:rgb(127,178,189);display:inline-block;width:50%;font-size:16px;padding:10px">
    This is the 1st column.
  </div><div style="background:rgb(119, 175, 105);display:inline-block;width:50%;font-size:16px;padding:10px;">
    This is the 2nd column.
  </div>
</div></p>

But say we want a 10 pixel margin between these two columns? We can add `margin: 0 5px` (meaning we want no margin on the top or bottom, but 5 pixels on either side). I use 5 pixels instead of 10 pixels, because the two will add up in the middle. Then we have to employ a few new tricks.

First, since I don't want any margin to the left of the first column or to the right of the last column, I'll define `margin: 0 -5px`. Yes, you read that right. It's a __negative margin__ on the sides. Instead of adding space between the edge of the container, it'll pull an element _beyond_ the edge of its container.

Second, we need to calculate the width of our columns a little better, because even `box-sizing: border-box` won't include margins in width calculations. We need to subtract our margin from the the width manually, which we can do with the `calc` function in CSS: `width: calc(50% - 10px)`.

Altogether, here's our new CSS:

```
html {
  box-sizing: border-box;
}
*, *:before, *:after {
  box-sizing: inherit;
}
.row {
  margin: 0 -5px; /* NEW */
  font-size: 0;
}
.column {
  display: inline-block;
  width: calc(50% - 10px); /* CHANGED */
  padding: 10px;
  margin: 0 5px; /* NEW */
  font-size: 16px;
}
```

And here's how it renders:

<p><div style="background:#efefef;padding: 10px 0;font-size:0;margin:0 -5px">
  <div style="background:rgb(127,178,189);display:inline-block;width:calc(50% - 10px);font-size:16px;padding:10px;margin:0 5px">
    This is the 1st column.
  </div><div style="background:rgb(119, 175, 105);display:inline-block;width:calc(50% - 10px);font-size:16px;padding:10px;margin:0 5px">
    This is the 2nd column.
  </div>
</div></p>

You'll notice that the margin on the left and right _is_ visible right now, but only because we've given our row `div` a background, which we normally wouldn't do. So ignoring that, we can see by inspecting the page that the edges of our column line up perfectly with the edges of our content.

![Layout with visible content edges](https://www.dropbox.com/s/8wps5sk3ic1kk2j/Screenshot%202015-12-19%2013.45.11.png?dl=1)

Now it's important to note that as of writing, the `calc` function will not work for about 3% of the web browser market in the United States. You can [check out the exact breakdown](http://caniuse.com/#search=calc) to figure out whether this matters to you for a specific website.

Finally, there's one other problem with this solution. What if one column has more stuff in it than the other column?

<p><div style="background:#efefef;padding: 10px 0;font-size:0;margin:0 -5px">
  <div style="background:rgb(127,178,189);display:inline-block;width:calc(50% - 10px);font-size:16px;padding:10px;margin:0 5px">
    This is the 1st column.
  </div><div style="background:rgb(119, 175, 105);display:inline-block;width:calc(50% - 10px);font-size:16px;padding:10px;margin:0 5px">
    This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column.
  </div>
</div></p>

Yuck. The first column shows up way at the bottom. Fortunately, this can be fixed with a simple `vertical-align: top` on the columns.

<p><div style="background:#efefef;padding: 10px 0;font-size:0;margin:0 -5px">
  <div style="background:rgb(127,178,189);display:inline-block;width:calc(50% - 10px);font-size:16px;padding:10px;margin:0 5px;vertical-align:top">
    This is the 1st column.
  </div><div style="background:rgb(119, 175, 105);display:inline-block;width:calc(50% - 10px);font-size:16px;padding:10px;margin:0 5px;vertical-align:top">
    This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column.
  </div>
</div></p>

But sometimes, I want columns to be as tall as each other. I could use `display: table-cell` on the columns to use tables _without_ actually using the semantic table elements, but then I lose my margins (because table cells don't support margins) and have to resort back to `width: 50%` instead of the fancy `calc`ulation, because calculating table cell width with `calc` also isn't allowed.

<p><div style="background:#efefef;padding: 10px 0;font-size:0">
  <div style="background:rgb(127,178,189);display:table-cell;width:50%;font-size:16px;padding:10px;vertical-align:top">
    This is the 1st column.
  </div><div style="background:rgb(119, 175, 105);display:table-cell;width:50%;font-size:16px;padding:10px;vertical-align:top">
    This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column.
  </div>
</div></p>

But! I _could_ add a border to these columns, which just happens to use the same color as the background of its container. Then for my row `div`, I'll re-add `margin: 0 -5px`. Now everything works as it did before, with columns the same height.

<p><div style="background:#efefef;padding: 10px 0;font-size:0;margin:0 -5px">
  <div style="background:rgb(127,178,189);display:table-cell;width:50%;font-size:16px;padding:10px;vertical-align:top;border:5px solid #efefef">
    This is the 1st column.
  </div><div style="background:rgb(119, 175, 105);display:table-cell;width:50%;font-size:16px;padding:10px;vertical-align:top;border:5px solid #efefef">
    This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column.
  </div>
</div></p>

If this feels hacky to you, you're not alone. But believe it or not, this was also _normal_ until very recently. On the next page, we'll learn how you can set up two freakin' columns without jumping through hoop after hoop.

---

## Using flexbox layouts for equal-width columns

So now you're up to speed with how layouts have been managed up until very recently. I went over these because you're still likely to encounter examples in the wild. Now when you see them, you'll be familiar with their limitations and what you can do to get around them.

When you're building new websites from scratch though, you _should_ be using __flexbox__. For the simplest layout, we can just use:

```
.row {
  display: flex;
}
.column {
  width: 50%;
}
```

And the result:

<p><div style="background:#efefef;padding: 10px 0;display:flex">
  <div style="background:rgb(127,178,189);width:50%;padding:10px">
    This is the 1st column.
  </div><div style="background:rgb(119,175,105);width:50%;padding:10px">
    This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column.
  </div>
</div></p>

When we add our margin with the negative margin trick:

```
.row {
  display: flex;
  margin: 0 -5px;
}
.column {
  width: 50%;
  margin: 0 5px;
}
```

It still works:

<p><div style="background:#efefef;padding: 10px 0;display:flex;margin:0 -5px">
  <div style="background:rgb(127,178,189);width:50%;padding:10px;margin:0 5px">
    This is the 1st column.
  </div><div style="background:rgb(119,175,105);width:50%;padding:10px;margin:0 5px">
    This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column.
  </div>
</div></p>

What if we wanted 3 columns?

```
.row {
  display: flex;
  margin: 0 -5px;
}
.column {
  width: 33.33333333333%;
  margin: 0 5px;
}
```

<p><div style="background:#efefef;padding: 10px 0;display:flex;margin:0 -5px">
  <div style="background:rgb(127,178,189);width:33.33333333333%;padding:10px;margin:0 5px">
    This is the 1st column.
  </div>
  <div style="background:rgb(119,175,105);width:33.33333333333%;padding:10px;margin:0 5px">
    This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column. This is the 2nd column.
  </div>
  <div style="background:rgb(127,178,189);width:33.33333333333%;padding:10px;margin:0 5px">
    This is the 3rd column.
  </div>
</div></p>

Notice how we didn't even have to use `calc` here? But this is just scratching the surface. We can be smarter than this. We don't even have to know how many columns we have ahead of time. If we want all our columns to be the same width, we can use `flex-basis` and `flex-grow`.

```
.row {
  display: flex;
  margin: 0 -5px;
}
.column {
  flex-basis: 0; // All columns start at size 0
  flex-grow: 1; // As columns grow to fit the container, they
                // should maintain a 1:1 ratio with each other
  margin: 0 5px;
}
```

This is the result, with 5 columns:

<p><div style="background:#efefef;padding: 10px 0;display:flex;margin:0 -5px">
  <div style="background:rgb(127,178,189);flex-basis:0;flex-grow:1;padding:10px;margin:0 5px">
    1st column
  </div>
  <div style="background:rgb(119,175,105);flex-basis:0;flex-grow:1;padding:10px;margin:0 5px">
    2nd column
  </div>
  <div style="background:rgb(127,178,189);flex-basis:0;flex-grow:1;padding:10px;margin:0 5px">
    3rd column
  </div>
  <div style="background:rgb(119,175,105);flex-basis:0;flex-grow:1;padding:10px;margin:0 5px">
    4th column
  </div>
  <div style="background:rgb(127,178,189);flex-basis:0;flex-grow:1;padding:10px;margin:0 5px">
    5th column
  </div>
</div></p>

It's probably still difficult to understand exactly what `flex-basis` and `flex-grow` are doing right now. Don't worry, they'll make more sense as you see more examples on the following pages!

---

## Using flexbox layouts for sidebars

Now let's say we have a 3 column layout. The main content area in the middle and sidebars on either side. Like this:

``` html
<div class="container">
  <aside class="sidebar">Sidebar 1</aside>
  <main>Main content area</main>
  <aside class="sidebar">Sidebar 2</aside>
</div>
```

Now we want our main content area to be 3 times the size of our sidebars. We can accomplish this with:

```
.container {
  display: flex;
}
main, .sidebar {
  flex-basis: 0;
}
main {
  flex-grow: 3;
}
.sidebar {
  flex-grow: 1;
}
```

We're setting `main` to grow 3 times as fast as `.sidebar` with `flex-grow`. The result:

<p><div style="padding:10px 0;background:#efefef;display:flex">
  <div style="background:rgb(127,178,189);flex-basis:0;flex-grow:1">Sidebar 1</div>
  <div style="background:rgb(119,175,105);flex-basis:0;flex-grow:3">Main content area</div>
  <div style="background:rgb(127,178,189);flex-basis:0;flex-grow:1">Sidebar 2</div>
</div></p>

Now the more common case might be to have fixed widths for the sidebars, then wanting the main content to fill in the rest:

```
.container {
  display: flex;
}
main {
  flex-basis: 0;
  flex-grow: 3;
}
.sidebar {
  flex-basis: 150px;
  flex-grow: 0;
}
```

Now we've given the sidebars a `flex-basis` (starting size) of 150 pixels and completely removed their ability to grow to fit the container, they never grow larger than 150 pixels. This is the result:

<p><div style="padding:10px 0;background:#efefef;display:flex">
  <div style="background:rgb(127,178,189);flex-basis:150px;flex-grow:0">Sidebar 1</div>
  <div style="background:rgb(119,175,105);flex-basis:0;flex-grow:1">Main content area</div>
  <div style="background:rgb(127,178,189);flex-basis:150px;flex-grow:0">Sidebar 2</div>
</div></p>

It's important to know that as the screen gets very small, the sidebars will still _shrink_ to make sure there's room to show the content in `main`. If you wanted to make sure the sidebars remained 150 pixels wide _no matter what_, you could also add `flex-shrink: 0`.

---

## Using flexbox layouts for image galleries

In the case of image galleries, you may have so many images that displaying them all next to each other would be impossible. Here's what our HTML might look:

``` html
<div class="image-gallery">
  <img src="http://lorempixel.com/150/150/cats" alt="Cat">
  <img src="http://lorempixel.com/150/150/cats" alt="Cat">
  <img src="http://lorempixel.com/150/150/cats" alt="Cat">
  ...
</div>
```

In this case, we'll want to use `flex-wrap: wrap`, so that when there are a lot of items, they can wrap onto the next row.

```
.image-gallery {
  display: flex;
  flex-wrap: wrap;
}
```

<p><div style="padding:10px 0;background:#efefef;display:flex;flex-wrap:wrap">
  <img style="" src="http://lorempixel.com/150/150/cats">
  <img style="" src="http://lorempixel.com/150/150/cats">
  <img style="" src="http://lorempixel.com/150/150/cats">
  <img style="" src="http://lorempixel.com/150/150/cats">
  <img style="" src="http://lorempixel.com/150/150/cats">
  <img style="" src="http://lorempixel.com/150/150/cats">
</div></p>

Maybe just a bit of margin to space things out a bit? And let's also center the images with `justify-content: center`. `justify-content` is a special property that for distributing the space between and around flex items.

```
.image-gallery {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}
.image-gallery > img {
  margin: 5px;
}
```

<p><div style="padding:10px 0;background:#efefef;display:flex;flex-wrap:wrap;justify-content:center">
  <img style="margin:5px" src="http://lorempixel.com/150/150/cats">
  <img style="margin:5px" src="http://lorempixel.com/150/150/cats">
  <img style="margin:5px" src="http://lorempixel.com/150/150/cats">
  <img style="margin:5px" src="http://lorempixel.com/150/150/cats">
  <img style="margin:5px" src="http://lorempixel.com/150/150/cats">
  <img style="margin:5px" src="http://lorempixel.com/150/150/cats">
</div></p>

Very nice! Now what happens when we have differently sized images?

<p><div style="padding:10px 0;background:#efefef;display:flex;flex-wrap:wrap;justify-content:center">
  <img style="margin:5px" src="http://lorempixel.com/450/400/cats">
  <img style="margin:5px" src="http://lorempixel.com/200/150/cats">
  <img style="margin:5px" src="http://lorempixel.com/175/150/cats">
  <img style="margin:5px" src="http://lorempixel.com/150/190/cats">
  <img style="margin:5px" src="http://lorempixel.com/200/180/cats">
  <img style="margin:5px" src="http://lorempixel.com/350/300/cats">
</div></p>

Uhh, that's OK, I guess. I'd rather have everything with the same width though, so let's bring back `flex-basis`, setting it to 150 pixels, because we know every image will be _at least_ that wide.

```
.image-gallery {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}
.image-gallery > img {
  flex-basis: 150px;
  margin: 5px;
}
```

<p><div style="padding:10px 0;background:#efefef;display:flex;flex-wrap:wrap;justify-content:center">
  <img style="margin:5px;flex-basis:150px" src="http://lorempixel.com/450/400/cats">
  <img style="margin:5px;flex-basis:150px" src="http://lorempixel.com/200/150/cats">
  <img style="margin:5px;flex-basis:150px" src="http://lorempixel.com/175/150/cats">
  <img style="margin:5px;flex-basis:150px" src="http://lorempixel.com/150/190/cats">
  <img style="margin:5px;flex-basis:150px" src="http://lorempixel.com/200/180/cats">
  <img style="margin:5px;flex-basis:150px" src="http://lorempixel.com/350/300/cats">
</div></p>

Ewww... they're all squooshed. As we've seen before, flexbox stretches the heights of children, which does _weird_ things with images. So let's wrap each image in their own container:

``` html
<div class="image-gallery">
  <div class="image-container">
    <img src="http://lorempixel.com/450/400/cats" alt="Cat">
  </div>
  <div class="image-container">
    <img src="http://lorempixel.com/200/150/cats" alt="Cat">
  </div>
  <div class="image-container">
    <img src="http://lorempixel.com/175/150/cats" alt="Cat">
  </div>
  ...
</div>
```

And then update our CSS:

```
.image-gallery {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}
.image-gallery > .image-container {
  flex-basis: 150px;
  margin: 5px;
}
.image-container > img {
  width: 100%;
}
```

<p><div style="padding:10px 0;background:#efefef;display:flex;flex-wrap:wrap;justify-content:center">
  <div style="margin:5px;flex-basis:150px">
    <img src="http://lorempixel.com/450/400/cats">
  </div>
  <div style="margin:5px;flex-basis:150px">
    <img src="http://lorempixel.com/200/150/cats">
  </div>
  <div style="margin:5px;flex-basis:150px">
    <img src="http://lorempixel.com/175/150/cats">
  </div>
  <div style="margin:5px;flex-basis:150px">
    <img src="http://lorempixel.com/150/190/cats">
  </div>
  <div style="margin:5px;flex-basis:150px">
    <img src="http://lorempixel.com/200/180/cats">
  </div>
  <div style="margin:5px;flex-basis:150px">
    <img src="http://lorempixel.com/350/300/cats">
  </div>
</div></p>

Much better! Sometimes though, setting a fixed width (like 150 pixels) isn't _exactly_ what we want. What if we wanted our flex item widths to be more dynamic and guarantee they stretch to fill the entire container width?

All we have to do is update `flex-basis` to `calc(33.33333333333% - 10px)`. Notice that when we're spreading flexboxes across more than row, we _do_ need `calc` again. Why isn't flexbox smart enough with multiple rows? It managed just fine when we had just a single row. Honestly, I have no idea. This is just what works.

```
.image-gallery {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}
.image-gallery > .image-container {
  flex-basis: calc(33.33333333333% - 10px);
  margin: 5px;
}
.image-container > img {
  width: 100%;
}
```

<p><div style="padding:10px 0;background:#efefef;display:flex;flex-wrap:wrap;justify-content:center">
  <div style="margin:5px;flex-basis:calc(33.33333333333% - 10px)">
    <img style="width:100%" src="http://lorempixel.com/450/400/cats">
  </div>
  <div style="margin:5px;flex-basis:calc(33.33333333333% - 10px)">
    <img style="width:100%" src="http://lorempixel.com/200/150/cats">
  </div>
  <div style="margin:5px;flex-basis:calc(33.33333333333% - 10px)">
    <img style="width:100%" src="http://lorempixel.com/175/150/cats">
  </div>
  <div style="margin:5px;flex-basis:calc(33.33333333333% - 10px)">
    <img style="width:100%" src="http://lorempixel.com/150/190/cats">
  </div>
  <div style="margin:5px;flex-basis:calc(33.33333333333% - 10px)">
    <img style="width:100%" src="http://lorempixel.com/200/180/cats">
  </div>
  <div style="margin:5px;flex-basis:calc(33.33333333333% - 10px)">
    <img style="width:100%" src="http://lorempixel.com/350/300/cats">
  </div>
</div></p>

---

## Where to master flexbox

This is just the tip of the iceberg with flexbox. I've shared the properties I think you'll find most useful, but you'll likely encounter situations where you need to know more. In this case, I recommend [CSS Tricks' _Complete Guide to Flexbox_](https://css-tricks.com/snippets/css/a-guide-to-flexbox/). It covers every flexbox property, with detailed explanations and examples for each.

If your brain is feeling pretty full right now, you can come back here when you're coding up a layout. If you're feeling ready for more, you can go ahead and skim that page, so that you have a better idea of what else is possible.

---

## Using column properties for multi-column text

There's one other set of properties that can sometimes achieve what flexbox can't: __CSS columns__. Columns are a way to automatically spread out text content between multiple columns, within a single element. Let's take this paragraph for example.

``` html
<p class="columns-2">
  Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
<p>
```

Say we want to split it into 2 columns, with 20 pixels between each column. We can use `column-count: 2` and `column-gap: 20px` to achieve this. The column CSS properties are relatively new though, so as of writing, you'll have to include a few browser prefixes whenever using them for optimal browser support - like this:

```
.columns-2 {
  -webkit-column-count: 2;
  -moz-column-count: 2;
  column-count: 2;
  -webkit-column-gap: 20px;
  -moz-column-gap: 20px;
  column-gap: 20px;
}
```

Here's the result:

<p style="-webkit-column-count:2;-moz-column-count:2;column-count:2;-webkit-column-gap:20px;-moz-column-gap: 20px;column-gap:20px;">
  Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
</p>

Pretty simple, eh? Column properties aren't supported in Internet Explorer 9 and below though (about 4% of the United States as of writing), so if you know people who use those browsers, make them stop it! Don't they realize they're messing up your beautiful columns?!

---

## Using column properties for mosaic image layouts

Just as we spread text evenly across multiple columns, we can do the same with other elements - like images!

<p><div style="-webkit-column-count: 3;-moz-column-count: 3;column-count: 3;-webkit-column-gap: 10px;-moz-column-gap: 10px;column-gap: 10px;">
  <div data-count="1"  class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&1">
  </div>
  <div data-count="2"  class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&2">
  </div>
  <div data-count="3"  class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&3">
  </div>
  <div data-count="4" class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&4">
  </div>
  <div data-count="5" class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&5">
  </div>
  <div data-count="6" class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&6">
  </div>
  <div data-count="7" class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&7">
  </div>
  <div data-count="8" class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&8">
  </div>
  <div data-count="9" class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&9">
  </div>
  <div data-count="10" class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&10">
  </div>
  <div data-count="11" class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&11">
  </div>
  <div data-count="12" class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&12">
  </div>
  <div data-count="13" class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&13">
  </div>
  <div data-count="14" class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&14">
  </div>
  <div data-count="15" class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&15">
  </div>
  <div data-count="16" class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&16">
  </div>
  <div data-count="17" class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&17">
  </div>
  <div data-count="18" class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&18">
  </div>
  <div data-count="19" class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&19">
  </div>
  <div data-count="20" class="example-mosaic-image">
    <img style="margin-bottom:10px" src="http://thecatapi.com/api/images/get?format=src&type=jpg&20">
  </div>
</div></p>

<style>
.example-mosaic-image {
  position: relative;
}
.example-mosaic-image:after {
  content: attr(data-count);
  position: absolute;
  top: 0;
  left: 0;
  width: 30px;
  height: 30px;
  line-height: 30px;
  background: rgba(255,255,255,0.9);
  text-align: center;
  border-bottom-right-radius: 3px;
}
</style>

It's a beautiful mosaic! I've also added numbers to the corners so you can see the images flowing down, then to the top of the next column, just like text does.

Achieving this neat trick only requires something like this:

``` html
<div class="image-mosaic">
  <img src="http://thecatapi.com/api/images/get?format=src&type=jpg&1" alt="Cat">
  <img src="http://thecatapi.com/api/images/get?format=src&type=jpg&2" alt="Cat">
  <img src="http://thecatapi.com/api/images/get?format=src&type=jpg&3" alt="Cat">
  ...
</div>
```

```
.image-mosaic {
  -webkit-column-count: 3;
  -moz-column-count: 3;
  column-count: 3;
  -webkit-column-gap: 10px;
  -moz-column-gap: 10px;
  column-gap: 10px;
}
.image-mosaic > img {
  width: 100%;
  margin-bottom: 10px;
}
```

Previously, this kind of magic was only achievable with JavaScript and I actually meet very few people who realize this is possible with CSS alone!
