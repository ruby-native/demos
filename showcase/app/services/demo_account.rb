# Builds a throwaway demo account by cloning the seeded shelf, so every visitor
# gets their own populated library and can change anything without stepping on
# other visitors. Covers come from the committed ISBN assets, so cloning is just
# duplicating rows. No image files are copied.
class DemoAccount
  SOURCE_EMAIL = "demo@example.com"

  def self.create!
    new.create!
  end

  def create!
    ActiveRecord::Base.transaction do
      user = User.create!(email_address: unique_email, password: "password")
      clone_shelf_into(user)
      user
    end
  end

  private

  def source
    @source ||= User.find_by!(email_address: SOURCE_EMAIL)
  end

  def unique_email
    loop do
      email = "demo#{1000 + SecureRandom.random_number(9000)}@example.com"
      return email unless User.exists?(email_address: email)
    end
  end

  def clone_shelf_into(user)
    source.books.find_each do |book|
      user.books.create!(
        title: book.title,
        author: book.author,
        isbn: book.isbn,
        pages: book.pages,
        current_page: book.current_page,
        status: book.status,
        cover_url: book.cover_url,
        started_at: book.started_at,
        finished_at: book.finished_at
      )
    end
  end
end
