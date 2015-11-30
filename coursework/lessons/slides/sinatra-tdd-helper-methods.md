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

They explain _exactly_ what's going wrong in your app. Isn't that wonderful?

Then as you fill out the method and all your tests are passing, you eventually get something like this:

```
Finished in 0.00026 seconds (files took 0.68264 seconds to load)
3 examples, 0 failures
```

---

## Why write tests?

Many people will tell you that testing is just pure joy. That it feels _so good_ to see your tests go from red to green and have complete confidence that your app is working exactly as expected. And if you test everything, bugs have no place to hide. It's impossible to push out broken code!

I'll be honest with you though. That's a lie. The process _can_ bring a certain satisfaction, but the truth is: writing tests are a huge pain. On a fully tested app, _most_ of your app is usually test code. That means you're spending most of your time writing tests, rather than building out features, making prototyping much slower. And whenever you want to change a feature, you have to first rewrite the tests for that feature.

It's a slog. But people keep writing tests, not out of love, but out of fear. The pain of testing is nothing compared to the crippling fear and anxiety that comes with pushing out code that you're _pretty sure_ works. No one wants to lie awake at night, wondering if they'll get a call from their boss or a client, because one tiny but crucial feature is completely and utterly broken. Maybe it even does some math wrong and charges customers 100 times what it's supposed to. Stuff like that can happen.

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
# `require_relative` finds a file relative to the location of the current file. Inside the string it takes, you'll use the same kind of syntax you've been using in the terminal for commands like `cd`. Notice we don't have to include the `.rb`, because Ruby already knows we'll only be requiring other Ruby files from a Ruby file.
require_relative 'helpers/string_helpers'

class MyWebapp < Sinatra::Base

  get '/' do
    # ...
  end

  get '/about' do
    # ...
  end

  # As you can see, the `helpers` method can take not only a `do ... end` block, but also a module!
  helpers StringHelpers
end
```

Pulling these helpers out into their own module also makes it _a lot_ easier to test them. RSpec specs are usually organized into a `spec` folder, which itself typically has a folder structure that mirrors the structure of your app. So for example, for a `pluralize` method in

```
helpers/string_helpers.rb
```

we'd put our spec in

```
spec/helpers/string_helpers/pluralize_spec.rb
```

It's also a convention that all spec files end in `_spec`. This mostly makes it easier to quickly find your specs via rapid file switching in text editors like Atom, but also makes it easier for gems like `guard` (which is used in the project for this lesson) to monitor all your spec files and automatically rerun them whenever they or another relevant file in your app changes.

On the next page, you'll learn to reference this module in your spec, so that you can test to see if the `pluralize` method really works.

---

## Using RSpec to write specs

RSpec offers a "Domain Specific Language" (DSL) for writing specs. Now we'll learn that language by diving into a more thorough spec for the `pluralization` method.

We thought our previous spec worked pretty well, but our frontend developers are reporting lots of bugs. In fact, they gave us a whole list of examples where words were pluralized wrong - turns out just adding an `s` to every word doesn't work very well in English. Stupid language.

They also want to be able to pluralize negative numbers, but a fight has broken out over whether -1 should be singular or plural. It was briefly considered whether your company should pivot to focus on a customer base that speaks a language with fewer pluralization rules, but before your boss can go too far down that train of thought, you step in.

To resolve the conflict, you've done [your own research on the subject](http://english.stackexchange.com/questions/9735/is-1-singular-or-plural) and have decided that only the number 1 should be singular. As the only person who actually knows how to write the code, it turns out yours is the only opinion that matters.

So let's write the spec. We'll be explaining various parts of it throughout the following pages. Before we do that though, try skimming it now to see how much of it you already understand.

``` ruby
require_relative '../../../helpers/string_helpers'

PLURALIZATION_EXAMPLES = [
  {
    singular: 'cat',
    plural: 'cats'
  }, {
    singular: 'kiss',
    plural: 'kisses'
  }, {
    singular: 'dish',
    plural: 'dishes'
  }, {
    singular: 'witch',
    plural: 'witches'
  }, {
    singular: 'sky',
    plural: 'skies'
  }, {
    singular: 'knife',
    plural: 'knives'
  }, {
    singular: 'cactus',
    plural: 'cacti'
  }
]

