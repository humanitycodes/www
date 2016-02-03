feature 'Edit subscription page', :omniauth do

  context 'when signed in' do
    before(:each) { signin }

    context 'when NOT a subscribed user' do
      context 'when visiting the edit subscription page' do
        before(:each) { visit '/subscription/edit' }

        it 'redirects to lessons and displays unauthorized message' do
          expect(current_path).to eq('/lessons')
          expect(page).to have_content('You are not authorized to access this page.')
        end
      end
    end

    context 'when the user is currently subscribed' do
      before(:each) do
        @user = User.first
        @user.customer_identity = CustomerIdentity.create(
          stripe_id: "cus_7okrKKvyIFSH3V", stripe_object: {"id"=>"cus_7okrKKvyIFSH3V", "object"=>"customer", "account_balance"=>0, "created"=>1454193483, "currency"=>"usd", "default_source"=>"card_17ZBQTAsEAtVETbyjC29YDGV", "delinquent"=>false, "description"=>"Lansing Code Lab Membership", "discount"=>nil, "email"=>"chrisvfritz@gmail.com", "livemode"=>false, "metadata"=>{}, "shipping"=>nil, "sources"=>{"object"=>"list", "data"=>[{"id"=>"card_17ZBQTAsEAtVETbyjC29YDGV", "object"=>"card", "address_city"=>nil, "address_country"=>nil, "address_line1"=>nil, "address_line1_check"=>nil, "address_line2"=>nil, "address_state"=>nil, "address_zip"=>nil, "address_zip_check"=>nil, "brand"=>"Visa", "country"=>"US", "customer"=>"cus_7okrKKvyIFSH3V", "cvc_check"=>"pass", "dynamic_last4"=>nil, "exp_month"=>2, "exp_year"=>2033, "fingerprint"=>"Bnf0yyr76TUobWvj", "funding"=>"credit", "last4"=>"1881", "metadata"=>{}, "name"=>"chrisvfritz@gmail.com", "tokenization_method"=>nil}], "has_more"=>false, "total_count"=>1, "url"=>"/v1/customers/cus_7okrKKvyIFSH3V/sources"}, "subscriptions"=>{"object"=>"list", "data"=>[{"id"=>"sub_7op1Sron7OKjcp", "object"=>"subscription", "application_fee_percent"=>nil, "cancel_at_period_end"=>false, "canceled_at"=>nil, "current_period_end"=>1456714536, "current_period_start"=>1454208936, "customer"=>"cus_7okrKKvyIFSH3V", "discount"=>nil, "ended_at"=>nil, "metadata"=>{}, "plan"=>{"id"=>"lcl-founding-student", "object"=>"plan", "amount"=>9900, "created"=>1454198932, "currency"=>"usd", "interval"=>"month", "interval_count"=>1, "livemode"=>false, "metadata"=>{}, "name"=>"Lansing Code Lab (Founding Student)", "statement_descriptor"=>nil, "trial_period_days"=>nil}, "quantity"=>1, "start"=>1454208936, "status"=>"active", "tax_percent"=>nil, "trial_end"=>nil, "trial_start"=>nil}, {"id"=>"sub_7omgbGAlF8dWR4", "object"=>"subscription", "application_fee_percent"=>nil, "cancel_at_period_end"=>false, "canceled_at"=>nil, "current_period_end"=>1456705847, "current_period_start"=>1454200247, "customer"=>"cus_7okrKKvyIFSH3V", "discount"=>nil, "ended_at"=>nil, "metadata"=>{}, "plan"=>{"id"=>"lcl-founding-student", "object"=>"plan", "amount"=>9900, "created"=>1454198932, "currency"=>"usd", "interval"=>"month", "interval_count"=>1, "livemode"=>false, "metadata"=>{}, "name"=>"Lansing Code Lab (Founding Student)", "statement_descriptor"=>nil, "trial_period_days"=>nil}, "quantity"=>1, "start"=>1454200247, "status"=>"active", "tax_percent"=>nil, "trial_end"=>nil, "trial_start"=>nil}, {"id"=>"sub_7ol6nEcDTUxh1Q", "object"=>"subscription", "application_fee_percent"=>nil, "cancel_at_period_end"=>false, "canceled_at"=>nil, "current_period_end"=>1455403982, "current_period_start"=>1454194382, "customer"=>"cus_7okrKKvyIFSH3V", "discount"=>nil, "ended_at"=>nil, "metadata"=>{}, "plan"=>{"id"=>"lcl-basic", "object"=>"plan", "amount"=>9900, "created"=>1446832186, "currency"=>"usd", "interval"=>"month", "interval_count"=>1, "livemode"=>false, "metadata"=>{}, "name"=>"Lansing Code Lab - Basic", "statement_descriptor"=>"Lansing Code Lab", "trial_period_days"=>14}, "quantity"=>1, "start"=>1454194382, "status"=>"trialing", "tax_percent"=>nil, "trial_end"=>1455403982, "trial_start"=>1454194382}, {"id"=>"sub_7okuzzdF42Sa98", "object"=>"subscription", "application_fee_percent"=>nil, "cancel_at_period_end"=>false, "canceled_at"=>nil, "current_period_end"=>1455403238, "current_period_start"=>1454193638, "customer"=>"cus_7okrKKvyIFSH3V", "discount"=>nil, "ended_at"=>nil, "metadata"=>{}, "plan"=>{"id"=>"lcl-basic", "object"=>"plan", "amount"=>9900, "created"=>1446832186, "currency"=>"usd", "interval"=>"month", "interval_count"=>1, "livemode"=>false, "metadata"=>{}, "name"=>"Lansing Code Lab - Basic", "statement_descriptor"=>"Lansing Code Lab", "trial_period_days"=>14}, "quantity"=>1, "start"=>1454193638, "status"=>"trialing", "tax_percent"=>nil, "trial_end"=>1455403238, "trial_start"=>1454193638}, {"id"=>"sub_7okrlBDt190uFR", "object"=>"subscription", "application_fee_percent"=>nil, "cancel_at_period_end"=>false, "canceled_at"=>nil, "current_period_end"=>1455403084, "current_period_start"=>1454193484, "customer"=>"cus_7okrKKvyIFSH3V", "discount"=>nil, "ended_at"=>nil, "metadata"=>{}, "plan"=>{"id"=>"lcl-basic", "object"=>"plan", "amount"=>9900, "created"=>1446832186, "currency"=>"usd", "interval"=>"month", "interval_count"=>1, "livemode"=>false, "metadata"=>{}, "name"=>"Lansing Code Lab - Basic", "statement_descriptor"=>"Lansing Code Lab", "trial_period_days"=>14}, "quantity"=>1, "start"=>1454193484, "status"=>"trialing", "tax_percent"=>nil, "trial_end"=>1455403084, "trial_start"=>1454193484}], "has_more"=>false, "total_count"=>5, "url"=>"/v1/customers/cus_7okrKKvyIFSH3V/subscriptions"}}
        )
        @user.customer_identity.subscription = Subscription.create(
          stripe_id: "sub_7poOvdDgIVI3Jq", stripe_object: {"id"=>"sub_7poOvdDgIVI3Jq", "object"=>"subscription", "application_fee_percent"=>nil, "cancel_at_period_end"=>false, "canceled_at"=>nil, "current_period_end"=>1456942856, "current_period_start"=>1454437256, "customer"=>"cus_7okrKKvyIFSH3V", "discount"=>nil, "ended_at"=>nil, "metadata"=>{}, "plan"=>{"id"=>"lcl-founding-student", "object"=>"plan", "amount"=>9900, "created"=>1454198932, "currency"=>"usd", "interval"=>"month", "interval_count"=>1, "livemode"=>false, "metadata"=>{}, "name"=>"Lansing Code Lab (Founding Student)", "statement_descriptor"=>nil, "trial_period_days"=>nil}, "quantity"=>1, "start"=>1454437256, "status"=>"active", "tax_percent"=>nil, "trial_end"=>nil, "trial_start"=>nil}
        )
        @user.save
      end

      after(:each) do
        @user.customer_identity.subscription.destroy
      end

      context 'when visiting the edit subscription page' do
        before(:each) do
          visit '/subscription/edit'
        end

        it 'last four numbers of credit card are displayed' do
          expect(page).to have_content('XXXX XXXX XXXX 1881')
        end
      end
    end
  end
end
