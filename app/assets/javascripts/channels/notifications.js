$(document).on('turbolinks:load', function() {

  App.notifications = App.cable.subscriptions.create('NotificationsChannel', {
    connected: function() {
    },

    disconnected: function() {
    },

    received: function(data) {
      $unread_count = parseInt($('[data-behavior="unread-count"]').text());

      $('[data-behavior="unread-count"]').text($unread_count + 1)
      $('[data-behavior="notification-items"]').prepend(data['notification']);
      $('#dropdownMenu1').css('color', 'red')
    }
  });
})

