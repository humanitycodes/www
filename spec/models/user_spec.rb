describe User do

  describe '.new' do

    context 'with valid data' do
      before(:each) { @user = create(:user) }

      it 'returns a valid user' do
        expect(@user).to be_valid
      end
    end
  end

  describe '#portfolio_url' do
    before(:each) { @user = create(:user) }

    it 'returns a link to a GitHub search' do
      expect(@user.portfolio_url).to match(%r{https://github.com/search})
    end

  end
end
