## What is a regular expression?

Regular expressions are a special language for defining patterns in strings. In many programming languages, including Ruby, they typically start with a forward slash (`/`), followed by the regular expression, then ending with another forward slash, like this:

``` ruby
/some regular expression/
```

While regular expressions can look very complicated at first, some are very simple. For example, let's say we want to enforce the first rule of Fight Club, which as we all know, is to _never_ talk about Fight Club. The problem is, our users at `no-clubs-over-here-especially-about-fighting.com` keep breaking the rule! So before they post anything to the website, we first want to make sure they do _not_ mention Fight Club.

To check if a string contains the phrase "Fight Club", the regular expression would be:

``` ruby
/Fight Club/
```

That's not too bad, right? To test this out, let's hop into `irb` in our terminal and test this against some example strings. In Ruby, we'll match a string against a regular expression with `=~`. For example:

``` ruby
"Hey, sports, am I right?" =~ /Fight Club/
```

If that string doesn't contain the phrase "Fight Club", then it should return `nil`, like this:

``` output
=> nil
```

Paste `"Hey, sports, am I right?" =~ /Fight Club/` into your `irb` session now to make sure that's what you get.

OK, so what if a string _does_ contain the phrase "Fight Club"? Like this:

``` ruby
"I'm totally not talking about Fight Club right now."
```

In this case, checking the string against our regular expression should return the __index__ of where the phrase starts. The "index" of a character is the position it's at in a string, starting with 0. For example, here are the indices for the characters at the beginning of our new string:

<table class="table text-center">
  <tbody>
    <tr>
      <td>0</td>
      <td>1</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
      <td>5</td>
      <td>6</td>
      <td>7</td>
      <td>8</td>
      <td>9</td>
      <td>10</td>
      <td>11</td>
      <td>12</td>
      <td>13</td>
      <td>14</td>
    </tr>
    <tr>
      <td><code>I</code></td>
      <td><code>'</code></td>
      <td><code>m</code></td>
      <td><code> </code></td>
      <td><code>t</code></td>
      <td><code>o</code></td>
      <td><code>t</code></td>
      <td><code>a</code></td>
      <td><code>l</code></td>
      <td><code>l</code></td>
      <td><code>y</code></td>
      <td><code> </code></td>
      <td><code>n</code></td>
      <td><code>o</code></td>
      <td><code>t</code></td>
    </tr>
  </tbody>
</table>

Notice how even punctuation and spaces are characters, with their own index? Now let's try to match this string against our regex:

``` ruby
"I'm totally not talking about Fight Club right now." =~ /Fight Club/
```

It should return this:

``` output
=> 30
```

That means it _did_ find the phrase "Fight Club" in our string, at index 30.

---

## Regular expression flags

So we have a problem. This correctly finds the phrase "Fight Club" in the string:

``` ruby
"I'm totally not talking about Fight Club right now." =~ /Fight Club/
```

But this returns `nil`:

``` ruby
"I'm totally not talking about fight club right now." =~ /Fight Club/
```

In our regex, we capitalized "Fight Club" and they spelled it with all lowercase letters. To solve this problem, we can use a regex __flag__, which is just a letter that goes right after the final `/`. Like this:

``` ruby
/Fight Club/i
```

That "i" means the regex should be matched case-insensitively, meaning it won't pay attention to whether something is uppercase or lowercase.

Now that we have some regex that should correctly detect "fight club", let's test it:

``` ruby
"I'm totally not talking about fight club right now." =~ /Fight Club/i
```

Check to make sure that correctly returns `30` in an `irb` session.

---

## Common regular expression modifiers

There's another problem. Some people are spelling Fight Club as all one word, like this:

``` ruby
"Fightclub"
```

We want to catch that too - and this is where things get a little more complicated. While all the letters of the alphabet just mean "look for this letter", a lot of other characters have special meaning in regex. For example, `?` doesn't look for a literal question mark. Instead, it's a __modifier__, meaning it modifies whatever's right before it.

In regex, `?` means "whatever is before me _might_ be here". This will be really useful for helping us catch both "Fight Club" as two words and "Fightclub" as one word:

``` ruby
/Fight ?Club/i
```

By adding a question mark after the space, we're saying there _might_ be a space.

### What if you wanted to check for a _literal_ question mark?

Sometimes, you might want to check that there's actually a question mark in the string. In this case, you can __escape__ the `?` with a back slack (`\`), like this: `\?`. That tells the regex that you mean that letter _literally_. So to match any strings with question marks in them, you could use:

