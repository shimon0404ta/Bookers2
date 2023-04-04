class UsersController < ApplicationController

  def index
    @users = User.all
    @books = Book.all
    # index内（ユーザー一覧）に投稿を置く場合、newが必要
    @book = Book.new
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    # @userに紐付いたbooksのみを表示
    @books = @user.books
    # show内（ユーザ詳細）に投稿を置く場合、newが必要
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
        render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        redirect_to user_path(@user.id)
        flash[:success] = "You have updated user successfully."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end