$(document).on('turbolinks:load', function() {

  App.notifications = App.cable.subscriptions.create('NotificationsChannel', {
    connected: function() {
      $unread_count = parseInt($('[data-behavior="unread-count"]').text());
    },

    disconnected: function() {
    },

    received: function(data) {
      console.log(data)
      $('[data-behavior="unread-count"]').text($unread_count + 1)
      $('[data-behavior="notification-items"]').prepend(data['notification']);
    }
  });
})

