class TodayController < ApplicationController
  SCOPES = %w[today upcoming anytime].freeze

  def index
    @scope = SCOPES.include?(params[:scope]) ? params[:scope] : "today"
    @todos = todos_for(@scope)
  end

  private

  def todos_for(scope)
    case scope
    when "upcoming"
      Current.user.todos.pending.where("due_at > ?", Time.current.end_of_day).order(:due_at)
    when "anytime"
      Current.user.todos.pending.where(due_at: nil).order(:created_at)
    else
      Current.user.todos.due_today.order(:due_at)
    end
  end
end
