## arst

RSpec specs are usually organized into a `spec` folder, which itself typically has a folder structure that mirrors the structure of your app. So for example, for a `pluralize` method in

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

I personally use `context` instead of `describe` for any parameters or other situations I want to describe.

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
