## What's a `transition`?

Hover your mouse over the button below:

<style>
#obvious-background-transition {
  transition: all 2s;
}
#obvious-background-transition:hover {
  background: #376638;
  color: white;
}
</style>

<p><button id="obvious-background-transition" class="btn btn-default btn-block">Hover me!</button></p>

Notice how it very slowly _transitions_ from a white button, with black text - to a green button, with white text?

Here's the CSS that makes the magic happen:

```
button {
  transition: all 2s;
}
button:hover {
  background: #376638;
  color: white;
}
```

Looking at the line `transition: all 2s`, the `all` is specifying which properties we want to to smoothly transition. In this case, we're just saying we want all of them. The `2s` specifies how long we want the transition to be. `2s` means `2 seconds`.

That's a very obvious transition, but it doesn't look very nice. Usually, the transition effects you'll want to use will be more subtle. Take these buttons for example:

<p>
  <button class="btn btn-default">No transition</button>
  <button class="btn btn-default" style="transition: all 0.5s;">Half second transition</button>
  <button class="btn btn-default" style="transition: all 2s;">2 second transition</button>
</p>

When you hover over them, the middle button, with a `transition: background 0.5s`, is just about right for a subtle effect. And the background color we're transitioning to is just a few shades darker than the white.

---

## Which properties can be transitioned?

Not all properties can be transitioned, but quite a few can. Check out [the full list](http://www.w3.org/TR/css3-transitions/#animatable-properties) if you're curious. We've already seen `background` and `color`, but below, I'm transitioning `margin` and `box-shadow` below to create a pressable button effect.

<style>
  #fancy-press {
    /* Base styles */
    padding: 10px;
    background-color: #228c50;
    color: white;
    border: 0;
    border-radius: 3px;
    /* Pressable styles */
    margin-top: -3px;
    margin-bottom: 0;
    box-shadow: 0 4px 0 #1d422d;
    transition: all 0.3s;
  }
  #fancy-press:active {
    margin-top: 0;
    margin-bottom: -3px;
    box-shadow: 0 1px 0 #1d422d;
  }
  #fancy-press:focus { outline: none; }
</style>

<p><button id="fancy-press" class="btn-block">Press me - I'm a fancy button!</button></p>

The heavy lifting is done by this CSS:

```
#fancy-button {
  margin-top: -3px;
  margin-bottom: 0;
  box-shadow: 0 4px 0 #1d422d;
  transition: all 0.3s;
}
#fancy-button:active {
  margin-top: 0;
  margin-bottom: -3px;
  box-shadow: 0 1px 0 #1d422d;
}
```

At the time of writing, transitions are also being used on Twitter.com, for the Tweet button and for menu items along the top navigation. Try visiting a few of your favorite websites now and see if you can spot any other transitions on hover.

---

## Browser support

We're getting into some more advanced (and more recently introduced) CSS features now. That means we need to talk about browser support.

### How do you know if a CSS property is widely supported?

In an ideal world, everything would always work - and work exactly the same way - in every browser. The reality is website visitors use many different versions of many different browsers.

