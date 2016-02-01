class Subscription < ActiveRecord::Base
  belongs_to :customer_identity

  validates_presence_of :stripe_id, :stripe_object
end
