class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform notification
    ActionCable.server.broadcast "notifications:#{notification.recipient_id}",
      notification: render_notification(notification)
  end

  private
  def render_notification notification
    partial_format = "notifications/#{notification.notifiable_type.underscore.pluralize}/#{notification.action}"
    ApplicationController.render partial: partial_format,
      locals: {notification: notification}
  end

end
