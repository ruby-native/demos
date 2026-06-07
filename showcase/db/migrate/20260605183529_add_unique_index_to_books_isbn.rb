class AddUniqueIndexToBooksIsbn < ActiveRecord::Migration[8.1]
  def change
    # One copy of an edition per library. Partial so books without an ISBN
    # (manual entries, search results missing one) are exempt.
    add_index :books, [:user_id, :isbn], unique: true, where: "isbn IS NOT NULL",
              name: "index_books_on_user_id_and_isbn"
  end
end
