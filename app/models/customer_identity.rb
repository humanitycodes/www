class CustomerIdentity < ActiveRecord::Base
  belongs_to :user

  has_one :subscription, dependent: :destroy

  validates_presence_of :stripe_id, :stripe_object
end
