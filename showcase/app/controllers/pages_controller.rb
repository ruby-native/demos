class PagesController < ApplicationController
  def discover
  end

  READING_GOAL = 24

  def stats
    books = Current.user.books
    @reading_goal = READING_GOAL
    @finished_this_year = books.finished.where(finished_at: Time.current.beginning_of_year..).count
    @finished_count = books.finished.count
    @currently_reading_count = books.currently_reading.count
    @want_to_read_count = books.want_to_read.count
    @pages_read = books.finished.sum(:pages).to_i + books.currently_reading.sum(:current_page).to_i
  end

  def profile
    @user = Current.user
  end
end
