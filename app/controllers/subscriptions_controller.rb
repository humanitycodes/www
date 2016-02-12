class SubscriptionsController < ApplicationController
  protect_from_forgery except: :webhook

  load_and_authorize_resource except: :webhook

  def new
    plan_id = if MSU_STUDENTS.include? current_user.username
      'lcl-msu-student'
    else
      'lcl-founding-student'
    end
    @plan = Stripe::Plan.retrieve(plan_id)
  end

  def create
    plan = Stripe::Plan.retrieve(params[:plan_id])

    if current_user.customer_identity
      stripe_customer = Stripe::Customer.retrieve(
        current_user.customer_identity.stripe_id
      )
      stripe_customer.sources.create(source: params[:stripeToken])
      stripe_customer = Stripe::Customer.retrieve(
        current_user.customer_identity.stripe_id
      )
      current_user.customer_identity.update!(
        stripe_object: stripe_customer.as_json
      )
    else
      stripe_customer = Stripe::Customer.create(
        description: 'Lansing Code Lab Membership',
        source: params[:stripeToken],
        email: current_user.email
      )
      current_user.build_customer_identity(
        stripe_id: stripe_customer.id,
        stripe_object: stripe_customer.as_json
      ).save!
    end

    stripe_subscription = stripe_customer.subscriptions.create(plan: plan.id)

    current_user.customer_identity.build_subscription(
      stripe_id: stripe_subscription.id,
      stripe_object: stripe_subscription.as_json
    ).save!

    redirect_to edit_subscription_path, notice: "You're now subscribed."
  rescue Stripe::CardError => e
    redirect_to new_subscription_path, alert: "There was a problem processing your card: #{e.json_body[:error][:type]}"
  rescue Stripe::APIConnectionError => e
    redirect_to new_subscription_path, alert: "We're having trouble reaching Stripe to process your card. Please try again in a few minutes."
  end

  def edit
    @card = current_user.
      customer_identity.stripe_object['sources']['data'].
      find { |datum| datum['object'] == 'card' }
    @subscription = current_user.
      customer_identity.subscription.stripe_object
  end

  def update
    stripe_customer = Stripe::Customer.retrieve(
      current_user.customer_identity.stripe_id
    )

    stripe_customer.source = params[:stripeToken]
    stripe_customer.save

    redirect_to edit_subscription_path, notice: "Card updated."
  end

  def destroy
    subscription = current_user.customer_identity.subscription

    stripe_customer = Stripe::Customer.retrieve(
      current_user.customer_identity.stripe_id
    )

    current_user.customer_identity.stripe_object['sources']['data'].each do |card|
      stripe_customer.sources.retrieve( card['id'] ).delete
    end

    stripe_subscription = stripe_customer.subscriptions.retrieve(
      subscription.stripe_id
    ).delete

    subscription.destroy

    redirect_to new_subscription_path, notice: "Subscription cancelled."
  end

  # https://stripe.com/docs/webhooks
  def webhook
    begin
      event_json = JSON.parse(request.body.read)
      event_object = event_json['data']['object']
      # https://stripe.com/docs/api#event_types
      # https://www.masteringmodernpayments.com/stripe-webhook-event-cheatsheet
      case event_json['type']
        when 'customer.updated'
          customer = CustomerIdentity.find_by(stripe_id: event_object['id'])
          customer.stripe_object = event_object
          customer.save!
        when 'customer.subscription.updated'
          subscription = Subscription.find_by(stripe_id: event_object['id'])
          subscription.stripe_object = event_object
          subscription.save!
        when 'customer.subscription.deleted'
          Subscription.find_by(stripe_id: event_object['id']).destroy
      end
    rescue
      render json: { status: 422, error: 'Webhook call failed' }
      return
    end
    render json: { status: 200 }
  end

end
