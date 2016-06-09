## A little more setup

Before this, you developed websites with just HTML, CSS, and JS. Now, we're going to use Ruby to develop not just web_sites_, but more advanced web _applications_. Before we jump in though, there's a little more setup we have to do.

Once again, this'll be a little boring, but we only have to do it once!

---

## Hosting server-side applications with Heroku

[Heroku](https://id.heroku.com/signup) is a hosting platform that's free for up to 5 apps with no addons. To host more than 5 apps or include addons for things like database backup, performance monitoring, or sending emails, you have to fill in your credit card information - even though the cost in most cases would still be $0/month.

__We will not require you to host more than 5 apps, so giving your credit card information is optional.__ You may choose to do so if you wish to exceed the 5 app limit or add free addons to your apps. Please note that Heroku assumes you will read everything carefully, so if you decide to play around and add 1000 dynos to your app and 50 paid plugins, it _will_ get pricy.

---

## Installing Ruby

Once you've signed up for Heroku, it'll [give you instructions](https://devcenter.heroku.com/articles/getting-started-with-ruby#introduction) on how to set up your computer with Ruby. __Two important notes:__

- __You only have to follow the instructions up to and including _Set up_.__
- __If you're running Windows, Heroku will suggest installing JRuby instead of regular Ruby. Please ignore that suggestion and follow [the normal instructions for Windows](http://guides.railsgirls.com/install#setup-for-windows).__
