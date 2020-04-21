class MessagesController < ApplicationController
  before_action :set_group
  before_action :authenticate_user!, except: [:index,:create]
  def index
    @message = Message.new
    @messages = @group.messages.includes(:user)
  end

  def new
    @message = Message.new
  end
  
  def create
    @message = @group.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.json
      end
      if user_id =! current_user
      flash[:notice] = 'メッセージが投稿されました。担当者がご対応させていただきます。'
      end
      
    else
      @messages = @group.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render :index
    end
  end

  def destroy
    @message =  @group.messages.find(params[:id])
    @message.destroy
    redirect_to groups_paath
  end

  private
  def message_params
    params.require(:message).permit(:content,:image,:user_id)
  end
  def set_group
    @group = Group.find(params[:group_id])
    @user = User.all
  end
end
