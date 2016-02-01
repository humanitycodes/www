class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :customer_identity, index: true, foreign_key: true
      t.string :stripe_id, null: false, index: true
      t.json :stripe_object, null: false

      t.timestamps null: false
    end
  end
end
