feature 'New subscription page', :omniauth do

  context 'when signed in' do
    before(:each) { signin }

    context 'when the user is NOT an MSU student' do

      context 'when visiting the new subscription page' do
        before(:each) do
          VCR.use_cassette("new_subscription_page_non_msu_student", record: :new_episodes) do
            visit '/subscription/new'
          end
        end

        it 'displays a price of $99' do
          expect(page).to have_css('script[data-amount="9900"]', visible: false)
        end

        it 'blah', js: true do
          click 'button.stripe-button-el'
        end
      end
    end

    context 'when the user IS an MSU student' do
      before(:each) do
        MSU_STUDENTS << 'mockuser'
      end

      after(:each) do
        MSU_STUDENTS.pop
      end

      context 'when visiting the new subscription page' do
        before(:each) do
          VCR.use_cassette("new_subscription_page_msu_student", record: :new_episodes) do
            visit '/subscription/new'
          end
        end

        it 'displays a price of $49' do
          expect(page).to have_css('script[data-amount="4900"]', visible: false)
        end
      end
    end
  end
end
