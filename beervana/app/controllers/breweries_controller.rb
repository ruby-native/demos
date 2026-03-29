class BreweriesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    breweries = Brewery.visible.ordered.to_a
    @free_breweries = breweries.first(3)
    @locked_breweries = breweries.drop(3)
    @total_count = breweries.size
  end

  def show
    @brewery = Brewery.find(params[:id])
    if user_signed_in?
      @stamp = current_user.stamps.find_by(brewery: @brewery)
      @bookmark = current_user.bookmarks.find_by(brewery: @brewery)
    end
  end
end
