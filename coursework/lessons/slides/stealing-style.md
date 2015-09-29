## Steal better code

There's an old adage in programming:

> Good programmers write good code.<br>Great programmers steal better code.

As an aside, it should be noted that any stolen code should still comply with the license on that code, which may require attribution or limit your use of it. But as far as design goes, you can steal colors and styles as much as you want.

So here's how you can steal some better design.

---

## Hex codes and color pickers

So far, we've used English-language names of colors, like `lightblue` and `orange`, but sometimes you want a very _specific_ color. That's where __hex codes__ come in. A hex code starts with a `#` and then has six characters after that, each one ranging from 0-9 or A-F. All you need to know for now is that it's a special code that stands for a color.

And a __color picker__ can you get the hex code for any of 16,777,216 colors. [Here's a free color picker at colorpicker.com](http://www.colorpicker.com/).

That'll allow us to find really nice colors, such as #f9f7f5, which is a very nice brownish gray I like to use sometimes for backgrounds, like this:

``` css
body {
  background-color: #f9f7f5;
}
```

You can also find out the hex code of any color on your screen, with color pickers you can install. If you'd like, you can install a color picker for your operating system now:

- [Mac OS X](https://itunes.apple.com/us/app/sip/id507257563)
- [Ubuntu Linux](http://stackoverflow.com/questions/9003632/color-picker-utility-color-pipette-in-ubuntu)
- [Windows](http://www.instantfundas.com/2010/02/5-best-screen-color-pickers-for-windows.html)

---

## Free color schemes

[ColourLovers](http://www.colourlovers.com/web/palettes) is a great resource for finding free color schemes (i.e. collections of colors that don't look terrible together).

---

## Page inspection

What's nice about the web is if you see something you like, you can always take a closer look. If you're browsing around and you see a design strikes your fancy, you can right-click on the page and [click _Inspect Element_](https://developer.chrome.com/devtools) to see the CSS behind that marvelous design.

Then you can use those same styles in your own documents!
