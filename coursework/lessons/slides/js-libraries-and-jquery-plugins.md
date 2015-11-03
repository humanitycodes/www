## The web developer's dilemma

Building features into a website can be tricky sometimes, especially when other people are involved in the process. Non-developers don't know what's possible or what's difficult, so they'll ask things like, "So when you click on the sign up button, could the button slowly transform into a popup with the sign up form through some fancy animation?"

If my answer isn't, "You don't actually want that and here's why," then it'll probably be, "Maybe." I say maybe because _I_ don't want to build it, but in my experience, someone else has _usually_ already put in the work and made their code freely available.

So how do you find out? If I think I know the words to describe what I want, I'll start Googling. Otherwise, I'll ask other web developers to see if they have any tips.

In this case, I happen to know that in web development, the technical term for an in-page popup is a "modal", so I turn to Google and type in "[javascript transform button into modal](https://www.google.com/#q=javascript+transform+button+into+modal)". The very first result is [Morphing Modal Window](https://codyhouse.co/gem/morphing-modal-window/). I try out the demo and it seems to be exactly what I had in mind. There's also a download link which gives me the code for the demo, including a collection of JavaScript, CSS, and even a custom image for a close button. The page itself also has step-by-step instructions for integrating this code into my current website. Score!

And in case that turns out to not work the way I wanted, the [the Adaptive Modal library](http://www.thepetedesign.com/demos/adaptive-modal_demo.html) also seems like a good option. And if I don't need the button to necessarily transform into the modal, I can get some great results with [the Colorbox jQuery plugin](http://www.jacklmoore.com/colorbox/)

---

## JavaScript libraries vs jQuery plugins

When researching a feature, you'll sometimes see projects referred to as a "JavaScript library", "vanilla JavaScript library", or "jQuery plugin". Let's define these terms:

- A __JavaScript library__ is any collection of code, written in JavaScript.
- A __"vanilla" JavaScript library__ is a collection of code, written in JavaScript, that _doesn't have any "dependencies"_. In other words, it doesn't _depend_ on you also having jQuery or another JavaScript library in your website. It's called "vanilla" to mean plain or normal, probably because vanilla is often considered the plain flavor of ice cream - the flavor that doesn't _depend_ on any other ingredients.
- A __jQuery plugin__ is a collection of code that _depends on jQuery_. In other words, it uses code from the jQuery library to do its work. That means jQuery must be embedded into the page before the plugin. jQuery plugins have become their own category of JavaScript libraries because _so many_ libraries depend on jQuery.

If this still isn't making sense to you right now, go ahead and wave over a mentor, so they can clear up the confusion.

---

## What are some other common JavaScript libraries?

There are _thousands_ of jQuery plugins to help you quickly add features to your websites. jQuery plugins are often the easiest to use, so they're the most popular. Non-jQuery libraries can also be very powerful, but sometimes have a reputation for their more demanding learning curve.

Normally, you'll Google features as you think of them, but to get you started, here are a handful of libraries you can start playing around with:

### jQuery plugins

- [FitText: automatically adjust font sizes based on screen width](http://fittextjs.com/)
- [Tubular: make a YouTube video the background of a page](http://www.seanmccambridge.com/tubular/)
- [Colorbox: add very nice and customizable modals to a page](http://www.jacklmoore.com/colorbox/)

### Non-jQuery Libraries

- [Substitue Teacher: create quirky, animated taglines](http://danrschlosser.github.io/substituteteacher.js/)
- [WOW: animate elements in your page when a user scrolls to them](http://mynameismatthieu.com/WOW/)
- [TauCharts: add beautiful graphs to your page](http://www.taucharts.com/)
