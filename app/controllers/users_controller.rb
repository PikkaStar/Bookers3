class UsersController < ApplicationController
  before_action :find_user, only: [:show,:edit,:update]
  before_action :new_book, only: [:index,:show]

  def index
    @user = current_user
    @users = User.page(params[:page]).per(10)
  end

  def show
    @books = @user.books
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to user_path(current_user)
  end

  private
  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

  def new_book
    @book = Book.new
  end

end