Which means you may need to be careful with features that have less than near-100% support. But how can you tell whether you can use a specific HTML or CSS feature? I present to you: [caniuse.com](http://caniuse.com/). Yes, there's a website dedicated specifically to answering this question.

[![Can I use: CSS transitions?](https://www.dropbox.com/s/vknawlaz50j3k84/Screenshot%202015-11-06%2011.47.41.png?dl=1)](http://caniuse.com/#feat=css-transitions)

Taking a look at [the caniuse page for CSS transitions](http://caniuse.com/#feat=css-transitions), you can see that IE 8, IE 9, and Opera Mini 8 don't support CSS transitions at all. If you visit the page and hover over those individual cells, you can see the percentage of web traffic that uses these browsers, both globally and also just for the United States. Summed up, it looks like at the time of writing, only 94.52% of visits can handle CSS transitions. Globally, it's 90.33%.

That means for most websites, you'll want to be careful about using CSS transitions for any _critical_ features. You can use them to subtly improve the experience for most visitors, but you should make sure you're website still works without them. We call this strategy __graceful degradation__. On older and less progressive browsers, your website should simply be less pretty, rather than break completely.

### Vendor prefixes

The caniuse website also mentions with little yellow tags whether you might need to use a special "vendor prefix" in order to support a specific browser version. Before CSS transitions were more widely supported, we'd have to define them with something like this:

```
-webkit-transition: background-color 1s;
-moz-transition: background-color 1s;
-o-transition: background-color 1s;
transition: background-color 1s;
```

`-webkit-`, `-moz-`, and `-o-` are all vendor prefixes. The people who build web browsers will use these in case their specific implementation of a new feature acts a little differently than it does in most other browsers. This way, you can define slightly different rules for different browsers if you need to.

CSS transitions are pretty widely supported now though, so looking at [the caniuse page](http://caniuse.com/#feat=css-transitions), it seems the most you might need is the `-webkit-` prefix for older versions of Android:

```
-webkit-transition: background-color 1s;
transition: background-color 1s;
```

From now on, whenever you're learning about new HTML or CSS properties, and you feel unsure about whether you can safely use them, take a quick visit to caniuse.com and look it up.

---

## What's a `transform`?

Transforms aren't used as often as transitions, but they're often used together. Let's add a transform the fancy button we just made. Go ahead and hover over it.

<style>
  #fancy-press {
    /* Base styles */
    padding: 10px;
    background-color: #228c50;
    color: white;
    border: 0;
    border-radius: 3px;
    /* Pressable styles */
    margin-top: -3px;
    margin-bottom: 0;
    box-shadow: 0 4px 0 #1d422d;
    transition: all 0.3s;
  }
  #fancy-press:hover {
    -webkit-transform: scale(1.3);
    -ms-transform: scale(1.3);
    transform: scale(1.3);
  }
  #fancy-press:active {
    margin-top: 0;
    margin-bottom: -3px;
    box-shadow: 0 1px 0 #1d422d;
  }
  #fancy-press:focus { outline: none; }
</style>

<p><button id="fancy-press" class="btn-block">Press me - I'm a fancy button!</button></p>

Woah! It got bigger when we hovered over it! That was achieved by adding:

```
#fancy-press:hover {
  -webkit-transform: scale(1.3);
  -ms-transform: scale(1.3);
  transform: scale(1.3);
}
```

As you'll notice, we added a few vendor prefixes as well, for broader support. Looking at [the caniuse page](http://caniuse.com/#feat=transforms2d) for 2d transforms, that pushes global support from 71.57% _without_ prefixes to 91.39% _with_ prefixes. Huge improvement!

`scale` isn't all `transform` has up its sleeve though. In total, there are 4 commonly used 2D transformations:

- `scale` :: make an element bigger or smaller - or stretch it
- `rotate` :: rotate an element
- `skew` :: tilt an element
- `translate` :: move an element up/down and left/right

You can find learn more about these, including lots of examples, at [CSS Tricks](https://css-tricks.com/almanac/properties/t/transform/). That page also contains some information on 3D transformations, perspective, and matrices - but only check those out if you really want to dive in deep, as they're a bit more difficult to wrap your head around.

---

## What are CSS animations?

So... CSS transitions are nice when you have just two steps: starting properties and ending properties. Sometimes though, you need more than that. What if you wanted to make an element look like it was bouncing? Or continuously rolling, forever?

That's where CSS animations come in.

<img src="http://i.imgur.com/jkKzhQx.png" class="img-responsive rolling">

<style>
  @-webkit-keyframes roll {
    100% {
      -webkit-transform: rotate(360deg);
      -ms-transform: rotate(360deg);
      transform: rotate(360deg);
    }
  }
  @keyframes roll {
    100% {
      -webkit-transform: rotate(360deg);
      -ms-transform: rotate(360deg);
      transform: rotate(360deg);
    }
  }
  .rolling {
    -webkit-animation: roll 120s infinite;
    animation: roll 120s infinite;
  }
</style>

See how that image is slowly rotating? I gave that `img` element a class of `rolling`, then defined this CSS:

```
@keyframes roll {
  100% {
    -webkit-transform: rotate(360deg);
    -ms-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}

.rolling {
  animation: roll 120s infinite;
}
```

With `@keyframes`, we define an animation called `roll`, which transitions to a 360 degree rotation (full circle). Then we define a `rolling` class that runs the roll animation, over 120 seconds, and repeats infinite times.

---

## Animating multiple steps

So we achieved what we couldn't before - an animation that runs forever. But what if we want more steps to our animation?

<style>
@keyframes rainbow {
  0%   { background: #a0d1d1; }
  20%  { background: #8dcc95; }
  40%  { background: #d4c8a0; }
  60%  { background: #c995ad; }
  80%  { background: #ac91b8; }
  100% { background: #a0d1d1; }
}
@-webkit-keyframes rainbow {
  0%   { background: #a0d1d1; }
  20%  { background: #8dcc95; }
  40%  { background: #d4c8a0; }
  60%  { background: #c995ad; }
  80%  { background: #ac91b8; }
  100% { background: #a0d1d1; }
}
.flashy {
  animation: rainbow 10s infinite;
}
</style>

<p><button class="btn btn-warning btn-block btn-lg flashy" onclick="jQuery(this).toggleClass('flashy')">I'm so flashy. Click me to toggle the rainbow.</button></p>

To animate this button, we had to define all the various stages it goes through with percentages:

```
@keyframes rainbow {
  0%   { background: #a0d1d1; }
  20%  { background: #8dcc95; }
  40%  { background: #d4c8a0; }
  60%  { background: #c995ad; }
  80%  { background: #ac91b8; }
  100% { background: #a0d1d1; }
}

.flashy {
  animation: rainbow 15s infinite;
}
```

Then once again, we use refer to the animation we created in a class. In this case, the animation is called `rainbow` and the class is called `flashy`.

---

## Controlling exactly _how_ transitions happen

It's also possible to control the exact "timing functions" of your CSS. Timing functions determine how we get from one step to the next. We might go at a steady pace. Or we might start out fast, but then slow down at the end. Or start slow, get faster in the middle, then end slow again.

These can get a bit complicated, so I won't dive into them here, but I want you to know they exist. That way, you know what to Google when you're creating an animation or transition that isn't transitioning exactly how you'd like.

If you happen to be really geeking this stuff right now though, [this is a great, very visual guide](http://www.the-art-of-web.com/css/timing-function/) for timing functions, transition delays, and more.

---

## Animate.css

Finally, if you'd like to take a tour of other animations that are possible purely with CSS, you should check out the [Animate.css project](https://daneden.github.io/animate.css/). Not only can you use their animations in your own projects, but because it's open source, you can also see [the code for each animation](https://github.com/daneden/animate.css/tree/master/source) to figure out how it's achieved.

Here's a demo of one of their many animations:

<style>
@-webkit-keyframes bouncing {
  from, 20%, 53%, 80%, to {
    -webkit-animation-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000);
    animation-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000);
    -webkit-transform: translate3d(0,0,0);
    transform: translate3d(0,0,0);
  }

  40%, 43% {
    -webkit-animation-timing-function: cubic-bezier(0.755, 0.050, 0.855, 0.060);
    animation-timing-function: cubic-bezier(0.755, 0.050, 0.855, 0.060);
    -webkit-transform: translate3d(0, -30px, 0);
    transform: translate3d(0, -30px, 0);
  }

  70% {
    -webkit-animation-timing-function: cubic-bezier(0.755, 0.050, 0.855, 0.060);
    animation-timing-function: cubic-bezier(0.755, 0.050, 0.855, 0.060);
    -webkit-transform: translate3d(0, -15px, 0);
    transform: translate3d(0, -15px, 0);
  }

  90% {
    -webkit-transform: translate3d(0,-4px,0);
    transform: translate3d(0,-4px,0);
  }
}

@keyframes bouncing {
  from, 20%, 53%, 80%, to {
    -webkit-animation-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000);
    animation-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000);
    -webkit-transform: translate3d(0,0,0);
    transform: translate3d(0,0,0);
  }

  40%, 43% {
    -webkit-animation-timing-function: cubic-bezier(0.755, 0.050, 0.855, 0.060);
    animation-timing-function: cubic-bezier(0.755, 0.050, 0.855, 0.060);
    -webkit-transform: translate3d(0, -30px, 0);
    transform: translate3d(0, -30px, 0);
  }

  70% {
    -webkit-animation-timing-function: cubic-bezier(0.755, 0.050, 0.855, 0.060);
    animation-timing-function: cubic-bezier(0.755, 0.050, 0.855, 0.060);
    -webkit-transform: translate3d(0, -15px, 0);
    transform: translate3d(0, -15px, 0);
  }

  90% {
    -webkit-transform: translate3d(0,-4px,0);
    transform: translate3d(0,-4px,0);
  }
}
.bounce {
  -webkit-animation: bouncing 1s infinite;
  animation: bouncing 1s infinite;
}
</style>

<p><button class="btn btn-warning btn-lg btn-block" style="white-space: normal" onclick="var thiz = jQuery(this); thiz.toggleClass('bounce'); thiz.hasClass('bounce') ? thiz.text('Please! I can\'t take it anymore! Click me again to make the bouncing stop!') : thiz.text('Thank you my friend! I thought the torment would never end.');">Click me and I'll start bouncing.</button></p>
