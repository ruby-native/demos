class CreateBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :books do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :author, null: false
      t.string :isbn
      t.string :cover_url
      t.integer :status, null: false, default: 0
      t.integer :pages
      t.integer :current_page, default: 0
      t.datetime :finished_at
      t.datetime :started_at

      t.timestamps
    end
  end
end
