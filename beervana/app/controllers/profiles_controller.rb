class ProfilesController < ApplicationController
  def show
    @stamp_count = current_user.stamps.count
    @bookmark_count = current_user.bookmarks.count
  end

  def destroy
    current_user.destroy
    sign_out current_user
    redirect_to root_path
  end
end
