## Managing lists of items with arrays

In JavaScript, there's special data type called __Array__ for organizing ordered lists of things. Here's an example:

``` js
[
  'Harry Potter and the Sorcerer\'s Stone, by J.K. Rowling', // 12
  'Lord of the Flies, by William Golding',                   // 20
  'Dune, by Frank Herbert',                                  // 23
  'A Wrinkle in Time, by Madeleine L’Engle',                 // 26
  'Carrie, by Stephen King',                                 // 30
  'Gone with the Wind, by Margaret Mitchell',                // 38
]
```

That's a list of books, ordered by how many times they were rejected by publishers. We defined the list with square brackets (`[]`), containing a list of comma-separated values.

Just like other data types, you can assign it to a variable.

``` js
var books = [
  'Harry Potter and the Sorcerer\'s Stone, by J.K. Rowling',
  'Lord of the Flies, by William Golding',
  'Dune, by Frank Herbert',
  'A Wrinkle in Time, by Madeleine L’Engle',
  'Carrie, by Stephen King',
  'Gone with the Wind, by Margaret Mitchell',
]
```

Each item in an array has a number called an __index__, which is used to get that item from the array. Here are the indices for the array above:

<table class="table table-striped">
  <thead>
    <tr>
      <th>Index</th>
      <th>Value</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>0</code></td>
      <td><code>"Harry Potter and the Sorcerer's Stone, by J.K. Rowling"</code></td>
    </tr>
    <tr>
      <td><code>1</code></td>
      <td><code>"Lord of the Flies, by William Golding"</code></td>
    </tr>
    <tr>
      <td><code>2</code></td>
      <td><code>"Dune, by Frank Herbert"</code></td>
    </tr>
    <tr>
      <td><code>3</code></td>
      <td><code>"A Wrinkle in Time, by Madeleine L’Engle"</code></td>
    </tr>
    <tr>
      <td><code>4</code></td>
      <td><code>"Carrie, by Stephen King" </code></td>
    </tr>
    <tr>
      <td><code>5</code></td>
      <td><code>"Gone with the Wind, by Margaret Mitchell"</code></td>
    </tr>
  </tbody>
</table>

To get the first item from the `books` array, we can use:

``` js
books[0]
=> "Harry Potter and the Sorcerer's Stone, by J.K. Rowling"
```

You may be thinking, "Wait? Why do the indices start at 0 instead of 1. Wouldn't it make more sense for the _1st_ item to have an index of _1_?" I've thought the exact same thing.

The reason an index starts at 0, is it describes __the distance from the start of the array__. The first element _is_ at the start of the array, so there is no distance. It's 0.

OK. So we've accessed the first item. How would we access the 2nd?

``` js
books[1]
=> "Lord of the Flies, by William Golding"
```

The third would be:

``` js
books[2]
=> "Dune, by Frank Herbert"
```

And so on. But what would happen if we tried to get an index that doesn't exist, like the 100th item in `books`?

``` js
books[99]
=> undefined
```

`undefined` is a special value that means what we were looking for hasn't been set yet. We haven't added that many books to the `books` array, so the result is undefined.

OK, but _one last thing_. What if we wanted to get the last item in the array and we didn't remember how long it was. Fortunately, there's a method on arrays called `.length`.

``` js
books.length
=> 6
```

This is useful, because the index of the last item is always the length of the array, minus 1. So we can access the last item in `books` with:

``` js
books[ books.length - 1 ]
=> "Gone with the Wind, by Margaret Mitchell"
```

---

## Adding items to an array

OK, so we just found out that Agatha Christie was rejected _hundreds_ of times! Pretty amazing, considering she's the most published author in the world after Shakespeare. Since she's the most rejected author we have so far, she should be added to the very end of our list.

### Adding to the _end_ of an array

We can do this with the `push` method:

``` js
books.push('The Mysterious Affair at Styles, by Agatha Christie')
=> 7
```

Notice that when pushing, the new length of the array is returned. To get the new contents of the array, we can run `books`:

