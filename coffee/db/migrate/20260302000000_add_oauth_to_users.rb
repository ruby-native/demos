class AddOauthToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :google_uid, :string
    add_column :users, :apple_uid, :string
  end
end
