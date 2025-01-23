class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def show
    @user = current_user
    @book = Book.new
    @books = Book.where(user: current_user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