``` js
books
=> [
  "Harry Potter and the Sorcerer's Stone, by J.K. Rowling",
  "Lord of the Flies, by William Golding",
  "Dune, by Frank Herbert",
  "A Wrinkle in Time, by Madeleine L’Engle",
  "Carrie, by Stephen King",
  "Gone with the Wind, by Margaret Mitchell",
  "The Mysterious Affair at Styles, by Agatha Christie"
]
```

### Adding to the _beginning_ of an array

And as it turns out, _Anne of Green Gables_ was also also rejected 5 times, which makes it the least rejected item in our list so far. So let's add it to the beginning of our array with the `unshift` method:

``` js
books.unshift('Anne of Green Gables, by L.M. Montgomery')
=> 8
```

This once again returns the new length of the array. And I know, `unshift` is kind of a weird name. I wish I had a way of making it click, but you might just have to remember this one. Here's a trick though! Just start using the word in casual conversation. Here are a couple suggestions:

- _Excuse me, sir - would you mind if I ~~cut~~ unshift in line?_
- _I rarely wear this shirt, so I think I'll ~~put~~ unshift it at the bottom of my dresser._

Now once again, let's run `books` to check out the updated array:

``` js
books
=> [
  "Anne of Green Gables, by L.M. Montgomery",
  "Harry Potter and the Sorcerer's Stone, by J.K. Rowling",
  "Lord of the Flies, by William Golding",
  "Dune, by Frank Herbert",
  "A Wrinkle in Time, by Madeleine L’Engle",
  "Carrie, by Stephen King",
  "Gone with the Wind, by Margaret Mitchell",
  "The Mysterious Affair at Styles, by Agatha Christie"
]
```

### Adding to the _middle_ of an array

OK, just one more. _The Diary of Anne Frank_ was rejected 15 times, which means it should go between _Harry Potter and the Sorcerer's Stone_ and _Lord of the Flies_. `push` and `unshift` only work for adding to the end or beginning of the array, respectively, so we need something new: `splice`.

Yeah, it has another weird name. And it's not _quite_ as simple to use as the other methods we've seen so far. It takes 3 parameters:

``` js
array.splice(startingIndex, numberOfItemsToRemove, newItem)
```

Let's review the parameters we'll use:

