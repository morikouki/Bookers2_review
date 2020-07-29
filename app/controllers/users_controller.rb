class UsersController < ApplicationController

	before_action :authenticate_user!

  def index
  	@booknew = Book.new
  	@users = User.all
  	@user = User.find(current_user.id)
  end

  def show
    @booknew = Book.new
  	@user = User.find(params[:id])
  	@books = @user.books
  end

  def edit
  	@user = User.find(params[:id])
    if @user.id == current_user.id
      render action: :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
       flash[:user_update] = 'You have updated user successfully.'
  	   redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

end