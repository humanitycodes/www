## The web developer's dilemma

Working with non-developers can be tricky. They don't know what's possible or what's difficult, so they'll say things like, "When you click on this button, I want a sign up form to appear, but I want the button to _transform_ into the sign up form. You know, like a person transforming into a werewolf."

When I'm confronted with something like this - and assuming I don't think it's a terrible idea - I'll probably answer, "Maybe." I say maybe because _I_ don't want to build that feature. It sounds like _a lot_ of work. And where would I even start? But if someone else has already done all the work... well, in that case, I'll gladly use their code.

So how do you find out? If I think I know the words to describe what I want, I'll start Googling. Otherwise, I'll ask other developers to see if they have any tips.

In this case, I happen to know that in web development, the technical term for an in-page popup is a "modal", so I turn to Google and type in "[javascript transform button into modal](https://www.google.com/#q=javascript+transform+button+into+modal)". The very first result is [Morphing Modal Window](https://codyhouse.co/gem/morphing-modal-window/). I try out the demo and it seems to be exactly what I had in mind. There's also a download link which gives me the code for the demo, including a collection of JavaScript, CSS, and even a custom image for a close button. The page itself also has step-by-step instructions for integrating this code into my current website. Score!

And in case that turns out to not work the way I wanted, [the Adaptive Modal library](http://www.thepetedesign.com/demos/adaptive-modal_demo.html) also seems like a good option. And if I don't need the button to necessarily transform into the modal, I can get some great results with [the Colorbox jQuery plugin](http://www.jacklmoore.com/colorbox/). Those were also found through Google.

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
