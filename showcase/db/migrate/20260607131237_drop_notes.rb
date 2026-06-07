class DropNotes < ActiveRecord::Migration[8.1]
  def change
    drop_table :notes do |t|
      t.text :body
      t.references :book, null: false, foreign_key: true
      t.timestamps
    end
  end
end
