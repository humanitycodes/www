## Tweaking your app

Launch your app once again with `rails server` and try to add, edit, and delete recyclers at `localhost:3000/recyclers`. It should be working pretty well, except for 2 glaring problems:

1. If a visitor went to the homepage, they wouldn't have any way of knowing that we even _have_ a page listing recyclers. We need to link to it in our navigation menu.
2. Right now, it's possible to enter a recycler with a blank name, a phone number just containing "blah", or a website that doesn't exist. That's yucky.

### Adding form validations

Form validations prevent records from being saved in a state that we don't like. They can even display nice error messages to users, so that they know exactly what they need to fix before their form can be submitted. __Validations go in our model file, so in this case: `models/recycler.rb`.__

#### Making sure `name` and `address` aren't blank

Some validations are simple. If we just want to make sure a `name` and `address` are always entered, we can validate that they are present with:

``` ruby
validates_presence_of :name, :address
```

#### Making sure the phone number is in the format 123-456-7890

Other times, [a little bit of regex](http://rubular.com/r/55dmch9dlC) can be useful. If you've never used regex (i.e. regular expressions) before, they allow you to match text to a pattern. In this case, we're looking for 3 digits, then 3 more digits, then 4 digits, each group separated by a hyphen.

``` ruby
validates_format_of :phone, with: /\A\d{3}-\d{3}-\d{4}\z/, message: "isn't a correctly formatted phone number: e.g. 123-456-7890", allow_blank: true
```

We're also specifying a message to show the user if the validation fails and allowing the user to submit the form with a blank phone number, if they don't have one for that recycler.

#### Making sure the website is a valid web address (1)

Sometimes we have to write custom validation methods that do a little bit more work, like checking that the string actually contains a valid web address (with some much more complicated regex), then actually visiting the website and checking the response code for either `HTTPSuccess` (200 range) or `HTTPRedirection` (300 range).

If this seems intimidating, don't worry. So many people use Rails that most of the time, if you want to do a more complicated validation, you'll be able to google something like "rails validate that website is valid" and you'll find plenty of decent solutions.

Check the next slide for the solution I typically use for this problem, which I personally feel is better than anything I've seen online so far.

#### Making sure the website is a valid web address (2)

``` ruby
before_validation :format_website
validate :valid_website

def format_website
  self.website = "http://#{website}" unless website.blank? || website[/^https?/]
end

def valid_website
  return if website.blank?
  if /(\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\z)/ix =~ website
    begin # check header response
      response = Net::HTTP.get_response URI.parse(website)
      return if response.kind_of?(Net::HTTPSuccess) || response.kind_of?(Net::HTTPRedirection)
      message = "doesn't appear to be a page on #{response.uri.host} (#{response.code}: #{response.msg})"
    rescue # Recover on DNS failures
      message = "doesn't seem to exist on the web"
    end
  end
  message ||= "isn't a valid web address"
  errors.add(:website, message)
end
```
