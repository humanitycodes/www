## What's a test?

In software development, we often write tests listing out everything we want our app to do. This way, we know definitively when we've completed a new feature _and_ in the future, we'll know if accidentally break it.

In Ruby, the most popular library for testing is RSpec, which allows you to write a special flavor of tests called "specs". Short for "specifications", they allow you to _specify_ the behavior of your app in a way that's very easy to read.

Let's take the `pluralize` method from a previous lesson, for example.

``` ruby
describe '#pluralize' do

  it 'returns "0 cats" when passed "cat" and 0' do
    pluralization = pluralize 'cat', 0
    expect(pluralization).to eq('0 cats')
  end

  it 'returns "1 cat" when passed a "cat" and 1' do
    pluralization = pluralize 'cat', 1
    expect(pluralization).to eq('1 cat')
  end

  it 'returns "2 cats" when passed a "cat" and 2' do
    pluralization = pluralize 'cat', 2
    expect(pluralization).to eq('2 cats')
  end

end
```

Before even learning how RSpec works, you can probably figure out the intention of this code. It reads kind of like English.

Now if we wrote these specs before writing the content of the `pluralize` method, we'd expect to get a bunch of failures, like this:

```
Failures:

  1) #pluralize returns "0 cats" when passed "cat" and 0
     Failure/Error: expect(pluralization).to be('0 cats')

       expected: "0 cats"
       got: nil

  2) #pluralize returns "1 cat" when passed "cat" and 1
     Failure/Error: expect(pluralization).to be('1 cat')

       expected: "1 cat"
       got: nil

  3) #pluralize returns "2 cats" when passed "cat" and 2
     Failure/Error: expect(pluralization).to be('2 cats')

       expected: "2 cats"
       got: nil
```

They explain _exactly_ what's going wrong in your app, so that you don't have to go through and manually test it to make sure it's working. These tests also run in just fractions of a second, so you find out immediately when something's broken.

As you fill out the method and all your tests are passing, you eventually get something like this:

```
Finished in 0.00026 seconds (files took 0.68264 seconds to load)
3 examples, 0 failures
```

`0 failures`. Always satisfying!

---

## Why write tests?

Many people will tell you that testing is just pure joy. That it feels _so good_ to see your tests go from red to green. They might suggest that through testing, you can have complete confidence that your app is working correctly. And if you test everything, bugs have no place to hide. It's impossible to push out broken code!

I'll be honest with you though. That's a lie. The process _can_ bring a certain satisfaction, but the truth is:

- Writing tests take a lot of time and often slow you down as you're prototyping.
- Not everything can be tested (or tested easily at least). For example, the `pluralize` method might be working correctly, but what if the font color is the same as the background color, so that your words are invisible?
- Just _having_ a lot of tests can slow you down. A test suite that takes 10 minutes to run, for example, adds at least 10 minutes to every commit.
- Some tests are finicky, so that even though you _know_ your app works, you have to spend an entire afternoon just figuring out why the tests are failing and working to make them more reliable.

It's a slog. But people keep writing tests, not out of love, but out of fear. The pain of testing is nothing compared to the crippling fear and anxiety that comes with pushing out code that you're _pretty sure_ works. No one wants to lie awake at night, wondering if they'll get a call from their boss or a client, because one tiny but crucial feature is completely and utterly broken. Tests can't _completely_ alleviate this, but they can help catch a huge category of bugs.

---

## Organizing our code to be testable

There's a word - a virtue really - that all programmers strive for: __modular__. This is modular:

![Modular Kitchen](http://i.imgur.com/Fp2DGQh.jpg)

You'll notice that this entire kitchen is made out of swappable parts. There are standard sizes and mountings that allow us to switch out various kinds of cabinets and appliances; we can swap out clear doors for opaque doors, white for purple; and even move shelves around to different heights. You probably have some furniture like this in your home.

The idea is __if we establish some standard rules for how everything fits together, we can organize each part however we like__. Fortunately, many programming languages, including Ruby, have already established some great rules we can work with.

Let's take a classic Sinatra webapp for example. So far, we've been listing all our routes, then starting a `helpers do ... end` block and listing all our helper methods inside of it, like this:

``` ruby
class MyWebapp < Sinatra::Base

  get '/' do
    # ...
  end

  get '/about' do
    # ...
  end

  helpers do

    def pluralize
      # ...
    end

    # ...
  end
end
```

The problem is that as your app grows, `app.rb` slowly becomes a _huge_ file with everything just thrown in as a giant list. It's like keeping your todo list, shopping list, and Christmas wishlist all on the same piece of paper. And you wouldn't do that, right? That's madness! They're completely different __concerns__.

That's another word you'll hear a lot in programming. People will talk about a "separation of concerns", which is the idea that you'll keep, for example, your helper methods separate from your route definitions, because they're _concerned_ with different parts of your app.

So let's separate these concerns to make our app more modular with Ruby's __modules__.

``` ruby
module StringHelpers
  def pluralize
    # ...
  end
end
```

I called this module `StringHelpers` to give us a place to keep methods that accept strings and give us modified versions of them. Maybe later we'll need another method to conjugate verbs based on the subject. In that case, we'll have a perfect place to put it.

I'd probably put the `current_date` method we worked on in the previous lesson in a `TimeHelpers` module, then any helpers that make it easier to include Bootstrap components in a `BootstrapComponentHelpers` module.

Each module will usually be in its own file, titled after the module itself. For example, the `StringHelpers` module would probably go in a `helpers/string_helpers.rb` file.

Then in `app.rb`, we'd reference that file with

``` ruby
# `require_relative` finds a file relative to the location of the current file.
# Inside the string it takes, you'll use the same kind of syntax you've been
# using in the terminal for commands like `cd`. Notice we don't have to include
# the `.rb`, because Ruby already knows we'll only be requiring other Ruby files
# from a Ruby file.
require_relative 'helpers/string_helpers'

class MyWebapp < Sinatra::Base

  get '/' do
    # ...
  end

  get '/about' do
    # ...
  end

  # As you can see, the `helpers` method can take not only a `do ... end` block,
  # but also a module!
  helpers StringHelpers
end
```

Pulling these helpers out into their own module also makes it _a lot_ easier to test them. We'll save the details for a subsequent lesson though.

For now, we have [a Sinatra app](https://github.com/chrisvfritz/codelab-sinatra-tdd-helper-methods) that's already set up with some tests, that we'll be building off. The specs are already written, so we just have to follow the process laid out in [the README](https://github.com/chrisvfritz/codelab-sinatra-tdd-helper-methods/blob/master/README.md) to run them and update our helper methods until they all pass.
