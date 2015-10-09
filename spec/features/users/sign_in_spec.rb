feature 'Sign in', :omniauth do

  before(:each) do
    signout
  end

  context 'with a valid GitHub account' do

    it 'succeeds' do
      signin
      expect(page).to have_link('Sign out')
    end

  end

  context 'with an invalid GitHub account' do

    before(:each) do
      @old_mock = OmniAuth.config.mock_auth[:github]
      OmniAuth.config.mock_auth[:github] = :invalid_credentials
    end

    after(:each) do
      OmniAuth.config.mock_auth[:github] = @old_mock
    end

    it 'fails' do
      signin
      expect(page).to have_content('Authentication error')
    end

  end
end
