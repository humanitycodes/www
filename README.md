# www.lansingcodelab.com

[![Circle CI](https://circleci.com/gh/lansingcodelab/www.svg?style=svg)](https://circleci.com/gh/lansingcodelab/www) [![Dependency Status](https://gemnasium.com/lansingcodelab/www.svg)](https://gemnasium.com/lansingcodelab/www)

## Development

### Running

Assuming you have Ruby installed:

```  shell
bundle install
```

And assuming you have NPM installed:

``` shell
npm install
```

Make sure Postgres is running and create the database:

``` shell
bundle exec rake db:create db:migrate
```

The app uses an asynchronous fetcher API that runs as a separate node app. The easiest way to run both of these at the same time is with foreman. If you don't already have it installed, `gem install foreman` and then you can run both apps with:

``` shell
foreman start
```

If all went well, you should be able to open http://localhost:3000/ in a web browser and see the Code Lab homepage.

### Testing

The full test suite can be run with `bundle exec rspec`. If you'd like to keep a watcher selectively running tests in the background as you work, run `bundle exec guard`.

Once inside guard, tests will be rerun as relevant files are changed. You can also press `Enter` to rerun the entire suite. You can quit guard with `exit`.

### Contributing

Please develop features in feature branches and submit a pull request when it's ready to be merged in. If you ever want to collaborate on a feature or learn more about how something in the app works, please don't hesitate to let me know! Best way to reach me is on [the Lansing Codes Slack](https://lansingcodes.slack.com/messages/@chrisvfritz/).
