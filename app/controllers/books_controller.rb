class BooksController < ApplicationController

  def index
  	@booknew = Book.new
  	@books = Book.all
  end

  def create
  	@booknew = Book.new(book_params)
  	@booknew.save
  	redirect_to books_path
  end

  def show
  end

  def edit
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body, :user_id)
  end
end
