class BooksController < ApplicationController

	before_action :authenticate_user!

  def index
  	@booknew = Book.new
  	@books = Book.all
  	@user = User.find(current_user.id)
  end

  def create
  	@booknew = Book.new(book_params)
  	@booknew.user_id = current_user.id
  	if @booknew.save
      flash[:save] = 'You have creatad book successfully.'
  	   redirect_to book_path(@booknew)
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render 'index'
    end
  end

  def show
    @booknew = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if @user.id == current_user.id
      render action: :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:update] = 'You have updated book successfully.'
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body, :user_id)
  end
end
