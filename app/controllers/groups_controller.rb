class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :my_group, only: [:show, :edit, :update, :destroy]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      flash[:notice] = "グループを作成しました"
      redirect_to group_path(@group)
    else
      flash[:alert] = "グループを作成できませんでした"
      render :new
    end
  end

  def index
    @user = current_user
    @groups = Group.all
  end

  def show
    @user = current_user
    users = @group.users
    @owner = users.first
  end

  def edit
  end

  def update
   if  @group.update(group_params)
     flash[:notice] = "グループを編集しました"
     redirect_to group_path(@group)
   else
     flash[:alert] = "編集に失敗しました"
     render :edit
   end
  end

  def destroy
    @group.destroy
    flash[:notice] = "グループを削除しました"
    redirect_to groups_path
  end

  private
  def my_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

end
