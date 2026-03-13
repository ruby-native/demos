class CreateSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status, null: false, default: "active"
      t.string :store_product_id
      t.string :subscription_id
      t.timestamps
    end
  end
end
