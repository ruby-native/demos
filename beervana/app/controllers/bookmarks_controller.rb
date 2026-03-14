class BookmarksController < ApplicationController
  before_action :set_brewery

  def create
    current_user.bookmarks.find_or_create_by(brewery: @brewery)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to brewery_path(@brewery) }
    end
  end

  def destroy
    current_user.bookmarks.find_by(brewery: @brewery)&.destroy
    respond_to do |format|
      format.turbo_stream { render :create }
      format.html { redirect_to brewery_path(@brewery) }
    end
  end

  private

  def set_brewery
    @brewery = Brewery.find(params[:brewery_id])
  end
end
