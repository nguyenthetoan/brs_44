var Notifications,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Notifications = (function() {
  function Notifications() {
    this.handleSuccess = bind(this.handleSuccess, this);
    this.handleClick = bind(this.handleClick, this);
    this.notifications = $("[data-behavior='notifications']");
    if (this.notifications.length > 0) {
      this.handleSuccess(this.notifications.data("notifications"));
      $("[data-behavior='notifications-link']").on("click", this.handleClick);
      this.getNewNotifications();
    }
  }

  Notifications.prototype.getNewNotifications = function() {
    return $.ajax({
      url: "/notifications.json",
      dataType: "JSON",
      method: "GET",
      success: this.handleSuccess
    });
  };

  Notifications.prototype.handleClick = function(e) {
    return $.ajax({
      url: "/notifications/update",
      dataType: "JSON",
      method: "PUT",
      success: function() {
        return $("[data-behavior='unread-count']").text(0);
      }
    });
  };

  Notifications.prototype.handleSuccess = function(data) {
    var items, unread_count;
    items = $.map(data, function(notification) {
      return notification.template;
    });
    unread_count = 0;
    $.each(data, function(i, notification) {
      if (notification.unread) {
        return unread_count += 1;
      }
    });
    $("[data-behavior='unread-count']").text(unread_count);
    return $("[data-behavior='notification-items']").html(items);
  };

  return Notifications;

})();

jQuery(function() {
  return new Notifications;
});
