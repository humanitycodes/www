## What we'll be doing

1. Install the Atom code editor
2. Create our first HTML file
3. Look at our website in the browser (then make some changes and refresh)
4. Put our website on the Internet! (npm & surge, introduce the word "deploy")

---

## Why a special program for writing code?

Great question! The short answer is it makes code easier to read and write. For example, editors will often use special colors to make certain parts of the code stand out. Compare this monochrome version:

```
<p>This is a <strong>paragraph tag</strong> in HTML.</title>
```

to this colorized version:

``` html
<p>This is a <strong>paragraph tag</strong> in HTML.</title>
```

---

## Install the Atom code editor

It's not glamorous, but carefully reading instructions is a huge part of what coders do. Check out [these instructions](https://atom.io/docs/latest/getting-started-installing-atom) to learn how to install the Atom text editor.

---

Create a new folder somewhere on your computer, maybe called `my-first-website`. Why use dashes instead of spaces for the name? The short answer is when we're working on the terminal, spaces often make a little extra work. We'll learn why later in this lesson.

Now let's:

1. Open Atom
2. Click on `File` > `Add Project Folder` and open the folder you just created.  
4. Click on `File` > `New File` and create a file called `index.html`. (Hint: if you're on Windows, make sure to also [show extensions for known file types](http://windows.microsoft.com/en-us/windows/show-hide-file-name-extensions#show-hide-file-name-extensions=windows-7))

Now paste this into that file:

``` html
<!doctype html>
<html>
  <head>
    <title>This is the title of the webpage!</title>
  </head>
  <body>
    <p>This is an example paragraph. Anything in the <strong>body</strong> tag will appear on the page, just like this <strong>p</strong> tag and its contents.</p>
  </body>
</html>
```

---

## You made a website!

Congratulations! That's a website. It's not online yet, but we'll get to that. First, let's make sure it's saved (`File` > `Save`). Now find it in your file manager (e.g. Windows Explorer or Finder) and if you double click, it should open up in your preferred web browser.

Do you see it?! If you don't, let someone know and we'll help you.

If you do, try making a change to that file in Atom. Then save it again and refresh the page in your browser. If you see the change, it's working and you're doing web development!

---

## Installing a terminal program

Now we actually want to get our website online - for free. It'll take a little while to set up the first time, but then after that, updating a current website or publishing a new one will take literally _seconds_.

### Using the terminal

- Terminal on Ubuntu
- Terminal on Mac
- Git Bash (https://git-scm.com/download/win)

---

## Terminal commands are basically magic words

If you've been using computers long enough to remember DOS, that's a terminal. It's usually a black window where you can type in words to do things.

And just like magic words in Harry Potter, they often look like nonsense to the uninitiated. But if you know this nonsense and you say it at the right time, you _can_ make magic happen.

First, a few good __vocab words__ for working in the terminal:

- you can think of "terminal", "command line", "console", and "bash" as all the same thing
- "print" usually means "show in the terminal" rather than printing to a printer
- "directory" means "folder"
- "working directory" means "current folder"

And now, __you're first magic words__:

``` bash
pwd # Print Working Directory - print the current directory (i.e. folder)
ls  # List - print a list of files and folders in the current directory
```

Both of those commands you can use without any "parameters" (aka "arguments"), which just means you won't type anything after them for the command to work. I can just type in `pwd`, press enter, and get something like `/Users/fritzc/` printed back at me.

Other commands, like `cd`, _do_ require parameters. Check out the examples below.

``` bash
# Change Directory - change the working directory
cd some-folder # change to "some-folder", which is a sub-folder of the current directory
cd ..          # change to the parent directory (i.e. the folder that the current folder is in)
```

Now remember when I suggested leaving spaces out of folder and file names? Here's why:

``` bash
cd some-folder  # works great!
cd some folder  # returns an error, as it looks for a folder called "some" with "folder" passed as an additional parameter
cd some\ folder # works great, but we have to remember to put that backslash in front of every space
```

If you think you're ready to try these commands out, open your terminal program and do so now! If you're feeling kind of confused, flag down a mentor and they'll be happy to help. :-)

---

## Surge

- install node and npm https://nodejs.org/en/download/

``` bash
mkdir my-first-website   # MAKE a DIRECTORY (i.e. folder) called "my-first-website"
cd my-first-website      # CHANGE the current DIRECTORY to "my-first-website"
npm init                 # INITIALIZE (i.e. set up) a new project
npm install --save surge #
```
