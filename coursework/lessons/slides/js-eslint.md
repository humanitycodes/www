## Why consistency in code matters

Humans are _amazing_ at recognizing patterns. Take a look at this for example:

![Scatterplot](http://homer.salk.edu/homer/ngs/scatterLog.png)

I have no idea what this is measuring and you probably don't either, but you've probably already drawn a line in your mind mapping the relationship. And your eyes have also likely wandered over to those outliers on the right. What's up with them? They don't seem to follow the pattern, so they tend to grab your interest.

Our eyes also notice outliers when reading code. Take a look at this for example:

``` js
function blah () {
  // ...
}
function blarg () {
  // ...
}
function something()
{
// ...
  }
function anotherThing () {
  // ...
}
function bloop () {
  // ...
}
function arst () {
  // ...
}
```

Over by the `something` function, you'll notice a few inconsistencies. You might not be able to _help_ but notice them. They're distracting. And when debugging, your brain will keep dragging you back here - even if there's nothing technically wrong with that code - simply because it breaks the pattern.

What's worse, is that when we get used to seeing inconsistencies everywhere, we get worse at noticing actual errors. They blend in. Then we bang our heads against the wall when for some reason, our code doesn't seem to be working.

But staying consistent all the time is annoying. It requires self-discipline and making _a lot_ of decisions about your code, like where to have a space, or no space, or where to indent, etc. Fortunately, there are programs that can help us write better code.

When I write that bad code in Atom, this is what I see:

[![ESLint errors](http://i.imgur.com/aFCrqp5.png)](http://i.imgur.com/aFCrqp5.png)

It immediately tells me what's wrong! I don't have to worry about making a silly mistake or waiting to hear what could be better in a code review. I can fix it right now.

This kind of tool is called a __linter__. My guess is it's called a linter in reference to undesired laundry or pocket lint. It helps us find _code lint_, by giving us information about our code _as we write it_ so that we can immediately work out inconsistencies, typos, and even errors.

---

## Setting up ESLint

My favorite tool for catching these problems in JavaScript is ESLint. It's relatively simple to set up and very, _very_ configurable, so that no matter what style you want to stick to, ESLint can help.

But before we can use it, we have to install it. Note that these steps only have to be done _once_ per computer.

### 1. Install the ESLint packages we need

Run this in the terminal (note that it may take a few minutes):

``` sh
npm install --global eslint eslint-config-standard eslint-plugin-standard eslint-plugin-promise eslint-plugin-html
```

### 2. Install the `linter-eslint` plugin for Atom

In Atom:

1. Enter your settings with `Cmd`+`,` on a Mac or `Ctrl`+`,` on Windows or Linux
2. Click on `Install` in the left sidebar
3. Search for `linter-eslint` and click its blue `Install` button
4. Click on the `Settings` button for `linter-eslint`
5. Make sure `Lint HTML files` and `Use global ESLint installation` are checked
6. Restart Atom

If you're not using Atom, I recommend Googling `name-of-my-preferred-editor eslint plugin`

---

## Configuring ESLint for your project

First, you need a project. So go ahead and start the project for this lesson by creating the GitHub repo and cloning it. Then add [this HTML file](https://gist.github.com/chrisvfritz/934c7cef66c524c185fed50c5b3f47c1) to your project. It's a mess and it's broken. We're going to use ESLint to clean it up and fix it.

Now create an `.eslintrc.js` file in the root of your project folder. Then fill it with these contents:

``` js
module.exports = {
  // htts://github.com/feross/standard/blob/master/RULES.md#javascript-standard-style
  // A pretty standard set of linting rules for JavaScript
  extends: 'standard',
  // Required to lint JavaScript inside script tags in HTML files
  plugins: [ 'html' ]
}
```

At this point, you should be seeing a bunch of red dots with errors at the bottom, like this:

[![ESLint errors](http://i.imgur.com/QQCbJbZ.png)](http://i.imgur.com/QQCbJbZ.png)

When you click on a section of code underlined in red, you should also get a nice error popping up. If you see this, congratulations! Now fix the code to get rid of any style violations and use the linting errors to help you get the app completely operational.
