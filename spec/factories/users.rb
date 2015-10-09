FactoryGirl.define do

  factory :user do
    provider 'github'
    uid '123545'
    name 'Mock User'
    username 'mockuser'
    email 'mockuser@example.com'
    image_url 'http://example.com/path/to/my/image.jpg'
    github_url 'http://github.com/mockuser'
  end

end
