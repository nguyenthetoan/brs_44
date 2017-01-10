$(document).on('turbolinks:load', function() {
  var messages, messages_to_bottom;
  messages = $('#messages');
  if ($('#messages').length > 0) {
    messages_to_bottom = function() {
      return messages.scrollTop(messages.prop("scrollHeight"));
    };
    messages_to_bottom();
    App.global_chat = App.cable.subscriptions.create({
      channel: "ChatChannel",
      chatroom_id: messages.data('chatroom-id')
    }, {
      connected: function() {
        $('#chat-box').animate({ scrollTop: $('#chat-box').prop("scrollHeight")}, 1000);
      },
      disconnected: function() {},
      received: function(data) {
        $('#chat-box').append(data['message']);
        $('#chat-box').animate({ scrollTop: $('#chat-box').prop("scrollHeight")}, 1000);

        return messages_to_bottom();
      },
      send_message: function(message, chatroom_id) {
        return this.perform('send_message', {
          message: message,
          chatroom_id: chatroom_id
        });
      }
    });
  }
  return $('#new_message').submit(function(e) {
    var $this, textarea;
    $this = $(this);
    textarea = $this.find('#message_body');
    if ($.trim(textarea.val()).length >= 1) {
      App.global_chat.send_message(textarea.val(), messages.data('chatroom-id'));
      textarea.val('');
    }
    e.preventDefault();
    return false;
  });
});
