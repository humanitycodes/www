OmniAuth.config.test_mode = true

OmniAuth.config.add_mock :github, OmniAuth::AuthHash.new({
  provider: 'github',
  uid: '123545',
  info: {
    name: 'Mock User',
    email: 'mockuser@example.com',
    nickname: 'mockuser',
    image: 'http://example.com/path/to/my/image.jpg',
    urls: {
      'GitHub' => 'http://github.com/mockuser'
    }
  },
  credentials: {
    token: ''
  }
})
