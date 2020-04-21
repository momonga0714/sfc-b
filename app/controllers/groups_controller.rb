class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:create]
  before_action :set_message
  
  def index
    @groups = Group.includes(:user)
    @group = Group.new
  end

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: "グループ作成しました"
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_messages_path(params[:id]), notice: "グループを編集しました"
    else
      render :edit
    end
  end
  
  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path, notice: "グループを削除しました"
  end

  private
  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end
  
  def set_message
    
  end
end
