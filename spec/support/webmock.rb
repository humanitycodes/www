require 'webmock/rspec'
WebMock.disable_net_connect!(
  allow: [
    /google.com/, # example valid domain
    /oih1235oieh1235oihe12io3e5hoi1.com/ # example domain that will never exist
  ]
)