NUMBERS_TO_TEST = [-2, -1, 0, 1, 2]

describe StringHelpers do
  describe '#pluralize' do

    PLURALIZATION_EXAMPLES.each do |word|
      context "when the singular word is \"#{word[:singular]}\"" do
        NUMBERS_TO_TEST.each do |number|
          context "and the number is #{number}" do
            before(:each) do
              if number == 1
                @expected_pluralization = "#{number} #{word[:singular]}"
              else
                @expected_pluralization = "#{number} #{word[:plural]}"
              end
              @actual_pluralization = pluralize example[:singular], @number
            end

            it "returns \"#{@expected_pluralization}\"" do
              expect(@actual_pluralization).to eq(@expected_pluralization)
            end
          end
        end
      end
    end
  end
end
```

---

## `describe` / `context`

`describe` accepts a string or class. It is used to organize specs. `context` is an alias for `describe`, meaning they do exactly the same thing. People will use `describe` in some situations and `context` in others simply because it reads better. We essentially use them to build sentences, such as:

```
StringHelpers#pluralize when the singular word is "cat" and the number is 0 returns "0 cats"
```

Now let's focus in on the `describe` and `context` parts of the spec:

``` ruby
# ...

describe StringHelpers do
  describe '#pluralize' do

    PLURALIZATION_EXAMPLES.each do |word|
      context "when the singular word is #{word[:singular]}" do
        # ...

        NUMBERS_TO_TEST.each do |number|
          context "and the number is #{number}" do
            # ...
          end
        end
      end
    end
  end
end
```

We're describing the `StringHelpers` module - specifically the `pluralize` method. The `#` in front of it doesn't do anything special, but is convention for module methods.

I personally use `context` instead of `describe` for any parameters or other changing state I want to describe.

---

## `it`

`it` is what describes a specific test. It usually takes a string, which is used to form the end of the sentence in our spec.

In our example, we have a single it that we go through to check that under various contexts, the `pluralize` method returns what we'd expect it to.

``` ruby
it "returns \"#{@expected_pluralization}\"" do
  expect(@actual_pluralization).to eq(@expected_pluralization)
end
```

If our expectation isn't met, the test fails and RSpec let's us know what we got wrong.

---

## `expect().to`/`expect().not_to` and matchers

This is the syntax RSpec uses inside of `it`s to set up our expectations:

``` ruby
expect(what_we_actually_got).to eq(what_we_expected_to_get)
```

It kind of reads like English. The `eq` in this case is short for "equal". `eq` is not the only __matcher__ available in RSpec, but it is the most commonly used.

Take a look at [this cheat sheet](https://upcase.com/test-driven-rails-resources/matchers.pdf) for examples of other frequently used matchers. Don't worry about memorizing them though - you can refer back to this sheet when you're writing your own specs.

---

## `before(:each)`

`before(:each)` is very useful for setting up something you want to happen before all specs in a group.

In our case, we use a `before(:each)` block to set up the pluralization that we expect to get and then the actual pluralization generated by the `pluralize` method.

``` ruby
before(:each) do
  if number == 1
    @expected_pluralization = "#{number} #{word[:singular]}"
  else
    @expected_pluralization = "#{number} #{word[:plural]}"
  end
  @actual_pluralization = pluralize example[:singular], @number
end
```

Similarly to how we use instance variables (i.e. variables starting with `@`) to pass data from `app.rb` to the view files in Sinatra, we use instance variables to pass data from our `before(:each)` block to our `it` blocks in RSpec.

---

## Now let's do some test-driven development!

So those are the basics of RSpec. It may seem like a lot to take in at first, but don't worry, the project will be taking it very slow.

We'll be building off an existing project and before writing any specs, we'll first use the tools of test-driven development to fill out helper methods for which specs have already been written.

After that, you'll write at least one spec for an additional helper method and then fill out the method until everything passes.
