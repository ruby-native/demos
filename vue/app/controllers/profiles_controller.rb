class ProfilesController < ApplicationController
  def show
    @page_title = "Profile"
    render inertia: "Profiles/Show", props: {
      user: current_user.as_json(only: %i[id name email])
    }
  end

  def edit
    @page_title = "Edit profile"
    @native_form = true
    render inertia: "Profiles/Edit", props: {
      user: current_user.as_json(only: %i[id name email])
    }
  end

  def update
    if current_user.update(user_params)
      redirect_to profile_path, notice: "Profile updated."
    else
      @page_title = "Edit profile"
      @native_form = true
      render inertia: "Profiles/Edit", props: {
        user: current_user.as_json(only: %i[id name email]),
        errors: current_user.errors.full_messages
      }
    end
  end

  private

  def user_params
    params.expect(user: [:name, :email])
  end
end
