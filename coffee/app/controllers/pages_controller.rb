class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :landing

  def landing
    return redirect_to categories_path if user_signed_in?
    render inertia: "Pages/Landing"
  end
end
