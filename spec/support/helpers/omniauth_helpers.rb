module OmniauthHelpers

  module SessionHelpers

    def signin
      visit root_path
      click_link 'Sign in'
    end

    def signout
      visit root_path
      click_link 'Sign out' if page.has_link? 'Sign out'
    end

  end

end
