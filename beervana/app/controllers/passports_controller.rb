class PassportsController < ApplicationController
  NeighborhoodProgress = Data.define(:neighborhood, :total, :stamped, :percentage, :complete)

  def show
    @stamps = current_user.stamps.includes(:brewery).order(stamped_at: :desc)
    @stamp_count = @stamps.size
    @brewery_count = Brewery.visible.count
  end

  def progress
    stamped_brewery_ids = current_user.stamps.pluck(:brewery_id)

    @neighborhoods = Neighborhood.ordered
      .includes(:breweries)
      .map { |n|
        breweries = n.breweries.visible.ordered
        stamped = breweries.count { |b| stamped_brewery_ids.include?(b.id) }
        NeighborhoodProgress.new(
          neighborhood: n,
          total: breweries.size,
          stamped: stamped,
          percentage: breweries.any? ? (stamped.to_f / breweries.size * 100).round : 0,
          complete: stamped == breweries.size && breweries.any?
        )
      }
      .reject { |n| n.total == 0 }
      .sort_by { |n| [-n.percentage, n.neighborhood.name] }

    @total_breweries = @neighborhoods.sum(&:total)
    @total_stamped = @neighborhoods.sum(&:stamped)
  end
end
