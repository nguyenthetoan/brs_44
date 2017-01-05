class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :in_conversation_only, only: :show

  def index
    @followings = current_user.following
    @availables = current_user.passive_conversations
  end

  def new
    @guest = User.find_by id: params[:guest_id]
  end

  def create
    @chatroom = current_user.active_conversations.build chatroom_params
    if @chatroom.save
      flash[:notice] = "created chat room"
      redirect_to chatroom_path(@chatroom)
    else
      render :new
    end
  end

  def show
    @chatroom = Chatroom.includes(:messages).find_by id: params[:id]
    @message = Message.new
  end

  private
  def chatroom_params
    params.require(:chatroom).permit :title, :guest_id
  end

  def in_conversation_only
    chatroom = Chatroom.find_by id: params[:id]
    unless chatroom.host == current_user || chatroom.guest == current_user
      redirect_to root_path
    end
  end

end
