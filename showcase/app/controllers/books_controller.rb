class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy finish]

  FILTERS = %w[currently_reading want_to_read finished].freeze

  def index
    @filter = params[:filter] if FILTERS.include?(params[:filter])
    scope = Current.user.books.recent
    @books = @filter ? scope.where(status: @filter) : scope
    @currently_reading = scope.currently_reading
  end

  def show
    @notes = @book.notes.order(created_at: :desc)
  end

  def new
    @book = Current.user.books.new(
      status: :want_to_read,
      title: "James",
      author: "Percival Everett"
    )
  end

  def create
    @book = Current.user.books.new(book_params)
    sleep 1.5 if Rails.env.development?
    if @book.save
      redirect_to @book
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, status: :see_other
  end

  def finish
    @book.update!(status: :finished, finished_at: Time.current)
    redirect_to books_path
  end

  private

  def set_book
    @book = Current.user.books.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :cover, :cover_url, :status, :pages, :current_page, :started_at, :finished_at)
  end
end
