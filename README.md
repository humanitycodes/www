# www.lansingcodelab.com

[![Circle CI](https://circleci.com/gh/lansingcodelab/www.svg?style=svg)](https://circleci.com/gh/lansingcodelab/www)

## Development

### Running

Assuming you have Ruby installed:

```  shell
bundle install
```

The app uses an asynchronous fetcher API that runs as a separate node app. The easiest way to run both of these at the same time is with foreman. If you don't already have it installed, `gem install foreman` and then you can run both apps with:

``` shell
foreman start
```

### Testing

The full test suite can be run with `bundle exec rspec`. If you'd like to keep a watcher selectively running tests in the background as you work, run `bundle exec guard`.

Once inside guard, tests will be rerun as relevant files are changed. You can also press `Enter` to rerun the entire suite. You can quit guard with `exit`.

### Contributing

Please develop features in feature branches and submit a pull request when it's ready to be merged in. If you ever want to collaborate on a feature or learn more about how something in the app works, please don't hesitate to let me know! Best way to reach me is on [the Lansing Codes Slack](https://lansingcodes.slack.com/messages/@chrisvfritz/).
