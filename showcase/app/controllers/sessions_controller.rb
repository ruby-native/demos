class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  # Production-only: the on-device sign-in test harness loops sign-ins faster
  # than 10 per 3 minutes from one IP.
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_path, alert: "Try again later." } if Rails.env.production?

  def new
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path, status: :see_other
  end
end
