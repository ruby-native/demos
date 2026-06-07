class DemoSessionsController < ApplicationController
  allow_unauthenticated_access only: :create
  rate_limit to: 5, within: 1.minute, only: :create,
    with: -> { redirect_to new_session_path, alert: "Give it a moment and try the demo again." }

  def create
    user = DemoAccount.create!
    start_new_session_for user
    redirect_to root_path
  end
end
