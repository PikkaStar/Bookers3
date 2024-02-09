class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_book, only: [:show,:edit,:update,:destroy]
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "投稿しました"
      redirect_to book_path(@book)
    else
      flash[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def index
    @book = Book.new
    if params[:favorite_count]
      @books = Kaminari.paginate_array(Book.favorite_count).page(params[:page]).per(10)
    else
      @books = Book.page(params[:page]).per(10)
    end
    @user = current_user
  end

  def show
    @user = @book.user
    @book_new = Book.new
    @comment = Comment.new
    @comments = @book.comments
    unless ViewCount.where(created_at: Time.zone.now.all_day).find_by(user_id: current_user.id, book_id: @book.id)
      current_user.view_counts.create(book_id: @book.id)
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      flash[:notice] = "編集しました"
      redirect_to book_path(@book)
    else
      flash[:alert] = "編集できませんでした"
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body,:image)
  end

  def find_book
    @book = Book.find(params[:id])
  end


end
