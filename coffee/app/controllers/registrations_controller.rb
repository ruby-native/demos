class RegistrationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  before_action :redirect_if_authenticated, only: :new

  def new
    render inertia: "Registrations/New"
  end

  def create
    user = User.new(registration_params)

    if user.save
      sign_in user
      redirect_to categories_path
    else
      redirect_to new_registration_path, alert: user.errors.full_messages.join(", ")
    end
  end

  private

  def registration_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
