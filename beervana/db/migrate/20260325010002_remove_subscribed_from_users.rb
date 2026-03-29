class RemoveSubscribedFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :subscribed, :boolean, default: false, null: false
  end
end
