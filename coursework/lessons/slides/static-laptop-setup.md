## What we'll be doing

I'm going to say it upfront. This is the most boring project you'll work on at the Code Lab. And maybe also the longest. We're going to do a lot of setup to get your computer ready for the work we'll be doing.

By the end though, you _will_ have a website on the Internet, using tools that professional web developers actually use every day. So please be patient and don't hesitate to ask for help when you need it.

1. Install the Atom code editor
2. Create our first HTML file
3. Look at our website in the browser (then make some changes and refresh)
4. Put our website on the Internet!
5. Share our website on GitHub
6. Get some feedback from a Code Lab mentor

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

## Create your first HTML file

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

The terminal is useful for a lot of development work. It'll take a little while to set up the first time, but then after that, you'll be set until you get a new computer! The recommended terminal program for your system is listed below:

- Mac OS X: Terminal (already installed!)
- Ubuntu: Terminal (already installed!)
- Windows: [Git Bash](https://git-scm.com/download/win) (must be downloaded and installed)

---

## Terminal commands are magic words

If you've been using computers long enough to remember DOS, that's a terminal. It's usually a black window where you can type in words to do things.

And just like magic words in Harry Potter, they often look like nonsense to the uninitiated. But if you know this nonsense and you say it at the right time, you _can_ make magic happen.

First, a few good __vocab words__ for working in the terminal:

- you can think of "terminal", "command line", "console", and "bash" as all the same thing
- "print" usually means "show in the terminal" rather than printing to a printer
- "directory" means "folder"
- "working directory" means "current folder"

And now, __your first magic words__:

``` bash
pwd # Print Working Directory - print the current directory (i.e. folder)
ls # List - print a list of files and folders in the current directory
```

Both of those commands you can use without any "parameters" (aka "arguments"), which just means you won't type anything after them for the command to work. I can just type in `pwd`, press enter, and get something like `/Users/fritzc/` printed back at me. That means I'm in the `fritzc` directory, which is inside of the `Users` directory.

Other commands, like `cd`, _do_ require parameters. Check out the examples below.

``` bash
# Change Directory - change the working directory
cd some-folder # change to "some-folder", which is a sub-folder of the current directory
cd .. # change to the parent directory (i.e. the folder that the current folder is in)
```

Now remember when I suggested leaving spaces out of folder and file names? Here's why:

``` bash
cd some-folder # works great!
cd some folder # returns an error, as it looks for a folder called "some" with "folder" passed as an additional parameter
cd some\ folder # works great, but we have to remember to put that backslash in front of every space
```

If you think you're ready to try these commands out, open your terminal program and do so now! If you're feeling kind of confused, flag down a mentor and they'll be happy to help. :-)

---

## Beef up our terminal with Node and NPM

Node and NPM (the Node Package Manager) will allow us to add special commands to our terminal, including a command to put our website on the Internet for free!

To install these, follow the instructions for your operating system:

- [Mac OS X](http://blog.teamtreehouse.com/install-node-js-npm-mac)
- [Ubuntu](http://blog.teamtreehouse.com/install-node-js-npm-linux)
- [Windows](http://blog.teamtreehouse.com/install-node-js-npm-windows)

---

## Getting online, for free, with Surge

Now let's open a terminal and use our newfound `cd` skills to change into the directory of the website you just built. As always, if you need help, just flag down a mentor. Once there, you can :

``` bash
npm install --global surge # Install the "surge" command into your terminal
cd /path/to/your-project-directory # Change into your project directory
surge # Run the surge command to put your website online!
```

---

## Sharing our code

So we have some code and it looks pretty good to us. Now what would a pro do? Share it and get feedback! So that's what _we're_ going to do. In fact, that's what we'll do for every Code Lab project. For our first time, this also requires a little setup.

1. Create an account on [GitHub](https://github.com/). This is where many, if not most developers, choose to share their code.
2. Install Git (which we'll use to get our code on GitHub):
  - __Mac OS X__: `brew install git` on the terminal
  - __Ubuntu__: `sudo apt-get install git` on the terminal
  - __Windows__: you already have it installed, as it's part of the Git Bash terminal
3. Follow instructions below in the "Next Steps" section. Since we already have a project folder this first time though, instead of using the `git clone the-clone-url` command, we'll `cd` into our current directory and type `git remote add origin the-clone-url`. Then follow the rest of the instructions.

---

## You're done!

Whew, that was a long one. Don't worry, future lessons won't be so involved. Because of our hard work on this lesson though, we're now set up to build websites _extremely quickly_, put them online, for free, in _seconds_, and very easily get feedback on our code. And all using the tools and processes of __real developers__. Great work!
