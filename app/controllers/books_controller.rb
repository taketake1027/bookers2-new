class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # 一覧表示
  def index
    @books = Book.all
  end

  # 詳細表示
  def show
    @book = Book.find(params[:id]) # 該当する本を取得
    @user = @book.user             # 本に関連するユーザーを取得
  end
  

  # 新規作成フォーム
  def new
    @book = Book.new
  end

  # 作成処理
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      redirect_to book_path(@book), notice: '本の投稿が作成されました'
    else
      render :new, alert: '本の投稿に失敗しました'
    end
  end

  # 編集フォーム
  def edit
  end

  # 更新処理
  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: '本の投稿が更新されました'
    else
      render :edit, alert: '本の更新に失敗しました'
    end
  end

  # 削除処理
  def destroy
    @book.destroy
    redirect_to books_path, notice: '本の投稿が削除されました'
  end

  private

  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :author, :opinion, :image)
  end

  # 共通処理
  def set_book
    @book = Book.find(params[:id])
  end
end