- Starting index: `2` (we want it where _Lord of the Flies_ currently is)
- Number of items to remove: `0` (we don't want to remove anything)
- New item: `'The Diary of Anne Frank, by Anne Frank'`

Now let's do it!

``` js
books.splice(2, 0, 'The Diary of Anne Frank, by Anne Frank')
=> []
```

This returns an array of the items that were removed. We didn't remove anything though, so it's empty. Now let's check out `books` to make sure it was changed like we wanted:

``` js
books
=> [
  "Anne of Green Gables, by L.M. Montgomery",
  "Harry Potter and the Sorcerer's Stone, by J.K. Rowling",
  "The Diary of Anne Frank, by Anne Frank",
  "Lord of the Flies, by William Golding",
  "Dune, by Frank Herbert",
  "A Wrinkle in Time, by Madeleine L’Engle",
  "Carrie, by Stephen King",
  "Gone with the Wind, by Margaret Mitchell",
  "The Mysterious Affair at Styles, by Agatha Christie"
]
```

Perfect!

<div class="callout callout-info">

  <h4>Note</h4>

  <p>Guess what? Ever heard of <em>gene splicing</em>? Once you understand splicing in arrays, it works the exact same way with genes. You take a piece of DNA, then put it somewhere in the middle of other DNA (sometimes also replacing part of it).

  <p><img src="http://49.media.tumblr.com/tumblr_m1xsquzffW1rt2wnro1_1280.gif" alt="Gene splicing"></p>

  </p>Now you can cooly slip this reference into casual conversation:</p>

  <blockquote>Gene splicing? Yes, yes, I'm familiar. It's the same essential process as that used in array mutation in many programming languages, you see.</blockquote>

  <p><img src="http://i189.photobucket.com/albums/z213/Jayscherer/hmm-yes-quite.jpg" alt="Hmm yes quitet"</p>

</div>

---

## Removing items from arrays

Just like we can add items to the end, beginning, and middle of an array, we can do the same for _removing_ items.

We don't want to remove anything from our `books` array at this point though, so let's create a shorter array we can play around with:

``` js
var numbers = [1, 2, 3, 4, 5]
```

### Removing from the _end_ of an array

The `pop` method removes an item from the end of an array.

``` js
numbers.pop()
=> 5
```

As you can seen, it returned the item that we removed. Taking another look at our number array, we can indeed see that the last item (`5`) was removed.

``` js
numbers
=> [1, 2, 3, 4]
```

### Removing from the _beginning_ of an array

Now to remove the first item in an array, we can use `shift`, which works very similarly to pop.

``` js
numbers.shift()
=> 1
```

It returned the item that was removed and inspecting our array:

``` js
numbers
=> [2, 3, 4]
```

We can see that `1` was indeed removed.

### Removing from the _middle_ of an array

Let's say we now want to remove the number `3`, now at index `1` - neither at the end nor the beginning of the array.

Once again, this is the most complicated case. But! You don't have to learn a new method, because we're using `splice` again - the same method we used to add an item. As a reminder, these are the arguments that `splice` takes:

``` js
array.splice(startingIndex, numberOfItemsToRemove, newItem)
```

Now once again, we'll review these parameters in the context we'll actually use them in:

- Starting index: `1` (we to remove `3` at the 2nd position in the array, which is index 1)
- Number of items to remove: `1` (we only want to remove the number `3`)
- New item: we don't want to add a new item, so this should be left empty

``` js
books.splice(1, 1)
=> [3]
```

As you can see, it returned an array of the items it removed, which in this case, was just the number `3`. Now inspecting your numbers array, we should see that `3` is now gone:

``` js
numbers
=> [2, 4]
```

---

## Creating a todo list

Now here's some good news! 90% of the time, the only methods you'll use for arrays are `push` to add items and `splice` to remove items. So those are really the only ones you have to remember for now. The others are here as a reference.

So let's actually write an application now. In the case of arrays, todo lists are always a great place to start.

For our HTML, all we really need is an input for users to enter a new todo and then a list to add our todos to:

``` html
<input id="new-todo-input" type="text">
<ul id="todo-list"></ul>
```

Perfect! Now let's use JavaScript to add some interactive behavior to those elements.

First, we need some way to keep track of our todos. How about an array unimaginatively called `todos`?

``` js
var todos = []
```

As you can see, it starts out empty. We know we'll also want to add behavior to our two elements, so let's also store them by their `id`s now:

``` js
var todos = []

var newTodoInput = document.getElementById('new-todo-input')
var todoList = document.getElementById('todo-list')
```

Now the first thing a user is going to try to do is type a todo into the input box and press enter, so let's see make something happen when they do that:

``` js
var todos = []

var newTodoInput = document.getElementById('new-todo-input')
var todoList = document.getElementById('todo-list')

newTodoInput.onkeypress = function() {
  console.log('You pressed a key!')
}
```

That displays a message whenever _anything_ is typed into the input, but we only care about the _Enter_ key. So... how do we figure out when the enter key _specifically_ was pressed? Well, doing some Googling, it looks like keypress events have a property called `which`, that contain the numeric key code of the key that was pressed.

That's fantastic... except we still don't know the key code for the Enter key. So let's log out the results and play with it:

``` js
var todos = []

var newTodoInput = document.getElementById('new-todo-input')
var todoList = document.getElementById('todo-list')

newTodoInput.onkeypress = function(event) {
  console.log(event.which)
}
```

With that code, every keypress logs a key code. When I type "Testing", I get:

``` output
84
101
115
116
105
110
103
```

So those must be the key codes for those letters. Now let's try pressing Enter. And... _drumroll_... we get `13`!

So now let's use this knowledge to build our code to the next step again:

``` js
var todos = []

var newTodoInput = document.getElementById('new-todo-input')
var todoList = document.getElementById('todo-list')

newTodoInput.onkeypress = function(event) {
  if (event.which === 13) {
    console.log('You pressed Enter!')
  }
}
```

Yay! It seems to be working. Now let's use our mad array modification skills to add the value of our text input to our `todos` array:

``` js
var todos = []

var newTodoInput = document.getElementById('new-todo-input')
var todoList = document.getElementById('todo-list')

newTodoInput.onkeypress = function(event) {
  if (event.which === 13) {
    todos.push(this.value)
    console.log(todos)
  }
}
```

Again, so far, so good! There is one problem though. When we press enter and the todo gets added to the array, I'd kind of expect the new input todo to empty out so I can start fresh with a new todo. So after we add the value to the array, let's set it to an empty string.

``` js
var todos = []

var newTodoInput = document.getElementById('new-todo-input')
var todoList = document.getElementById('todo-list')

newTodoInput.onkeypress = function(event) {
  if (event.which === 13) {
    todos.push(this.value)
    this.value = ''
    console.log(todos)
  }
}
```

There we go. Now for the todo to actually appear in the page instead of just the console, let's create a separate `renderTodos` function and call it after adding a new todo.


``` js
var todos = []

var newTodoInput = document.getElementById('new-todo-input')
var todoList = document.getElementById('todo-list')

function renderTodos() {
  todoList.innerHTML = todos
}

newTodoInput.onkeypress = function(event) {
  if (event.which === 13) {
    todos.push(this.value)
    this.value = ''
    renderTodos()
  }
}
```

That _technically_ works. The todos show up on the page, separated by commas. Like this:

``` html
todo 1,todo 2, todo3
```

We want something more like this though:

``` html
<li>todo 1</li>
<li>todo 2</li>
<li>todo 3</li>
```

To accomplish this, we can use a special JavaScript function called `map`, which creates a new array with a transformation performed on each item. To turn `todo 1` into `<li>todo 1</li>`, that transform would be `'<li>' + 'todo 1' + '</li>'`, making our map operation:

``` js
todos.map(function(todo) {
  return '<li>' + todo + '</li>'
})
```

If `todos` is currently:

``` js
["todo 1", "todo 2", "todo 3"]
```

Then that `map` will return:

``` js
["<li>todo 1</li>", "<li>todo 2</li>", "<li>todo 3</li>"]
```

Now adding that to our code:

``` js
var todos = []

var newTodoInput = document.getElementById('new-todo-input')
var todoList = document.getElementById('todo-list')

function renderTodos() {
  todoList.innerHTML = todos.map(function(todo) {
    return '<li>' + todo + '</li>'
  })
}

newTodoInput.onkeypress = function(event) {
  if (event.which === 13) {
    todos.push(this.value)
    this.value = ''
    renderTodos()
  }
}
```

It seems to _mostly_ work. We're still getting commas between each `li` element, like this:

``` html
<li>todo 1</li>,<li>todo 2</li>,<li>todo 3</li>
```

That doesn't look great. So what exactly is happening? Why do we keep seeing those commas. The answer is when we set the `innerHTML` of `todoList`, JavaScript is trying to convert our array into a single string. When it does this, it has to decide how to join our list of strings together. By default, it'll do this with a comma.

But we don't want _anything_ in between our array items, so we can turn it into a string ahead of time with a custom `join`.

``` js
todoList.innerHTML = todos.map(function(todo) {
  return '<li>' + todo + '</li>'
}).join('')
```

Do you see that `join('')` on the last line below? That takes each item and combines them into a single string, with an empty string between each item. That makes it so that we don't get:

``` html
<li>todo 1</li>,<li>todo 2</li>,<li>todo 3</li>
```

but:

``` html
<li>todo 1</li><li>todo 2</li><li>todo 3</li>
```

Subtle, but it makes a big difference!

That leaves our final code as:

``` js
var todos = []

var newTodoInput = document.getElementById('new-todo-input')
var todoList = document.getElementById('todo-list')

function renderTodos() {
  todoList.innerHTML = todos.map(function(todo) {
    return '<li>' + todo + '</li>'
  }).join('')
}

newTodoInput.onkeypress = function(event) {
  if (event.which === 13) {
    todos.push(this.value)
    this.value = ''
    renderTodos()
  }
}
```

---

## Removing items from our todo list

So we can add items to do our todo list now and they look pretty good! But now we want a button to remove a todo.

Well, the adding a button part isn't too bad. We can just update our `map` function to:

``` js
todoList.innerHTML = todos.map(function(todo) {
  return '<li>' +
    todo +
    ' <button>X</button>' +
  '</li>'
}).join('')
```

I spread the strings out over multiple lines to make them easier to read. Now looking at that in our browser:

![todos with X button](https://www.dropbox.com/s/l6hh4plr8nk44dd/Screenshot%202016-01-25%2013.29.12.png?dl=1)

OK, off to a good start. Now the buttons just have to do something when we click on them. Normally, this could be a accomplished with a simple:

``` js
document.getElementById('some-id').onclick = function() {
  // some code...
}
```

This is a special case we haven't yet encountered though. We can't specific the click behavior for elements that don't even exist yet! Fortunately, there's a special technique we can use that sounds more complicated than it actually is: __event delegation__.

Instead of watching for an event on the elements that will be dynamically added and removed, you can watch for the event on the containing element that will always be there. In this case, that's our `todoList` element.

``` js
todoList.onclick = function(event) {
  // some code...
}
```

That captures any clicks inside the todo list. Now from here, we want to find the _specific_ element that was clicked on with `event.target`. Then we can start inspecting the element to find out when it's a button and if it is, display a message.

``` js
todoList.onclick = function(event) {
  var clickedElement = event.target
  if (clickedElement.tagName === 'BUTTON') {
    console.log('You clicked on a button inside the todo list!')
  }
}
```

That works, but there's just one more change I want to make. I might later have more buttons to edit the todo or mark it as high priority somehow, so I'll instead check the `className` of the element and add a class to the button.

``` js
var todos = []

var newTodoInput = document.getElementById('new-todo-input')
var todoList = document.getElementById('todo-list')

function renderTodos() {
  todoList.innerHTML = todos.map(function(todo) {
    return '<li>' +
      todo +
      ' <button class="remove-todo">X</button>' +
    '</li>'
  }).join('')
}

newTodoInput.onkeypress = function(event) {
  if (event.which === 13) {
    todos.push(this.value)
    this.value = ''
    renderTodos()
  }
}

todoList.onclick = function(event) {
  var clickedElement = event.target
  if (clickedElement.className === 'remove-todo') {
    console.log('You clicked on a button inside the todo list!')
  }
}
```

Excellent! Now we only have one problem remaining. When a button is clicked, how will we know _which_ todo to remove. For this, there's a special kind of attribute we can use called a __data attribute__. As you might guess from the name, it's for attaching extra data to an element! If I wanted to attach a name of "Chris" to an element, I could add `data-name="Chris"` to its list of attributes.

In this case, we want to add the `index` of the item, which we can get from a second parameter in our `map` function, then set it to a `data-index` attribute.

``` js
todoList.innerHTML = todos.map(function(todo, index) {
  return '<li>' +
    todo +
    ' <button class="remove-todo" data-index="' + index + '">X</button>' +
  '</li>'
}).join('')
```

Now we can access the `dataset.index` of our clicked element to get the index of the item we should remove from the array, then call our `renderTodos` function to update the page.

``` js
todoList.onclick = function(event) {
  var clickedElement = event.target
  if (clickedElement.className === 'remove-todo') {
    todos.splice(clickedElement.dataset.index, 1)
    renderTodos()
  }
}
```

And all together now, our new code is:

``` js
var todos = []

var newTodoInput = document.getElementById('new-todo-input')
var todoList = document.getElementById('todo-list')

function renderTodos() {
  todoList.innerHTML = todos.map(function(todo, index) {
    return '<li>' +
      todo +
      ' <button class="remove-todo" data-index="' + index + '">X</button>' +
    '</li>'
  }).join('')
}

newTodoInput.onkeypress = function(event) {
  if (event.which === 13) {
    todos.push(this.value)
    this.value = ''
    renderTodos()
  }
}

todoList.onclick = function(event) {
  var clickedElement = event.target
  if (clickedElement.className === 'remove-todo') {
    todos.splice(clickedElement.dataset.index, 1)
    renderTodos()
  }
}
```

---

## Now it's your turn

At this point, you're taking over this code base and implementing some new features in the project. If you run into a problem you're not sure how to solve, don't hesitate Googling for more information. Or if you try that for a while and are still stuck, ask a mentor for help.