``` ruby
/\?/
```

There are also other modifiers, but we'll be diving into them more thoroughly later in this lesson.

---

## Using regex to filter or validate attributes in Rails

Ruby has a method for replacing parts of strings, called `gsub`, short for "globally substitute" - which is just fancy talk for "replace all". Here's an example in action:

``` ruby
"I'm totally not talking about Fight Club right now.".gsub(/Fight ?Club/i, 'the mall')
```

That should return:

``` output
=> "I'm totally not talking about the mall right now."
```

As you can see, `gsub` takes two parameters. The first is what we want to find and the second is what we want to replace it with. In our example, we've replaced any mentions of Fight Club with "the mall" so that no one knows what we're _really_ talking about.

To use this technique on the blogging webapp from previous lessons, we could add this to the `Post` model:

``` ruby
before_validation :replace_fight_club_in_content

def replace_fight_club_in_content
  self.content = content.gsub(/Fight ?Club/i, 'the mall')
end
```

Or if you'd prefer that users fix the mistake themselves, you could add an error with a validation:

``` ruby
validate :fight_club_not_in_content

def fight_club_not_in_content
  if content =~ /Fight ?Club/i
    errors.add(:content, "talks about Fight Club. Do we really have to go over the first rule again?!")
  end
end
```

---

## Diving deep into regular expressions with a game!

Guess what? There's a great game for exploring regular expressions! It's called [RegexOne](http://regexone.com/). I want you to completely finish the tutorial, then come back here. You can complete the "Additional Problems" as well if you'd like, but only if you're _really_ geeking regular expressions at that point.

---

## Using regex with format validations

Now that you have a firmer grasp of regular expressions, let's circle around back to the format validations introduced in the last lesson. As we learned, you can use regular expressions to strictly control the format of specific attributes, like this for example:

``` ruby
validates :phone_number, format: {
  with: /\A\d{3}-\d{3}-\d{4}\z/,
  allow_blank: true,
  message: "isn't a correctly formatted phone number: e.g. 123-456-7890"
}
```

That regular expression should make a little more sense now, but the `\A` at the beginning and `\z` at the end will still be unfamiliar. They match the beginning of a string and end of a string, respectively. Now you may be thinking,
"Wait? Don't `^` and `$` do that?". In _JavaScript's_ regex, which what that game just taught you, yes. In _Ruby's_ regex, no.

Ugh, there are different _dialects_ of regular expressions? Yes, unfortunately. But don't worry, most dialects are _very, very_ similar. The entire time that you're using regex, you'll probably only ever have to be aware of this one difference:

- In JavaScript, `^` and `$` match the beginning of a _string_ and end of a _string_, respectively.
- In Ruby, `^` and `$` match the beginning of a _line_ and end of a _line_, respectively. To match the beginning and end of a _string_ like in JavaScript, you'll use `\A` and `\z` (mind the cases).

So what's the practical difference? What would happen if we validated `phone_number` with `/^\d{3}-\d{3}-\d{4}$/` instead? Well, this kind of input would be allowed:

```
I'm technically on a separate line as the phone number
555-555-5555
so the validation will still pass if you're using `^` and `$`.
```

Yuck, so just remember this for Ruby format validations: __always begin your regex with `\A` and end it with `\z`, so that you can strictly control what users submit__.

---

## Investigating weird regular expressions

I would say it's nearly impossible to _master_ regular expressions. They can get pretty complex! And you know what? You shouldn't have to. Why learn a super obscure feature of regex that you might never even use?

Instead, the best strategy is to just Google stuff when your regex skills fail you. The trick here is you always want to prepend your searches with the name of the language you're using, then "regex". So for example, if I wanted to find the regex for German letters with an umlaut (letters with two dots above it like `ä`, `ö`, and `ü`), I might search for [`ruby regex umlaut letters`](https://www.google.com/search?q=ruby+regex+umlaut+letters).

Besides Google though, there are two other resources I find _immensely_ useful in the situations where I need to construct some more complicated regex:

- [The character properties documentation](http://ruby-doc.org/core-2.2.0/Regexp.html#class-Regexp-label-Character+Properties) for Ruby's regex is a fantastic and very thorough guide to targeting groups of characters that might otherwise require very, very long regular expressions.
- [rubular.com](http://rubular.com/) is a great little webapp for testing out Ruby's regular expressions in real time.
