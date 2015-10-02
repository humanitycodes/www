## Serving a multipage website locally

So far, we've only created an `index.html` file, which shows up on the homepage of a website. As you've probably noticed however, most websites have many pages. So how do we make that happen?

Let's practice in your folder for the last project. Say we want an About page. Let's create a new file in the same project folder as `index.html` and call it `about.html`. Go ahead and put some valid HTML in that page.

Now our website just got a little more complex, so directly opening the HTML file in a web browser won't work very well. To make things simple again, make sure you're in your project directory in the terminal, then install `live-server` and run it with the code below:

``` bash
npm install --global live-server
live-server
```

Now visit `localhost:8080` in your web browser to see your website. Do you see your homepage? Then try visiting `localhost:8080/about.html` to make sure you see your About page.

---

## Getting rid of the `.html` in page names

You may have noticed that on most sites, you don't see a `.html` at the end of page names. Instead of going to `some-website.com/about.html`, the page will be `some-website.com/about`. To make on _your_ website:

1. Make a folder called `about` in your project folder.
2. Move `about.html` into the `about` folder.
3. Rename `about.html` to `index.html`.

Now try visiting `localhost:8080/about`. Do you see your About page?

---

## Managing "nested routes"

First, what's a __route__? A route is the definition of where some information on a website can be found. The route for the page we just created is `/about`.

Now for a business website, you might also want a `/staff` page, then another page for each member of your staff at `/staff/alice`, `/staff/bob`, etc. Can you guess how we'd make this possible? You'd need a directory structure like this:

```
my-project-folder
|-- index.html
|-- about
|   |-- index.html
|-- staff
|   |-- index.html
|   |-- alice
|   |   |-- index.html
|   |-- bob
|   |   |-- index.html
|   |-- carla
|   |   |-- index.html
```

We're using folders to define our routes and `index.html` files to define what should be displayed at each one. These routes are called __nested__ because the folders are inside one another, just like Russian Matryoshka dolls.

![Russian Matryoshka dolls](https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/Russian-Matroshka2.jpg/1024px-Russian-Matroshka2.jpg)

---

## Absolute vs relative links

When you're linking to _other_ websites, you'll use the full address of that website, like this:

``` html
<a href="http://www.google.com/about">Google's About Page</a>
```

On most websites, there's also some kind of navigation menu - a list of links to pages on that website. But when linking to one of your _own_ pages, you don't need to specify the domain. You can just do this:

``` html
<a href="/about">My About Page</a>
```

This way is actually better. Now when you visit that link on your computer, it'll take you to `localhost:8080/about`, and when you're visiting that site live, it'll still work, taking you to `whatever-the-domain-of-my-website-is.com/about`.

It's important to note that the `/` at the beginning is important. It makes your link __absolute__, meaning it starts at the root of your website (the homepage) and directs the web browser from there.

If you leave off the `/` at the beginning, the link becomes __relative__, meaning it's giving the web browser directions _relative to the current page_. Let's look at an example:

``` html
<a href="/staff/alice">Meet Alice</a>
```

No matter what page we're on, that absolute link will work. Now let's look at the relative version:

``` html
<a href="staff/alice">Meet Alice</a>
```

Subtle difference. When we're at `/` (our homepage), that link will work. When we're on the `/staff` page though, it'll send a visitor to `/staff/staff/alice` - a page that doesn't exist! When you're at `/staff/bob`, that link will send a visitor to `/staff/bob/staff/alice` - another non-existent page. Yuck.

So stick with absolute links. Then no matter what page you're on, your links will _always_ work!
