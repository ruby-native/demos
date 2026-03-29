class AddSubscribedToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :subscribed, :boolean, default: false, null: false
  end
end
