class CreateHabits < ActiveRecord::Migration[8.1]
  def change
    create_table :habits do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.string :color, null: false, default: "#4F46E5"
      t.integer :position
      t.timestamps
    end
  end
end
