class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  before_action :redirect_if_authenticated, only: :new

  def new
    @page_title = "Sign in"
    @native_form = true
    render inertia: "Sessions/New"
  end

  def create
    if (user = User.authenticate_by(email: params[:email], password: params[:password]))
      sign_in user
      redirect_to root_path
    else
      flash.now.alert = "Invalid email or password."
      @page_title = "Sign in"
      @native_form = true
      render inertia: "Sessions/New"
    end
  end

  def destroy
    sign_out current_user
    redirect_to new_session_path
  end
end
