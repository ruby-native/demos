User.where.not(email_address: "joe@masilotti.com").destroy_all

user = User.find_or_create_by!(email_address: "joe@masilotti.com") do |u|
  u.name = "Joe Masilotti"
  u.password = "password123"
  u.password_confirmation = "password123"
end
user.update!(name: "Joe Masilotti") if user.name.blank?

user.todos.destroy_all

today = Date.current

next_round_hour = [ Time.current.change(min: 0, sec: 0) + 1.hour, today.end_of_day - 2.hours ].min
buy_milk_due    = [ today.beginning_of_day + 18.hours, next_round_hour ].max
dentist_due     = [ today.beginning_of_day + 20.hours, buy_milk_due + 2.hours ].max

[
  { title: "Buy milk",         due_at: buy_milk_due },
  { title: "Schedule dentist", due_at: dentist_due }
].each { |attrs| user.todos.create!(attrs) }

[
  { title: "Renew passport",           due_at: today + 5.days },
  { title: "Cancel old gym membership" },
  { title: "Plan weekend trip",        description: "Look into Bend or the coast." }
].each { |attrs| user.todos.create!(attrs) }

[
  { title: "Sign birthday card",       completed_at: 2.days.ago },
  { title: "Take out recycling",       completed_at: 3.days.ago }
].each { |attrs| user.todos.create!(attrs) }

puts "Seeded user joe@masilotti.com (password: password123) with #{user.todos.count} todos"
