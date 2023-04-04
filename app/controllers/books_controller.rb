class BooksController < ApplicationController
  # ログインしている状態だけ許可するアクションをonlyで指定
  before_action :authenticate_user!, only: [:index,:show,:edit,:create,:update,:destroy]

  def index
    @books=Book.all
    # index内に投稿を置く場合、newが必要
    @book = Book.new
    # ログイン中のユーザーを渡す
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    # booksのuser_idカラムは現在ログイン中のIDで保存する
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book)
      flash[:success]="You have created book successfully."
    else
      @books=Book.all
      @user = current_user
      render :index
    end
  end

  def show
    # show内（book詳細）に投稿を置く場合、newが必要
    @book_new = Book.new
    @book = Book.find(params[:id])
    # テンプレート化するために、@userに@book.userを格納
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
        redirect_to book_path(@book.id)
        flash[:success]="You have updated book successfully."
    else
      @books = Book.all
      render action: :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end