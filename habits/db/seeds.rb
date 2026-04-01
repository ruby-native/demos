user = User.find_or_create_by!(email: "user@example.com") do |u|
  u.password = "password"
  u.name = "Demo User"
end

habits = [
  {name: "Exercise", description: "30 minutes of movement", color: "#EF4444"},
  {name: "Read", description: "Read for 20 minutes", color: "#F59E0B"},
  {name: "Meditate", description: "10 minutes of mindfulness", color: "#10B981"},
  {name: "Journal", description: "Write a daily reflection", color: "#6366F1"},
  {name: "Drink water", description: "8 glasses throughout the day", color: "#3B82F6"}
]

habits.each_with_index do |attrs, i|
  habit = user.habits.find_or_create_by!(name: attrs[:name]) do |h|
    h.description = attrs[:description]
    h.color = attrs[:color]
    h.position = i + 1
  end

  # Completions over the past 7 days (deterministic based on habit position)
  7.times do |days_ago|
    date = Date.current - days_ago
    if (i + days_ago) % 3 != 0
      habit.completions.find_or_create_by!(completed_on: date)
    end
  end
end
