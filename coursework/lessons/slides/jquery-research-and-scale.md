## Your job as a programmer

Programming is a little strange, compared to most other jobs. For an accountant at a sporting goods store, let's say the manager strolls up one day, obviously excited about a new idea.

__Manager__: "I'd like to make it so that when we're working with a previous customer, we can pull of a quick summary of their interests and past budget on our tablets."

__Accountant__: "Umm... that's impossible. We don't have a system like that."

__Manager__: "But don't you work with the money, history of purchases, and all that? Don't you have all that information?"

__Accountant__: "Yeah... but I can't just _invent_ things that don't exist. We don't have a way to match purchased items to specific interests or generate estimated budgets, just on the fly."

__Manager__: "Well who can?"

__Accountant__: "I think we'd need a programmer."

That's you. You do the parts of everybody else's job that require _inventing something new_. And you don't get to say, "I've never built something like that before. I don't think it even exists." If they only needed things that already existed, they could just buy those existing things, rather than hiring a programmer.

Face it, you _are_ a wizard. Wizards do magic. And with magic, anything is possible. So _you could be asked to do anything_. And odds are, you won't have done it before. You might not even have seen it before.

Here's the secret though: it's not as scary as it sounds. It involves some Googling and trial and error, but in the end, you feel like this.

![UNLIMITED POWER](http://i.imgur.com/YG08UPf.jpg)

To get there though, we need a great process. So using jQuery, we'll explore this process of building something that starts out _relatively_ simple, then gets more and more complex. We'll run into weird issues and bugs, but we'll use a few tricks and free tools at our disposal to solve them all.

---

## Researching a new feature request

I'm helping my friend Simone build a webapp for writing short stories and she has this idea:

> I want to encourage writers to focus on the _content_, rather than the _formatting_, of their stories. I did some research and there's a very simple [markup language called "markdown"](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) that can later be converted into really good-looking HTML. Partly to help users learn markdown and partly just because I think it would be really cool, I want the webapp to convert the markdown users are typing into HTML _live, in real-time_. We can show them a preview of how their formatted story will appear, [like this](http://markdownlivepreview.com/). I think we'd need JavaScript for that though and I only know HTML, CSS, and Ruby. Can you help me?

I've never heard of markdown, don't know how to write it myself, and am still not really sure what she wants, but I say, "Yeah, of course," because I have some time and know I'll figure it out. I always do.

First, I check out her links. From [the first link](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) explaining what markdown actually is, it looks like I can write something like this:

``` markdown
# Here is a title

- Here
- is
- a
- list

And here are...

...a couple paragraphs.
```

and it will be converted into this HTML:

``` html
<h1>Here is a title</h1>

<ul>
  <li>Here</li>
  <li>is</li>
  <li>a</li>
  <li>list</li>
</ul>

<p>And here are...</p>

<p>...a couple paragraphs.</p>
```

That's pretty cool!

<div class="callout callout-info text-muted">
  <h4>Note</h4>

  <p>As a little aside, [this lesson itself](https://github.com/lansingcodelab/www/blob/master/coursework/lessons/slides/jquery-review-and-research.md) was written in markdown. It's also a very popular markup language for people to write documentation in. If you include a `README.md` file at the root of a Git repository and then push it to GitHub, it'll even show up on that repository's page, automatically converted to pretty HTML!</p>
</div>

Alright, so I sort of get the idea of markdown now. Let's check out [her other link](http://markdownlivepreview.com/), with the example of what she wants.

Ohh... that _is_ cool. But how do I convert markdown into HTML in JavaScript? Let's ask google: ["convert markdown to html in javascript"](https://www.google.com/search?q=convert+markdown+to+html+in+javascript)

For me, the top 3 results are all GitHub projects and in the descriptions, two of these call themselves markdown "parsers". I didn't know that word before. When I see new vocabulary like that, I like to make a mental note of it, in case it comes in handy in future Googling.

OK, so let's click on [the first link](https://github.com/chjj/marked). When I'm looking at a project on GitHub, here are a few things I'm looking for:

### Does it have a lot of stars?

This indicates how popular a project is. And if it's popular, it usually works pretty well. You can find the number of stars (![8,008 stars](https://www.dropbox.com/s/g60qld1mhrn4x3g/Screenshot%202015-12-23%2015.07.09.png?dl=1)) in the upper-right of GitHub's interface. I'm not looking for a specific number, but more is better and less than 100 is when I often start to worry.

### When was the last commit?

This gives me an indication of whether the project is still being kept up to date. You can find the last commit (![Last commit on July 31](https://www.dropbox.com/s/senijbpghd3javs/Screenshot%202015-12-23%2015.15.00.png?dl=1)) on the right side of a GitHub project page, directly above the list of folders and files. For different projects, this date might be more or less important. If it's a web framework that handles security for you, [like Rails](https://github.com/rails/rails), you want updates _at least_ every few months, to keep up with the latest threats. If it's an implementation of very specific algorithm invented in 2008, [like jLouvain](https://github.com/upphiminn/jLouvain), then if it was last updated in 2008, that's OK. It won't have changed since then.

### How old are the open issues?

This helps me understand how quickly the developer(s) are responding to problems. If there are a lot of really old issues (especially more than a year old) that no one has even responded to, that doesn't bode well.

### How accessible is the documentation?

I want thorough documentation or a link to thorough documentation in their README file. _And_ I want that documentation to be easy to read. I don't want to spend all day just figuring out how to _use_ this library, if there are better-documented alternatives available that will offer me the same thing.

<hr>

So there's good news and there's bad news. No matter what you might want to do...

> "The Internet has a ton of information about this stuff. _Unfortunately_, the Internet has a ton of information about this stuff. And it's really hard to sift through to find the things that are useful." - Sarah Mei

If you want a deeper dive into making great technology choices, check out Sarah Mei's excellent (and only half-hour!) talk on the subject:

<iframe width="530" height="300" src="https://www.youtube.com/embed/FzzL_QDKv0c?rel=0" frameborder="0" allowfullscreen></iframe>

---

## Parsing a Stack Overflow question

OK, so to recap, we have:

- a better idea of what markdown,
- an example of what Simone wants, and
- a library ([marked](https://github.com/chjj/marked)) that promises to "parse" markdown easily and quickly

Let's start writing some code.

We know we need a place for users to _write_ their markdown and a place for them to see the preview, so let's create those to elements and give them `id`s so we can target them with jQuery.

``` html
<textarea id="markdown-input"></textarea>
<div id="markdown-preview"></div>
```

There we go. Now to actually make it _do_ something with jQuery. Every time the text in the `#markdown-input` changes, we want to put the equivalent HTML in `#markdown-preview`. And to break that down to just the first step, how do we use jQuery to do _something_ whenever text in a `textarea` changes? Again, let's ask Google:

![jquery how to do something when text in textarea changes](https://www.dropbox.com/s/prsekmizlslps9q/Screenshot%202015-12-23%2016.09.31.png?dl=1)

[That first result](http://stackoverflow.com/questions/11338592/how-can-i-bind-to-the-change-event-of-a-textarea-in-jquery) looks promising. It's on a website called __Stack Overflow__, named after a famously common and vague error in some languages. It's where programmers go to say, "I have this problem I'm trying to solve. Any ideas?" Then other programmers provide answers and the entire community votes on what their favorites are.

This question looks pretty popular (98 upvotes as of writing), so we're definitely not the first to have this problem! And there are several answers. So how do we pick the best one? Here's what I look for:

### How many upvotes does it have?

If other people have found it useful, they'll generally vote it up - which is a pretty good indication that the proposed solution worked!

### How old is the answer?

Upvotes aren't everything. Technology on the web changes over time, so older answers that _used to_ work may actually have more upvotes than newer answers that are more correct _now_.

### Do comments or other answers point out any significant limitations?

Instead of just skimming for something that looks like it'll work, I like to read _all_ of the most popular answers and their comments. These will often give me clues as to which new trails to start Googling down. In the end, I'm often able to piece together an answer that's better than _any_ of the existing answers.

<hr>

Now looking at the answers for this Stack Overflow question, it seems 3 of them have a fair number of upvotes (as of writing, one has 197, another 67, and another 15). Some answers are also newer than others, starting from 2012.

Between the answers and the comments, there are also complaints about _all_ of the popular answers, pointing out situations where they lack support, especially regarding Internet Explorer 9 and below. That's when it's time to start looking at the less popular, but newer answers. And... it looks like none of the others are useful.

OK, time to start checking out other Google results and using the specific issues brought up on this page to start looking for a better solution.

---

## Always check which browsers you have to support _first_

So... an hour of Googling later, I've put together enough information to submit [my own answer](http://stackoverflow.com/questions/11338592/how-can-i-bind-to-the-change-event-of-a-textarea-in-jquery#answer-34448472) to that Stack Overflow question. Thanks to my thorough research, I think it's better than anything else people have come up with over the 94,670 views of this question. And I feel _AWESOME_.

![Baby feeling awesome](http://i.imgur.com/7On7Cu3.jpg)

So awesome I just have to tell someone. So I text Simone to tell her about the brilliant solution I came up with to support _all the browsers_, including Internet Explorer 9 and below.

She texts back, "Ha! Who uses those browsers?"

I text back, a little defensively, "Almost 4% of website visits in the United States, [according to StatCounter](http://gs.statcounter.com/#desktop+mobile-browser_version_partially_combined-US-monthly-201510-201512-bar). That's like 1 out of every 25 people!"

She responds, "Just checked my Google Analytics. I got only 3 visits from less than IE11 in the last 6 months, so don't worry about supporting the older stuff. Most of my users are millennials - just make sure it works on phones. :)"

Despite the smiley face at the end, my face is not smiling. I just spent a bunch of time putting together a _super_ clever solution... to a problem I don't have, apparently. As Donald Knuth (a famous computer scientist) once said:

> "Premature optimization is the root of all evil."

Or, in less dramatic and probably therefore less memorable terms:

<div class="callout callout-warning">

  <h4>Important</h4>

  <p>Only research and implement features when you _actually_ need them, not when you think you _might_ need them.</p>

</div>

---

## Testing that the most basic version of the code works

So now that I don't have to support older browsers, it looks like this is all I have to do, in order to detect `textarea` changes:

``` js
$('#markdown-input').on('input', function(){
  // stuff that should happen when the input contents change
})
```

But how do I know that works? One of my favorite ways to figure out if an event is being fired at the appropriate times is adding a `console.log` statement:

``` js
$('#markdown-input').on('input', function(){
  console.log('The textarea changed!')
})
```

With that code in place, I can fool around to see if I can break things in my browser of choice, which happens to be Google Chrome. My earlier research wasn't _entirely_ wasted though, because seeing all the things that didn't work in some browsers, I now have a better list of things to test, including:

- typing
- deleting
- backspacing
- cutting
- pasting
- selecting text in the `textarea`, then dragging somewhere else
- selecting text from another `textarea`, then dragging into this one

And it looks like my jQuery event callback triggers on all of them! OK, so now that I've confirmed this part is working as expected, let's move on to the next step: getting the contents of the `textarea`.

Fortunately, I saw code examples that accessed the contents of `textarea`s in my previous Googling. They used `this.value`. Let's try it.

``` js
$('#markdown-input').on('input', function(){
  console.log(this.value)
})
```

After typing some stuff in the `textarea`, I can see in my web browser's JavaScript console that it's working!

---

## Minified files and Content Delivery Networks (CDNs)

So now our next step is to take the `textarea`'s contents and run it through a markdown parser. Looking at [the GitHub page for the `marked` library](https://github.com/chjj/marked) we found earlier, it looks like they have a lot of files and folders. So which file is what _we_ want? To answer that question, there are a few things you should know:

### Which filenames to look for

There are two common naming conventions for two distinct types of files:

- `NAME-OF-LIBRARY.js`: The human-readable library file that you can download and link to from your HTML.
- `NAME-OF-LIBRARY.min.js`: The machine-optimized (i.e. "minified") library file that you can download and link to from your HTML.

Unless you want to make changes to the file while you're developing, __you always want the minified version__ of the library, because it'll be smaller and therefore download faster in web browsers.

### Why you should use Content Delivery Networks

A Content Delivery Network (usually shortened to just "CDN") is a collection of servers, distributed around the world, that simply host static files, like images, fonts, CSS, JavaScript, etc. And basically, they're built to make these kinds of files load faster. [Read this](http://www.sitepoint.com/7-reasons-to-use-a-cdn/) to learn how they do it.

Read it? Great. Now I want to tell you about [CDNJS.com](https://cdnjs.com/), which is a free CDN for popular JavaScript libraries. Whenever I'm including a new, popular library into a project, I typically check there first to see if they'll host it for me.

If they have it, they'll often offer URLs for minified and unminified versions of the library - remember again to always use the minified version (the one ending in `.min.js`). Once you have the URL, just use that as the `src` in a `script` tag on your website:

``` html
<script scr="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
```

### Where to find the correct files on GitHub repos

If a library isn't available via a CDN, you'll just have to download it and link to it like usual. But sometimes, there will seem to be a lot of files and folders with neither of the filenames you're looking for in plain site.

Here's the trick: If you don't immediately see these filenames, look in a `dist` folder if they have one. This is the most typical name for the folder with all the files _distributed_ to users like you.

<hr>

So to summarize, here's our process for adding a new library to our project:

1. Look for the library on [CDNJS.com](https://cdnjs.com/), and if it exists, link to the minified version in a `script` tag.
2. If the library isn't available via a CDN, look for it on the GitHub repo (note that it may be inside a `dist` folder). Once again, always use the minified version if one is available. Download this file and link to it locally, as you normally do for JavaScript files.

So let's follow step one. Right away, we know we want the jQuery and marked libraries, so let's search for those on [CDNJS.com](https://cdnjs.com/). And... they're both available! So let's add them to the bottom of our `body` tag:

``` html
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js" charset="utf-8"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/marked/0.3.5/marked.min.js" charset="utf-8"></script>
```

If you were using a local version of jQuery, you can remove it now. This is better!

---

## Research must be combined with experimentation

OK, so we've included the marked library in our website now. And [from the documentation](https://github.com/chjj/marked#browser), it looks like all we have to do to convert markdown to HTML is do something like this:

``` js
marked('# Marked in browser\n\nRendered by **marked**.')
```

So it looks like they're just passing the string of markdown into a `marked` function. Let's try it.

``` js
$('#markdown-input').on('input', function(){
  console.log( marked(this.value) )
})
```

And... it's working! OK, I feel like we're really picking up steam now. Now how would we use this HTML to update the contents of our `#markdown-preview`? Let's [google it: "jquery update element contents"](https://www.google.com/search?q=jquery+update+element+contents)

The two top results are jQuery's `.html()` function and the `.text()` function. Reading about them on those pages, it looks like they _kind of_ do the same thing. But then why would there be two, separate functions? Reading carefully, there seems to be a slight, but significant difference.

I _think_ the `.html()` function actually turns the text you give it into HTML elements, while the `.text()` function won't. Well, there's one easy way test if I'm understanding right. I'll load up my webpage, which already has jQuery in it and I'll try to see if these two lines give me different results:

``` js
$('#markdown-preview').html('<h1>Testing</h1>')
$('#markdown-preview').text('<h1>Testing</h1>')
```

I'll run those one at a time in my JavaScript console to test them out.

OK, so it looks like my assumption was right.

``` js
$('#markdown-preview').html('<h1>Testing</h1>')
```

produced:

![<h1>Testing</h1>](https://www.dropbox.com/s/ukdwq326nuodcem/Screenshot%202015-12-24%2012.33.38.png?dl=1)

While:

``` js
$('#markdown-preview').text('<h1>Testing</h1>')
```

produced:

!["<h1>Testing</h1>"](https://www.dropbox.com/s/2t5ho3o4ox0nd9a/Screenshot%202015-12-24%2012.34.18.png?dl=1)

OK, `.html()` is definitely the one I want here. Testing it out...

``` js
$('#markdown-input').on('input', function(){
  $('#markdown-preview').html( marked(this.value) )
})
```

Wow, that's working beautifully! I guess we're done - and in only 3 beautiful lines.

---

## The final step is always refactor

In programming, __refactoring__ is changing code to make it better, _without_ changing what it actually does. So what's the point, then? Well, we want to make sure the code:

- is easy to read
- is written in a consistent style
- doesn't have any obvious and simple-to-fix performance issues

So let's take a look:

``` js
$('#markdown-input').on('input', function(){
  $('#markdown-preview').html( marked(this.value) )
})
```

It seems _pretty_ easy to read, but adding a comment at the top to explain what it does would probably help other people - and also help myself if I happen to be looking at it again months from now.

``` js
// Updates the markdown preview with the HTML equivalent
// of the contents of the markdown input, whenever those
// contents change
$('#markdown-input').on('input', function(){
  $('#markdown-preview').html( marked(this.value) )
})
```

Great! So the style looks pretty consistent - no problems there. What about performance? Hmm... well it looks like _every_ time the contents of the `#markdown-input` change, I'm making jQuery go hunt down my `#markdown-preview` all over again. That only really needs to be done _once_, so I'll pull that out and assign it to a variable:

``` js
var $markdownPreview = $('#markdown-preview')

// Updates the markdown preview with the HTML equivalent
// of the contents of the markdown input, whenever those
// contents change
$('#markdown-input').on('input', function(){
  $markdownPreview.html( marked(this.value) )
})
```

I like it. I think I'm ready to hand this over to Simone now.

---

## Requirements always change

Good news! We just got a text from Simone and she says:

> I love it! But one more thing...

Uh oh.

> I forgot to tell you before, but I also want a Clear button that will clear out all the markdown, including in the input.

OK, that shouldn't be too bad. First, we'll update our HTML to add the button:

``` html
<textarea id="markdown-input"></textarea>
<button id="clear-markdown-button">Clear</button>
<div id="markdown-preview"></div>
```

Then make it actually _do_ something:

``` js
var $markdownPreview = $('#markdown-preview')

// Updates the markdown preview with the HTML equivalent
// of the contents of the markdown input, whenever those
// contents change
$('#markdown-input').on('input', function(){
  $markdownPreview.html( marked(this.value) )
})

var $clearMarkdownButton = $('#clear-markdown-button')

$clearMarkdownButton.on('click', function() {
  $('#markdown-input').val('')
  $markdownPreview.html('')
})
```

That works, now to give it a small refactor:

``` js
var $markdownInput = $('#markdown-input')
var $markdownPreview = $('#markdown-preview')
var $clearMarkdownButton = $('#clear-markdown-button')

// Updates the markdown preview with the HTML equivalent
// of the contents of the markdown input, whenever those
// contents change
$markdownInput.on('input', function(){
  $markdownPreview.html( marked(this.value) )
})

// Clears the markdown input and preview whenever
// the Clear button is clicked.
$clearMarkdownButton.on('click', function() {
  $markdownInput.val('')
  $markdownPreview.html('')
})
```

Let's see what Simone thinks.

---

## Combating the inevitable rise in complexity

Ding. New text from Simone:

> Love the new button! Just sent you an email.

An email? Fine, I'll log in...

> Thanks for all your help so far! The new button looks great. I just got together with our designer and we have just a few more tweaks we want to make:

> - When the input is empty, we want the button to say "Cleared" and be disabled, but when it's _not_ empty, it'll no longer be disabled and will say "Clear" again.
> - We want the preview to fade out a little when it's empty, so can you add an "empty" class to the preview when it's empty, but remove that class when it's not empty? We can handle the actual fadeout with CSS.
> - We want the input to start off only one line high, but then get taller as text flows onto the next line. If you delete text, it should also get shorter again.
> - We'll actually want multiple of these input and preview pairs on some pages, so I think we'll have to switch from targeting these with `id`s to `class`es. Can you make that work?

![Really?](http://i.imgur.com/ZLdLiC9.jpg)

OK, time to get in the zone. After a few hours of research and troubleshooting, I now have a demo with this HTML:

``` html
<!-- 1st pair -->
<div class="js-markdown-previewer-container">
  <textarea rows="1" class="js-markdown-input"></textarea>
  <button disabled class="js-clear-markdown-button">Cleared</button>
  <div class="js-markdown-preview empty"></div>
</div>

<!-- 2nd pair -->
<div class="js-markdown-previewer-container">
  <textarea rows="1" class="js-markdown-input"></textarea>
  <button disabled class="js-clear-markdown-button">Cleared</button>
  <div class="js-markdown-preview empty"></div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js" charset="utf-8"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/marked/0.3.5/marked.min.js" charset="utf-8"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/autosize.js/3.0.14/autosize.min.js" charset="utf-8"></script>
<script src="/js/script.js" charset="utf-8"></script>
```

And this the JavaScript:

``` js
$('.js-markdown-previewer-container').each(function() {

  var $container = $(this)
  var $markdownInput = $container.find('.js-markdown-input')
  var $markdownPreview = $container.find('.js-markdown-preview')
  var $clearMarkdownButton = $container.find('.js-clear-markdown-button')

  autosize($markdownInput)

  $markdownInput.on('input', function(event) {
    var markdown = this.value
    var markdownHTML = marked(markdown)

    // Update preview
    $markdownPreview.html(markdownHTML)
    if (markdown.length > 0) {
      $markdownPreview.removeClass('empty')
    } else {
      $markdownPreview.addClass('empty')
    }

    // Update clear button
    if (markdown.length > 0) {
      $clearMarkdownButton.prop('disabled', false)
      $clearMarkdownButton.text('Clear')
    } else {
      $clearMarkdownButton.prop('disabled', true)
      $clearMarkdownButton.text('Cleared')
    }
  })

  $clearMarkdownButton.on('click', function() {
    // Update input
    $markdownInput.val('')
    autosize.update($markdownInput) // HACK: https://github.com/jackmoore/autosize/issues/165

    // Update preview
    $markdownPreview.html('')
    $markdownPreview.addClass('empty')

    // Update clear button
    $clearMarkdownButton.prop('disabled', true)
    $clearMarkdownButton.text('Cleared')
  })

})
```

I'm so mentally exhausted after all that research that I kind of gave up on great comments. And the code _definitely_ doesn't feel simple anymore. It's just so much to keep track of!

There are a few things I'm proud of though:

I'm prefixing all the classes I need for my JavaScript with `js-`. That's a convention I've learned from experience. Having separate classes for targeting elements with JavaScript vs CSS is really helpful. If you use the _same_ classes, it's too easy to make a change to a class while styling, forgetting that it's also being used in your JavaScript - or vice versa. This is especially important if you're working in a team.

I also wrapped each group of related elements in a container element, then used jQuery's `.each()` function to find each container and scope behavior to the elements inside it with `.find()`. If I didn't do something like this, then any time there were multiple groups of an input and preview on a single page, you'd get changes to one group messing with other groups, because they all have the same classes.

So it's not perfect, but it works. Time for a break, then I'll do a final refactor and - ding. New text from Simone:

> Hey, while you're working on that, we just had another idea! We want people to be able to learn HTML as well through this tool, so we'd like another preview that shows the raw HTML. And we'd like users to be able to edit that as well. When they do, the input and preview should also update, so that users can see what that HTML turns into in markdown and rendered on the page.

![Ugh... why?](http://i.imgur.com/F7upQzJ.jpg)

I'm starting to feel angry at Simone. I think to myself that it must be really easy to come up with ideas when you don't have to figure out how to make it all work. Doesn't she realize how difficult this is?

But... I'm not angry with _Simone_. Not really. I'm angry at my code. The more events and elements it gets, the more complex and harder to think about it becomes. It stops being fun and exhilarating and instead, starts to feel like this:

![Event spaghetti](https://www.dropbox.com/s/5h0uuw5xx9dzwc1/Screenshot%202015-12-24%2014.27.08.png?dl=1)

I call it __event spaghetti__. It's the #1 reason why people start to hate their jQuery code. But good news! There's a solution. We're going to add some order to the chaos, turning that spaghetti into this:

![Straightening the event spaghetti with renderers](https://www.dropbox.com/s/7jlxxsn4xkcowp0/Screenshot%202015-12-24%2014.29.48.png?dl=1)

Doesn't that look cleaner? On the next page, you'll see how it's done and how it makes our code easier to think about.

---

## Turning event spaghetti into a well-ordered hierarchy

Before we even start _thinking_ about implementing Simone's new feature, let's do a major refactor. Right now, when I'm working on an event, I have to remember how all the elements work, because every event shares the job of updating all the elements.

What if for each element, there could be _one_ specific place in our code that worried about how that element should look. And then there'd be _one_ place that worried about which elements we have to keep up-to-update. We can define isolated places in our code, each with a specific job, using __functions__. You've seen those before, but we haven't used them for any complex organization.

So let's reorganize the code, splitting it up into functions and __making sure each function has only a [single responsibility](https://en.wikipedia.org/wiki/Single_responsibility_principle)__.

``` js
$('.js-markdown-previewer-container').each(function() {

  // --------
  // ELEMENTS
  // --------

  var $container = $(this)
  var $markdownInput = $container.find('.js-markdown-input')
  var $markdownPreview = $container.find('.js-markdown-preview')
  var $clearMarkdownButton = $container.find('.js-clear-markdown-button')

  // ---------
  // RENDERERS
  // ---------

  function renderInput(markdown) {
    $markdownInput.val(markdown)
    // HACK: https://github.com/jackmoore/autosize/issues/165
    autosize.update($markdownInput)
  }

  function renderClearButton(markdown) {
    if (markdown.length > 0) {
      $clearMarkdownButton.prop('disabled', false)
      $clearMarkdownButton.text('Clear')
    } else {
      $clearMarkdownButton.prop('disabled', true)
      $clearMarkdownButton.text('Cleared')
    }
  }

  function renderPreview(markdown) {
    $markdownPreview.html( marked(markdown) )
    if (markdown.length > 0) {
      $markdownPreview.removeClass('empty')
    } else {
      $markdownPreview.addClass('empty')
    }
  }

  function renderAll(markdown) {
    renderInput(markdown)
    renderClearButton(markdown)
    renderPreview(markdown)
  }

  // --------------
  // INITIALIZATION
  // --------------

  function initialize() {
    autosize($markdownInput)
    renderAll($markdownInput.val())
  }

  initialize()

  // ------
  // EVENTS
  // ------

  $markdownInput.on('input', function() {
    renderAll(this.value)
  })

  $clearMarkdownButton.on('click', function() {
    renderAll('')
  })

})
```

Take a good look at this code. Here's what's happening:

1. When it's first run, we "initialize" it by making sure our input autosizes, then we ensure everything looks as it should by calling `renderAll()` with the initial contents of our markdown input.
2. It's `renderAll`'s job to keep a list of all the elements that change depending on the state of our markdown. It then passes that state to each element-specific renderer.
3. Each element-specific renderer is in charge thinking about how that element should look, based on the new state of the markdown.
4. Whenever an event is fired, all it has to worry about now is, "What's the new state of the markdown?" Then it passed that to `renderAll()`

Responsibilities are now much more clearly defined, so I don't have to be thinking about _everything_ at once anymore. I can just worry about one function at a time, one element at a time.

And most importantly, coding is _fun_ again! I feel powerful again. And instead of the overwhelmingly frustrated, I'm actually excited to implement Simone's new feature. But I'll leave that as an exercise to the reader. :-)
