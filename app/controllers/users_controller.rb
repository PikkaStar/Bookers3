class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:show,:edit,:update]
  before_action :new_book, only: [:index,:show]

  def index
    @user = current_user
    @users = User.page(params[:page]).per(10)
  end

  def show
    @books = @user.books
    @current_entry = Entry.where(user_id: current_user.id)
    @partner_entry = Entry.where(user_id: @user.id)
    unless @user == current_user
      @current_entry.each do |c|
        @partner_entry.each do |p|
          if c.area_id == p.area_id
            @isArea = true
            @room = c.area_id
          end
        end
      end
      unless @isArea
        @area = Area.new
        @entry = Entry.new
      end
    end
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
