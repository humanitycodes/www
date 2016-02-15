## What's an object?

Let's say I have a person I want to store information about. In JavaScript, I could store their first name and age in variables, like so:

``` js
var firstName = 'Sam'
var age = 27
```

This works great, until you need to work with _many_ people, all with their own first names and ages. We could add prefixes to differentiate all of these:

``` js
var person1FirstName = 'Sam'
var person1Age = 27

var person2FirstName = 'Amani'
var person2Age = 34
```

But it feels like a clunky solution. And what if we wanted to store an array of people, with all their attributes? Now we're really in trouble.

Fortunately, JavaScript has a trick up its sleeve for situations just like this: __objects__. This is an object:

``` js
{
  'firstName': 'Sam',
  'age': 27
}
```

Similar to how an array is surrounded by square brackets (`[]`), an object is surrounded by curly braces (`{}`). Inside the curly braces is a comma-separated list of __keys__ and __values__.

The keys are the strings on the left (`'firstName'`, `'lastName'`, `'age'`, etc). Keys are _always_ strings. They are the labels for the values on the right.

Values, on the other hand, can be _any_ data type: strings, numbers - even arrays and objects. Now to start playing with this object, let's first assign it to a variable:

``` js
var person1 = {
  'firstName': 'Sam',
  'age': 27
}
```

To retrieve one of these values by its key, we can use square brackets, just like when retrieving an item from an array by its index:

``` js
person1['firstName']
=> "Sam"

person1['age']
=> 27
```

---

## Working with objects in arrays

Objects also solve our problem of storing a lists of people. To store both Sam and Amani in an array, we can write:

``` js
var people = [
  {
    'firstName': 'Sam',
    'age': 27
  },
  {
    'firstName': 'Amani',
    'age': 34
  }
]
```

Then to retrieve the first name of the first person in our array, we can _chain_ square brackets.

``` js
people[0]['firstName']
=> 'Sam'
```

To retrieve the age of the last person in our array, it's similar:

``` js
people[people.length - 1]['age']
=> 34
```

In both cases, we're:

1. retrieving a specific person, using the array index
2. retrieving the value for a specific property in the object, using its key

---

## Finding specific items in an array

When working with arrays of objects, we'll often have very specific questions in mind, like "How old is Sam?" To answer that question, we first need to find any people with a first name of "Sam". JavaScript arrays have a special method just for this purpose, called __`filter`__.

Here's an example:

``` js
var peopleNamedSam = people.filter(function(person) {
  return person['firstName'] === 'Sam'
})
```

`filter` goes through each item in the array and passes it to a function we provide. If the function returns `true`, that item is added to a new array that `filter` returns. If the function returns `false`, then the item is essentially _filtered out_.

It's important to note that unlike many array methods we've seen before, such as `push` and `splice`, __the original array is _not_ modified by `filter`__. Instead, we now have two arrays. There's the new array, `peopleNamedSame`, with only people named Sam:

``` js
peopleNamedSam
=> [{ 'firstName': 'Sam', 'age': 27 }]
```

And the original array, `people`, still contains everyone:

``` js
people
=> [{ 'firstName': 'Sam', 'age': 27 }, { 'firstName': 'Amani', 'age': 34 }]
```

Now going back to our original question: "How old is Sam?" We can use our new array (`peopleNamedSam`) to print to console how many people are named Sam, then print out the age of the first Sam we found:

``` js
console.log('There are ' + peopleNamedSam.length + ' people named Sam.')
console.log('The first Sam found is ' + peopleNamedSam[0]['age'] + ' years old.')
```

---

## Shorthands for working with object keys

Something you may have noticed already is that programmers are lazy. So instead of writing object keys with quotes, JavaScript allows you to leave them out entirely. That means:

``` js
var person = {
  'firstName': 'Diya',
  'age': 14
}
```

can be rewritten as:

``` js
var person = {
  firstName: 'Diya',
  age: 14
}
```

Both examples do exactly the same thing. `firstName` and `age` are _still_ strings, but since JavaScript already knows that the key will always be a string, it's being nice and allowing you to leave out the quotes.

There's a similar shorthand for retrieving values from an object:

``` js
person['firstName']
```

can also be written as:

``` js
person.firstName
```

Again, these two examples do _exactly_ the same thing, but one allows us to do a little less typing.

### Except for keys that aren't valid variable names

In order to use these shorthands, keys can't contain any characters that couldn't be in a variable name. So for example, spaces are a no-no. It's technically possible to write object keys like this:

``` js
var person = {
  'first name': 'Diya',
  'age in Earth years': 14
}
```

But then you _must_ use quotes for the keys. Similarly, when retrieving these values, you must use square brackets with quotes, like so:

``` js
person['first name']
person['age in Earth years']
```

For this reason, __it's best practice (for optimal laziness!) to only use object keys that are also valid variable names__.

### _And_ except for dynamic objects

Sometimes when you're fetching or retrieving a value from an object, you don't know what the keys will be ahead of time. For example, let's go back to this array of people:

