user = User.find_or_create_by!(email_address: "demo@example.com") do |u|
  u.password = "password123"
  u.password_confirmation = "password123"
end

user.todos.destroy_all

today = Date.current

[
  { title: "Buy milk",                 due_at: today.beginning_of_day + 15.hours },
  { title: "Schedule dentist",         due_at: today.beginning_of_day + 17.hours }
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

puts "Seeded user demo@example.com (password: password123) with #{user.todos.count} todos"
