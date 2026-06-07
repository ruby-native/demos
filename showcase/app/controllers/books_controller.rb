class BooksController < ApplicationController
  before_action :set_book, only: %i[show destroy change_status progress update_progress]

  FILTERS = %w[currently_reading want_to_read finished].freeze

  def index
    @filter = params[:filter] if FILTERS.include?(params[:filter])
    scope = Current.user.books.recent
    @books = @filter ? scope.where(status: @filter) : scope
    @currently_reading = scope.currently_reading
  end

  def show
  end

  # The add-book entry point. Lives at /books/new so Hotwire Native presents it
  # as a modal (per the built-in path configuration), and searches in place via
  # a Turbo Frame.
  def new
    @query = params[:q].to_s.strip
    @results = @query.present? ? BookSearch.search(@query) : []
  end

  # Manual entry, reached from "enter it yourself" inside the add-book modal.
  def manual
    @book = Current.user.books.new(status: :want_to_read)
  end

  def create
    isbn = book_params[:isbn].presence
    if isbn && (existing = Current.user.books.find_by(isbn: isbn))
      return redirect_to existing, notice: "Already on your shelf."
    end

    @book = Current.user.books.new(book_params)
    if @book.save
      @book.attach_cover_from_url
      redirect_to @book
    else
      render :manual, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotUnique
    # Lost a race (e.g. a fast double-tap): the edition was added a moment ago.
    existing = Current.user.books.find_by(isbn: book_params[:isbn])
    redirect_to(existing || books_path, notice: "Already on your shelf.")
  end

  def destroy
    @book.destroy
    redirect_to books_path, status: :see_other
  end

  def change_status
    if Book.statuses.key?(params[:status])
      @book.update!(status: params[:status])
      flash[:celebrate] = @book.title if @book.finished?
    end
    redirect_to @book
  end

  def progress
  end

  def update_progress
    @book.log_progress(params.dig(:book, :current_page))
    redirect_to @book
  end

  private

  def set_book
    @book = Current.user.books.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :cover, :cover_url, :status, :pages)
  end
end
