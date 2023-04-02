class UsersController < ApplicationController

  # ログインしている状態だけ許可するアクションをonlyで指定
	before_action :authenticate_user!, only: [:index,:show,:edit,:update]

	def create
    @book = Book.new(book_params)
    # booksのuser_idカラムは現在ログイン中のIDで保存する
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
    flash[:success]="You have created book successfully."
  end

  def index
    @users = User.all
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
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

  def book_params
    params.require(:book).permit(:title,:body)
  end
end