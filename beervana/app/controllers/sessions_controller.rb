class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new, :dev ]
  before_action :redirect_if_authenticated, only: :new

  def new
  end

  def dev
    user = User.find_by!(email: "demo@beervana.test")
    sign_in(user)
    redirect_to explore_path
  end

  def destroy
    sign_out current_user
    redirect_to root_path
  end
end
