class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true, index: {unique: true}
      t.string :product_id
      t.string :original_transaction_id, index: true
      t.string :status, null: false, default: "active"
      t.datetime :expires_at

      t.timestamps
    end
  end
end
