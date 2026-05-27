class PagesController < ApplicationController
  def discover
  end

  def stats
    books = Current.user.books
    @finished_count = books.finished.count
    @currently_reading_count = books.currently_reading.count
    @want_to_read_count = books.want_to_read.count
    @pages_read = books.finished.sum(:pages).to_i + books.currently_reading.sum(:current_page).to_i
  end

  def profile
    @user = Current.user
  end
end
