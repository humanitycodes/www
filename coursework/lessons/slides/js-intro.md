## What is JavaScript?

JavaScript is the programming language of the web and it runs in every modern browser. You can actually try it out right now. Remember [inspecting elements](https://developer.chrome.com/devtools/docs/elements)? Well, click on the _Console_ tab and you should see something like this:

![](https://www.dropbox.com/s/87e69bp7urzvp73/Screenshot%202014-11-21%2009.33.54.png?dl=1)

Now in that box try typing in:

``` javascript
alert('Blarg!')
```

Then press `Enter`.

You just executed your first JavaScript!

---

## JavaScript vs Java

Java is the name of another programming language and a lot of people become confused by the fact that JavaScript and Java have such similar names. Here are some FAQs:

__Q: So is JavaScript like a special kind of Java?__

A: Java is to JavaScript what Car is to Carpet. In other words, no relation at all.

__Q: Then why is Java in the name?__

A: Short answer: marketing. Here's the [long answer](http://en.wikipedia.org/wiki/JavaScript#History), if you're interested.

---

## Setup

Before we get started, we need a place to _put_ our JavaScript code. Just like we kept CSS in a `style` element, we'll keep JavaScript in a `script` element, like this:

``` html
<script>
  alert('blarg');
</script>
```

Try opening up a local HTML document in your editor and making that code the last element inside your `body` element.

---

## So what can JavaScript do?

Here's one example:

<div class="well">
  <h3>clikz pic 4 nu CAT!</h3>

  <img id="cat-picture" src="http://thecatapi.com/api/images/get" onclick="(function(){document.getElementById('cat-picture').src = 'http://thecatapi.com/api/images/get?' + new Date().getTime();})()">
</div>

Go ahead, click on that cat picture. Now do it again. Do you understand? Do you understand now the true power of JavaScript? It's __infinite cats__. And this power can be yours.

This is made possible with only these few lines of code:

``` html
<img id="cat-picture" src="http://thecatapi.com/api/images/get">

<script>
  document.getElementById('cat-picture').onclick = function(event) {
    this.src = "http://thecatapi.com/api/images/get?" + new Date().getTime();
  };
</script>
```

Now let's explain exactly what's going on here.

---

## Breaking it down

### The HTML

``` html
<img id="cat-picture" src="http://thecatapi.com/api/images/get">
```

We have a new kind of attribute on our `img` element: __id__. The `id` attribute is similar to the `class` attribute, except that no two elements can have the same `id`. It's unique. This is especially useful when we want to target a single, specific element with JavaScript.

### The JavaScript

``` javascript
document.getElementById('cat-picture').onclick = function() {
  this.src = "http://thecatapi.com/api/images/get?" + new Date().getTime();
}
```

The first line is saying _in our document ... get the element with the id "cat-picture" ... and when a visitor clicks on it ... do the stuff in this function_.

Our second line is inside of that function and it's saying _with this element the user just clicked on ... make the `src` (i.e. source) attribute equal to ... this text ... with the current time added to the end of the text_.

But what's this part?

``` javascript
"http://thecatapi.com/api/images/get?" + new Date().getTime();
```

We get a new cat picture every time we visit this URL. The reason we have a question mark at the end and then add the current time, is to force a new download (anything after a question mark in a URL is extra data that's ignored if the website isn't looking for it).

That forces a new download because web browsers are smart. If we change the `src` to the same image twice, the browser will say, "Hang on! I already have that image! I'll just show what I have." By adding that extra, constantly changing data (`getTime()` is to the millisecond), we're telling the browser that this is a new image.

---

## The possibilities

__Q: Can I do X in JavaScript?__

A: Almost certainly. Just Google it. Heck, there's probably even a JavaScript library you can download (that's code someone else already wrote and made freely available) that will make it super easy to do exactly what you're thinking of doing. There's a JavaScript library for _everything_.

__Q: Everything? Really? I bet there isn't a JavaScript library for -__

A: [Yes. There is.](http://theonion.github.io/fartscroll.js/)

__Q: OK, but what if I wanted to -__

A: [Yes, even that.](http://theonion.github.io/comcastifyjs/)