``` js
var people = [
  {
    firstName: 'Sam',
    age: 27
  },
  {
    firstName: 'Amani',
    age: 34
  }
]
```

What if we want a function that can search by _any_ attribute? This would do the trick:

``` js
function findPeopleBy(attribute, value) {
  return people.filter(function(person) {
    return person[attribute] === value
  })
}
```

As you may notice, we're using the long-form version `person[attribute]`, instead of `person.attribute`. What's wrong with `person.attribute` in this case? Well, the long-form of that isn't `person[attribute]`, but rather `person['attribute']`. Do you see the subtle difference?

The former is passing in the value of an `attribute` variable, but the latter is passing in the literal string, `'attribute'` - which is not dynamic and certainly not what we want. This will be made clearer with examples:

``` js
findPeopleBy('age', 34)
// => [{ firstName: 'Amani', age: 34 }]

findPeopleBy('firstName', 'Sam')
// => [{ firstName: 'Sam', 'age': 27 }]
```

Above, our first example answers the question, "Who has an age of 34?". The second example answers the question, "Who has a first name of Sam?" If we changed `person[attribute]` to `person.attribute`, it would instead answer the questions, "Who has an attribute of 34?" and "Who has an attribute of Sam?", respectively. Since our objects don't have a property with a key of `'attribute'`, this will always return an empty array.

This is a subtle, but important point to grasp, so if you still need a little more guidance, just wave over a mentor.

---

## Adding new properties to objects

You're going to love how easy this is. Let's say you have this object.

``` js
var person = {
  firstName: 'Diya',
  age: 14
}
```

To add new properties, you can just make up a name and assign a value:

``` js
person.lastName = 'Mehta'
person.email = 'diyamehta@example.com'
person.favoriteColor = 'rgb(84, 142, 83)'
```

---

## Removing from objects

This one is also pretty straightforward. Let's take this same object:

``` js
var person = {
  firstName: 'Diya',
  age: 14
}
```

If Diya decides she doesn't want to share her age, you could remove it with:

``` js
delete person.age
```

Now the age is gone from the `person` object:

``` js
person
=> { firstName: 'Diya' }
```

---

## Building a mega ultra super extreme joke generator

Congratulations! You've now covered _all_ the basics of working with objects. So let's walk through a real application together.

Remember that very first JavaScript project, where you built a button that displayed a joke to the user? It probably looked something like this:

``` js
document.getElementById('joke-button').onclick = function() {
  alert('Two guys walk into a bar. The third guy ducks.')
}
```

Well what if we wanted users to be able to choose from several categories of jokes, like absurd, word play, and jokes that are funny because they're true? And what if we wanted to spread out the setup and punchline to our joke?

We've seen arrays of objects, but you can actually nest arrays and objects in any order you like and as deeply as you like. Here's _an object of arrays of objects_ we can use to store a more complex set of jokes:

``` js
var jokes = {
  absurd: [
    {
      setup: "My mother told me it's polite to go to other people's funerals.",
      punchline: "Otherwise, they won't go to yours."
    },
    {
      setup: "A horse walks into the bar. The bartender asks...",
      punchline: "Why the long face?"
    }
  ],
  wordPlay: [
    {
      setup: "Two guys walk into a bar.",
      punchline: "The third guy ducks."
    },
    {
      setup: "How does Orion keep his pants up?",
      punchline: "With an asteroid belt."
    }
  ],
  funnyBecauseTrue: [
    {
      setup: "What's the difference between an etymologist and an entomologist?",
      punchline: "An etymologist would know the difference."
    },
    {
      setup: "If you need money, just borrow it from a pessimist.",
      punchline: "They don't expect it back."
    }
  ]
}
```

And instead of a single button, let's build a form that allows the user to choose which kind of joke they want to hear:

``` html
<form id="joke-form">
  <input type="radio" name="jokeType" value="absurd" checked> Absurd<br>
  <input type="radio" name="jokeType" value="wordPlay"> Word play<br>
  <input type="radio" name="jokeType" value="funnyBecauseTrue"> Funny cuz it's true
  <button type="submit">Tell me a joke!</button>
</form>
```

Now back to our JavaScript, here's how we could tell a random joke from the requested category, with the setup first, _then_ the punchline, for perfect comedic timing!

``` js
document.getElementById('joke-form').onsubmit = function(event) {
  // Prevents the form from actually submitting. Normally when a
  // form submits, it sends information to a server. But in this
  // case, we don't want to navigate away from the current page or
  // do _anything_ with a server. Instead, we want to stay on the
  // current page and run the Javascript that follows.
  event.preventDefault()

  // Finds the radio button that's checked and stores the value. You
  // probably haven't seen `document.querySelector` before, but it's
  // similar to `document.getElementById`, except you can use _any_
  // CSS selector to find the element.
  var jokeType = document.querySelector('input[name="jokeType"]:checked').value

  // Stores a random joke of the requested joke type.
  var joke = jokes[jokeType][Math.floor(Math.random() * jokes[jokeType].length)]

  // Tells the joke.
  alert(joke.setup)
  alert(joke.punchline)
}
```

This would not be possible without objects!
