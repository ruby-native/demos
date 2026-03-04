class HabitsController < ApplicationController
  def index
    @page_title = "Habits"
    habits = current_user.habits.includes(:completions)

    render inertia: "Habits/Index", props: {
      habits: habits.map { |h|
        {
          id: h.id,
          name: h.name,
          description: h.description,
          color: h.color,
          completions_this_week: h.completions_this_week
        }
      }
    }
  end

  def new
    @page_title = "New habit"
    @native_form = true
    render inertia: "Habits/New", props: {
      habit: {name: "", description: "", color: "#4F46E5"}
    }
  end

  def edit
    habit = current_user.habits.find(params[:id])
    @page_title = "Edit habit"
    @native_form = true
    render inertia: "Habits/Edit", props: {
      habit: habit.as_json(only: %i[id name description color])
    }
  end

  def create
    habit = current_user.habits.build(habit_params)
    habit.position = (current_user.habits.maximum(:position) || 0) + 1

    if habit.save
      redirect_to habits_path, notice: "Habit created."
    else
      @page_title = "New habit"
      @native_form = true
      render inertia: "Habits/New", props: {
        habit: habit.as_json(only: %i[name description color]),
        errors: habit.errors.full_messages
      }
    end
  end

  def update
    habit = current_user.habits.find(params[:id])

    if habit.update(habit_params)
      redirect_to habits_path, notice: "Habit updated."
    else
      @page_title = "Edit habit"
      @native_form = true
      render inertia: "Habits/Edit", props: {
        habit: habit.as_json(only: %i[id name description color]),
        errors: habit.errors.full_messages
      }
    end
  end

  def destroy
    current_user.habits.find(params[:id]).destroy!
    redirect_to habits_path, status: :see_other, notice: "Habit deleted."
  end

  private

  def habit_params
    params.expect(habit: [:name, :description, :color])
  end
end
