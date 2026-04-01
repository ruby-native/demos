class CompletionsController < ApplicationController
  def toggle
    habit = current_user.habits.find(params[:habit_id])
    today = Date.current
    completion = habit.completions.find_by(completed_on: today)

    if completion
      completion.destroy!
      head :ok
    else
      habit.completions.create!(completed_on: today)
      head :created
    end
  end
end
