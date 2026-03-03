class OmniauthCallbacksController < ApplicationController
  skip_before_action :authenticate_user!
  skip_forgery_protection only: :create

  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in(user)
    redirect_to categories_path
  end

  def failure
    redirect_to new_session_path, alert: "Sign in failed: #{params[:message]}"
  end
end
