class CreateStamps < ActiveRecord::Migration[8.1]
  def change
    create_table :stamps do |t|
      t.references :user, null: false, foreign_key: true
      t.references :brewery, null: false, foreign_key: true
      t.datetime :stamped_at, null: false

      t.timestamps
    end

    add_index :stamps, [ :user_id, :brewery_id ], unique: true
  end
end
