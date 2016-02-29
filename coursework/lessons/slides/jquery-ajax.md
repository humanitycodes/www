## What's Ajax?

You know pages that save your work as you type, like on Wordpress or Google Docs? Or when a search engine shows you suggestions as you type? They're all using a technique called __Ajax__.

It's when you want to _save_ information _to_ a server (like when saving work) or when you want to _get_ information _from_ a server, like with search suggestions - all while staying on the same page, without refreshing.

To help with this kind of work, jQuery has an `ajax` method, which makes it easy to implement features like this, often in less than a dozen lines of code!

Here's a simple example:

``` js
$.ajax('http://yesno.wtf/api/')
  .done(function(response) {
    alert(response.answer)
  })
```

That code gets a response from [yesno.wtf](http://yesno.wtf/), which is a website for helping you arbitrarily decide on yes/no questions. Once it receives the response, we'll send the user the answer in an alert.

Now let's attach that code to the `click` event of a button:

``` html
<button id="yesno-ajax-demo-button">
  Yes or No?
</button>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
<script>
  $('#yesno-ajax-demo-button').on('click', function() {
    $.ajax('http://yesno.wtf/api/')
      .done(function(response) {
        alert(response.answer)
      })
  })
</script>
```

And see if it works:

<p><button id="yesno-ajax-demo-button" onclick="javascript:jQuery.ajax('http://yesno.wtf/api/').done(function(response){alert(response.answer)})">Yes or No?</button></p>

Try that button a bunch of times. Sometimes you should get "yes" and sometimes "no", because each time you click, that JavaScript is visiting [yesno.wtf/api](http://yesno.wtf/api/) and getting a new answer.

Yay! That's Ajax. It might still seem a little like magic at this point, so let's break down the entire process over the next pages.

---

## JSON APIs: How websites talk to each other

Sometimes when programming on the web, you want to fetch information from another website or even from your own website. But _you_ want to decide what to do with it. _You_ want to decide what users see.

Take a look at this HTML:

``` xml
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>The Current Weather</title>
  </head>
  <body>
    <h1>It's sunny outside right now!</h1>
    <p>The temperature is 84°F, which equivalent to 28.9°C.</p>
  </body>
</html>
```

The problem with HTML is it comes with all this contextual information around the raw data. It's already decided how the entire page looks, when all we care about is that it's `sunny` and `84°F`/`28.9°C`.

That's why websites often have special areas _just_ for programmers. They're called __APIs__, short for "Application Programming Interface". And instead of HTML, many APIs use a more data-oriented language called __JSON__, which stands for "JavaScript Object Notation". I know, I know - it's a lot of acronyms. It's less complicated than it sounds though.

Here's how an API might display the same weather information in JSON:

``` js
{
  "condition": "sunny",
  "temperature": {
    "fahrenheit": 84,
    "celsius": 28.9
  }
}
```

It looks just like a JavaScript object! And in this object, we've stripped away everything but the raw facts. Now we could fetch and display this information in our app with code like this:

``` js
$.ajax('http://imaginary-weather-website.com/api/?zip=48823')
  .done(function(response) {
    alert('It\'s ' + response.temperature.fahrenheit '°F and ' + response.condition + ' today in East Lansing, MI.')
  })
```

The resulting alert should look something like this:

![Weather alert example](https://www.dropbox.com/s/um93uoyg8rwkwah/Screenshot%202016-01-10%2011.49.34.png?dl=1)

Now let's go back to our first Ajax example:

``` js
$.ajax('http://yesno.wtf/api/')
  .done(function(response) {
    alert(response.answer)
  })
```

If you visit `http://yesno.wtf/api/` in your web browser, you should see something like this:

``` md
{"answer":"no","forced":false,"image":"http://yesno.wtf/assets/no/20-56c4b19517aa69c8f7081939198341a4.gif"}
```

You'll notice that it's all squooshed together on the same line without spaces, which is done so it downloads faster. If you squint, you can see see colon-connected pairs, separated by commas. Now to make it easier to read, I'll add some spaces, spread this over multiple lines, and add some syntax highlighting:

``` js
{
  "answer": "no",
  "forced": false,
  "image": "http://yesno.wtf/assets/no/20-56c4b19517aa69c8f7081939198341a4.gif"
}
```

Much better! So the information we're given is:

- The `"answer"` is `"no"`
- `"forced"` is `false` (I guess meaning we didn't force an answer?)
- The `"image"` is `"http://yesno.wtf/assets/no/20-56c4b19517aa69c8f7081939198341a4.gif"`

### Diving into JSON

As you've seen, JSON looks a lot like JavaScript objects. Just like with objects, the keys in a property are _always_ strings. The values, on the other hand, can be in lots of different data types, including:

- String (ex. `"sunny"`, `"raining"` - note that every string in JSON is always wrapped in double quotes (`""`), as it doesn't allow single quotes (`''`) like JavaScript)
- Number (ex. `1`, `1.234`)
- Boolean (`true` or `false`)
- Array (ordered list, ex. `[1, 2, 3]`, `["heavy fog", "rain"]`)
- Object (dictionary, ex. `{ "fahrenheit": 84, "celsius": 28.9 }`)
- `null` (meaning N/A)

So a real page in a weather API might be more complex, perhaps using all the available data types, like this:

``` js
{
  "conditions": [
    "heavy fog",
    "rain",
    "flooding"
  ],
  "dailyTotals": {
    "rainfall": {
      "inches": 40,
      "centimeters": 102
    },
    "snowfall": null
  },
  "temperature": {
    "actual" : {
      "fahrenheit": 84,
      "celsius": 28.9
    },
    "feelsLike": {
      "fahrenheit": 78,
      "celsius": 25.6
    }
  },
  "wind": {
    "speed": {
      "knots": 7,
      "mph": 8,
      "kph": 12.9
    }
  },
  "weatherAlerts": {
    "severe": false,
    "tornado": false,
    "flooding": true
  }
}
```

---

## Exploring JSON

Now it's relatively easy to read very short JSON, but sometimes JSON is much longer, like [all the Code Lab lessons](/lessons.json). Go ahead and click on that link. Look at the response. Not as easy to figure out what's going on, is it?

In cases like that, many websites (like [GitHub](https://developer.github.com/v3/)!) will have thorough documentation on their API to help you learn how to use it. Sometimes though, it's easier to just do some investigating yourself.

So here's my trick for making sense of seemingly unreadable JSON. Go ahead and paste this into your JavaScript console on this page right now:

``` js
jQuery.ajax('https://lansingcodelab.com/lessons.json')
  .done(function(response) {
    testData = response
    console.log('got response!')
  })
```

We're fetching the response with jQuery, then assigning it to a variable without the `var` keyword. When there's no `var`, the variable is __global__ (meaning it can be accessed _anywhere_ - not just in the function). You want to avoid global assignment like the plague in normal code, but it can be useful in debugging if you want to play with a variable in the JavaScript console.

Now once you've run that code and you see the phrase `got response!` logged, you're free to play with `testData` by just entering its name:

``` js
testData
```

Which should return something like this:

``` js
Object {user: Object, authenticityToken: "nHcSSvzmeQh2rHlS6tdmEZm8n4SyFph4GMrwA6Hd33Ym/GpT0Lr+vdfJpPtKiDyvX16sbMzpMHIfw+bNdTqqhw==", lessons: Array[32]}
```
c x
You'll even be able to interact with that object and expand it with black triangles next to objects. It looks like this in Chrome:

![Exploring objects in chrome](https://www.dropbox.com/s/kizghx5yexxtd3r/Screenshot%202016-01-10%2022.43.48.png?dl=1)

So we can see that one of the keys is `lessons`, whose value is an array of 32 different items. Let's grab the first one and inspect it:

``` js
testData.lessons[0]
```

Do you see something like this?

![Exploring objects in chrome](https://www.dropbox.com/s/wjp7tesubqks5rs/Screenshot%202016-01-10%2022.45.49.png?dl=1)

That tells us each lesson has `categories`, a `key`, `prereqs`, a `project`, `slides`, and a `title`. You can keep going like this, exploring deeper and deeper, until you get to the information you want to use on your page.

<div class="callout callout-info">

  <h4><strong>Note</strong>: Why avoid global variables?</h4>

  <p>In the function below, we assign a value to a new variable: `location`.</p>

<pre><code class="lang-js">function updateUserLocation(address, city, state) {
  location = address + '\n' + city + ', ' + state
  // ... and some more code ...
}</pre></code>

  <p>But the new variable assignment is conspicuously lacking a preceding `var`, so that `location` has a global context. But hey, what's the worst that could happen?</p>

  <p>Well, let's say you then ran:</p>

<pre><code>updateUserLocation(
  '325 E Grand River',
  'East Lansing',
  'Michigan'
)</code></pre>

  <p>It would navigate the user to a new webpage: `325%20E%20Grand%20RiverEast%20Lansing,%20Michigan`. Yikes! That's because `location` is one of the 200+ predefined global variables in web browsers. So instead of assigning a value to a new variable, we've overwritten the value of an existing, global variable. Reassigning `location` has a very obvious effect, but other bugs would be more subtle and difficult to catch.</p>

  <p>So, unless you want to memorize every global variable used in every browser and never reuse a variable name throughout your entire codebase, __always start new variable declarations with `var`__. `var location = ...` would have prevented this bug.</p>

  <p>On the other hand though... being able to reassign globals can be fun sometimes too. As a prank, try sneaking this into your code somewhere:</p>

<pre><code>console.log = (function() {
  var log = console.log
  return function() {
    log.call(
      console,
      ['s','a','n','d','w','i','c','h'].join('')
    )
  }
})()</pre></code>

  <p>Then ask a friend to help you debug it and watch their increasingly confused expression as they try to figure out why any time they run `console.log`, it always prints `"sandwich"`. _Always_. And when they try to search your codebase for the word `sandwich`, they won't find it because of the way the string is being constructed.</p>

  ![Gandalf debugging](https://i.imgflip.com/zzvls.jpg)

  <p>Don't wait _too long_ before telling them though... I don't want to be responsible for any destroyed relationships.</p>

</div>

---

## Loading and exploring test data

So let's start playing with a real API and build a real feature. On many pages, you might see a loading indicator for a second, then some real data.

<p><button onclick="javascript:(function(){loadingDataExampleContainer.innerHTML = '<span class=\'glyphicon glyphicon-loading\'></span> Loading...';jQuery.ajax('http://api.lansing.codes/v1/events/upcoming/list').done(function(response){loadingDataExampleContainer.innerHTML = '<ul>' + response.data.map(function(event){return '<li><a href=\'' + event.links.self + '\'>' + event.attributes.name + '</a></li>'}).join('') + '</ul>'}).error(function(error){loadingDataExampleContainer.innerHTML = '<ul><li><a href="http://www.meetup.com/GLUGnet/events/229005039/">Capital Area IT Council Networking Event</a></li><li><a href="http://www.meetup.com/Lansing-DevOps-Meetup/events/228964468/">Building a Bridge between AWS and Azure</a></li><li><a href="http://www.meetup.com/Mid-Michigan-Agile-Group/events/224510987/">Lean Lunch</a></li><li><a href="http://www.meetup.com/Lansing-Area-R-Users-Group/events/229153388/">R discussion and help</a></li><li><a href="http://www.meetup.com/PMI-Capital-Area-Chapter-Lunch-and-Learn/events/225586668/">Capital Area PMI Chapter Monthly Lunch and Learn</a></li><li><a href="http://www.meetup.com/Lansing-Ruby-Meetup-Group/events/228759282/">Something Involving Rails</a></li><li><a href="http://www.meetup.com/GLASS-Greater-Lansing-Area-for-SQL-Server/events/228876633/">GLASS March Meetup: Common SQL Server Mistakes and How to Avoid Them</a></li><li><a href="http://www.meetup.com/lansingweb/events/228742559/">Monthly Meetup</a></li><li><a href="http://www.meetup.com/Lansing-Javascript-Meetup/events/227924593/">Webpack (and other bundlers) with Miguel Castillo</a></li><li><a href="http://www.meetup.com/MoMoLansing/events/229053738/">Project-Based Innovation and the Fledge with Jerry Norris</a></li></ul>'})})()">
  Click to fetch the upcoming tech events for the Lansing area
</button></p>

<p id="loadingDataExampleContainer"></p>

_That's_ what we're going to build. Well, almost. A lot of the time, we want to fetch this information _as soon as possible_, rather than after a user clicks a button.

So let's pop open an HTML file and add an element to contain our tech events. It'll start out telling the user we're loading, like this:

``` html
<div id="tech-events">
  <p>Loading...</p>
</div>
```

Then we'll add some JavaScript set to run as soon as the page loads. When we get a response, we change the contents of `#tech-events` to the value of `response`. As you'll see below, we're also using `JSON.stringify` to make the JSON appear on the page properly.

``` html
<div id="tech-events">
  <p>Loading...</p>
</div>

<script>
  $.ajax('http://api.lansing.codes/v1/events/upcoming/list')
    .done(function(response) {
      $('#tech-events').html( JSON.stringify(response) )
    })
</script>
```

That'll give us a really ugly look at the upcoming events. But it worked! We got information from another webpage and displayed it.

But... yeah, it's pretty much unreadable. So let's copy that JSON and paste it into [jsonformatter.curiousconcept.com](https://jsonformatter.curiousconcept.com/), then click their _Process_ button. That'll give us a much prettier and easier-to-explore view of the JSON.

---

### Displaying a much nicer version of our JSON

Now that we can reasonably read and explore this JSON, let's figure out how to get each event's name. Browsing the prettier view of our JSON, we'll eventually see that event names are available in this kind of structure:

``` json
{
  "data": [
    {
      "attributes": {
        "name": "The name of the event"
      }
    }
  ]
}
```

That means the name of the first event _should_ be available with `response.data[0].attributes.name`. Let's see if that works:

``` js
$.ajax('http://api.lansing.codes/v1/events/upcoming/list')
  .done(function(response) {
    $('#tech-events').html( response.data[0].attributes.name )
  })
```

Now how would we display a list of _all_ the names? To accomplish this, let's `map` over the array of `data`. Remember that `map` goes through each item in an array and creates a new array with new, transformed data.

``` js
$.ajax('http://api.lansing.codes/v1/events/upcoming/list')
  .done(function(response) {
    $('#tech-events').html(
      response.data.map(function(event) {
        return event.attributes.name
      })
    )
  })
```

That should produce something like this:

```
Capital Area IT Council Networking Event,Building a Bridge between AWS and Azure,Lean Lunch,R discussion and help,Capital Area PMI Chapter Monthly Lunch and Learn,Something Involving Rails,GLASS March Meetup: Common SQL Server Mistakes and How to Avoid Them,Monthly Meetup,Webpack (and other bundlers) with Miguel Castillo,Project-Based Innovation and the Fledge with Jerry Norris
```

We're getting closer, but that presentation can definitely be improved. Let's organize these names in an unordered list, like this:

``` js
$.ajax('http://api.lansing.codes/v1/events/upcoming/list')
  .done(function(response) {
    $('#tech-events').html(
      '<ul>' +
        response.data.map(function(event) {
          return '<li>' + event.attributes.name + '</li>'
        }).join('') +
      '</ul>'
    )
  })
```

As you may notice, we're using the same technique as when learning arrays - adding strings together to form HTML. Now that data should generate HTML that looks like something like this:

``` html
<ul>
  <li>Capital Area IT Council Networking Event</li>
  <li>Building a Bridge between AWS and Azure</li>
  <li>Lean Lunch</li>
  <li>R discussion and help</li>
  <li>Capital Area PMI Chapter Monthly Lunch and Learn</li>
  <li>Something Involving Rails</li>
  <li>GLASS March Meetup: Common SQL Server Mistakes and How to Avoid Them</li>
  <li>Monthly Meetup</li>
  <li>Webpack (and other bundlers) with Miguel Castillo</li>
  <li>Project-Based Innovation and the Fledge with Jerry Norris</li>
</ul>
```

_Much_ more readable. Now let's add some links so people can find more information about these events. Going back to the prettified data, it looks like links are available under this kind of data structure:

``` json
{
 "data": [
   {
     "links": {
       "self": "http://www.meetup.com/GLUGnet/events/229005039/"
     }
   }
 ]
}
```

Now we just have to form slightly more complicated HTMl:

``` js
$.ajax('http://api.lansing.codes/v1/events/upcoming/list')
  .done(function(response) {
    $('#tech-events').html(
      '<ul>' +
        response.data.map(function(event) {
          return (
            '<li>' +
              '<a href="' + event.links.self + '">' +
                event.attributes.name +
              '</a>' +
            '</li>'
          )
        }).join('') +
      '</ul>'
    )
  })
```

To generate this:

``` html
<ul>
  <li>
    <a href="http://www.meetup.com/GLUGnet/events/229005039/">
      Capital Area IT Council Networking Event
    </a>
  </li>
  <li>
    <a href="http://www.meetup.com/Lansing-DevOps-Meetup/events/228964468/">
      Building a Bridge between AWS and Azure
    </a>
  </li>
  <li>
    <a href="http://www.meetup.com/Mid-Michigan-Agile-Group/events/224510987/">
      Lean Lunch
    </a>
  </li>
  <li>
    <a href="http://www.meetup.com/Lansing-Area-R-Users-Group/events/229153388/">
      R discussion and help
    </a>
  </li>
  <li>
    <a href="http://www.meetup.com/PMI-Capital-Area-Chapter-Lunch-and-Learn/events/225586668/">
      Capital Area PMI Chapter Monthly Lunch and Learn
    </a>
  </li>
  <li>
    <a href="http://www.meetup.com/Lansing-Ruby-Meetup-Group/events/228759282/">
      Something Involving Rails
    </a>
  </li>
  <li>
    <a href="http://www.meetup.com/GLASS-Greater-Lansing-Area-for-SQL-Server/events/228876633/">
      GLASS March Meetup: Common SQL Server Mistakes and How to Avoid Them
    </a>
  </li>
  <li>
    <a href="http://www.meetup.com/lansingweb/events/228742559/">
      Monthly Meetup
    </a>
  </li>
  <li>
    <a href="http://www.meetup.com/Lansing-Javascript-Meetup/events/227924593/">
      Webpack (and other bundlers) with Miguel Castillo
    </a>
  </li>
  <li>
    <a href="http://www.meetup.com/MoMoLansing/events/229053738/">
      Project-Based Innovation and the Fledge with Jerry Norris
    </a>
  </li>
</ul>
```

And we're done! The data loads in and is transformed into very lovely HTML by just over a dozen lines of code.
