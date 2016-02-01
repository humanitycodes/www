class CreateCustomerIdentities < ActiveRecord::Migration
  def change
    create_table :customer_identities do |t|
      t.references :user, index: true, foreign_key: true
      t.string :stripe_id, null: false, index: true
      t.json :stripe_object, null: false

      t.timestamps null: false
    end
  end
end
