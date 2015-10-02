## Comparing strings

``` js
var codeword = prompt("Psst... what's the codeword?")
```

Now let's check if their codeword is correct.

``` js
codeword === "Bananas"
```

Depending on what you entered in the prompt, that should either return `true` or `false`.

The `===` (pronounced "triple equals") checks to see if the value of `codeword` is `"Bananas"`. There's also a `==` (pronounced "double equals") which does something similar, but can sometimes have unexpected results, so for now, _always_ use the `===`.

So let's review a bit:

- `=` is for __assignment__ (i.e. when we want to set the value of something)
- `==` we won't worry about for now and for the time being, will avoid
- `===` is for checking the equality of two things

One final thing that's worth noting. Checking if input from a user equals a string is _not_ a good password system, because to hack your system, someone could just read your JavaScript for the right answer!

---

## Other comparators

`===` is not the only comparator (i.e way of comparing two values). There's also:

- `>` (greater than)
- `<` (less than)
- `>=` (greater than or equal to)
- `<=` (less than or equal to)

Twitter uses some of these other comparators to check if a tweet is too long. Let's try making a simple version that's similar to what they do:

``` js
var tweet = prompt("What would you like to tweet?")
```

Remember how we checked the length of a string with `.length`? You could check if

``` js
tweet.length > 140
```

That will return `true` if the tweet is too long and `false` it's short enough.

---

## `if` statements

Sometimes, if the result of comparing two things is true, you want to do one thing, and if it's false, you want to do another thing. That's what `if` statements are for.

``` js
if (tweet.length > 140) {
  alert("Sorry, that tweet is too long: " + tweet.length + " characters.")
}
```

Above, we check if the tweet length is greater than 140 characters and _only if that's true_ do we alert the user that their tweet was too long.

You can do this with any comparator and any code:

``` js
if ( /* COMPARATOR */ ) {
  /* WHAT WE WANT TO DO IF COMPARATOR IS TRUE */
}
```

---

## `if-else` statements

Sometimes what you want to do is a little more complicated. In those cases, you can `else` to chain `if` statements together and also specify what happens if everything is false.

``` js
if (tweet.length > 140) {
  alert("Sorry, that tweet is too long: " + tweet.length + " characters.")
} else if (tweet.length === 140) {
  alert("Wow, exactly 140 characters! You just squeezed in there!")
} else {
  alert("That tweet works. If this were actually Twitter, you'd be tweetin' up a storm now!")
}
```

`else` can be read to mean "otherwise". Above:

- IF the tweet is too long, we tell that to the user
- OTHERWISE IF the tweet is exactly 140 characters long, we should tell the user about this fact
- OTHERWISE (meaning if the all of the above statements return false), we congratulate the user on a well-formed tweet
