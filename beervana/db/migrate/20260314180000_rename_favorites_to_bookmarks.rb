class RenameFavoritesToBookmarks < ActiveRecord::Migration[8.1]
  def change
    rename_table :favorites, :bookmarks
  end
end
