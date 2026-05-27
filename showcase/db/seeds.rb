user = User.find_or_create_by!(email_address: "demo@example.com") do |u|
  u.password = "password"
  u.password_confirmation = "password"
end

user.books.destroy_all

books = [
  { title: "Bel Canto",                            author: "Ann Patchett",         isbn: "9780060934408", status: :currently_reading, pages: 318, current_page: 142, started_at: 3.weeks.ago },
  { title: "The Overstory",                        author: "Richard Powers",       isbn: "9780393635522", status: :currently_reading, pages: 502, current_page: 88,  started_at: 1.week.ago },
  { title: "Pachinko",                             author: "Min Jin Lee",          isbn: "9781455563937", status: :want_to_read,      pages: 490 },
  { title: "Klara and the Sun",                    author: "Kazuo Ishiguro",       isbn: "9780593318171", status: :finished,          pages: 303, finished_at: 2.months.ago },
  { title: "The Remains of the Day",               author: "Kazuo Ishiguro",       isbn: "9780679731726", status: :finished,          pages: 245, finished_at: 4.months.ago },
  { title: "A Gentleman in Moscow",                author: "Amor Towles",          isbn: "9780670026197", status: :want_to_read,      pages: 462 },
  { title: "The Goldfinch",                        author: "Donna Tartt",          isbn: "9780316055437", status: :want_to_read,      pages: 771 },
  { title: "Normal People",                        author: "Sally Rooney",         isbn: "9781984822178", status: :finished,          pages: 273, finished_at: 5.months.ago },
  { title: "Beautiful World, Where Are You",       author: "Sally Rooney",         isbn: "9780374602604", status: :want_to_read,      pages: 356 },
  { title: "Circe",                                author: "Madeline Miller",      isbn: "9780316556347", status: :finished,          pages: 393, finished_at: 6.months.ago },
  { title: "The Song of Achilles",                 author: "Madeline Miller",      isbn: "9780062060624", status: :finished,          pages: 378, finished_at: 7.months.ago },
  { title: "Project Hail Mary",                    author: "Andy Weir",            isbn: "9780593135204", status: :finished,          pages: 476, finished_at: 8.months.ago },
  { title: "Tomorrow, and Tomorrow, and Tomorrow", author: "Gabrielle Zevin",      isbn: "9780593321201", status: :want_to_read,      pages: 401 },
  { title: "The Seven Husbands of Evelyn Hugo",    author: "Taylor Jenkins Reid",  isbn: "9781501161933", status: :want_to_read,      pages: 400 },
  { title: "Lessons in Chemistry",                 author: "Bonnie Garmus",        isbn: "9780385547345", status: :want_to_read,      pages: 386 },
  { title: "The Lincoln Highway",                  author: "Amor Towles",          isbn: "9780735222359", status: :want_to_read,      pages: 576 },
  { title: "Demon Copperhead",                     author: "Barbara Kingsolver",   isbn: "9780063251922", status: :finished,          pages: 548, finished_at: 9.months.ago },
  { title: "Trust",                                author: "Hernan Diaz",          isbn: "9780593420317", status: :finished,          pages: 416, finished_at: 10.months.ago },
  { title: "The Power of the Dog",                 author: "Thomas Savage",        isbn: "9780316610896", status: :want_to_read,      pages: 304 },
  { title: "Crying in H Mart",                     author: "Michelle Zauner",      isbn: "9780525657743", status: :finished,          pages: 256, finished_at: 11.months.ago }
]

books.each { |attrs| user.books.create!(attrs) }

puts "Seeded #{user.books.count} books for #{user.email_address}"
