class NotesController < ApplicationController
  before_action :set_book

  def new
    @note = @book.notes.new
  end

  def create
    @note = @book.notes.new(note_params)
    if @note.save
      redirect_to @book
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_book
    @book = Current.user.books.find(params[:book_id])
  end

  def note_params
    params.require(:note).permit(:body)
  end
end
