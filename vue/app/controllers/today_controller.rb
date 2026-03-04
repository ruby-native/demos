class TodayController < ApplicationController
  def show
    @page_title = "Today"
    habits = current_user.habits.includes(:completions)
    today = Date.current

    render inertia: "Today/Show", props: {
      date: today.strftime("%A, %B %-d"),
      habits: habits.map { |h|
        {
          id: h.id,
          name: h.name,
          color: h.color,
          completed: h.completed_on?(today)
        }
      },
      completed_count: habits.count { |h| h.completed_on?(today) },
      total_count: habits.size
    }
  end
end
