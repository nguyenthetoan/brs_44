class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform message
    ActionCable.server.broadcast "chatrooms_#{message.chatroom.id}",
      message: render_message(message)
  end

  private
  def render_message message
    ApplicationController.render partial: "messages/message",
      locals: {message: message}
  end
end
