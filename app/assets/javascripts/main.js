$(document).on('turbolinks:load', function() {

  $('ul.nav > li > a').each(function() {
    $title = $(document).find("title").text().split(' ')[0].toLowerCase();
    if ($(this).text().split(' ')[0].toLowerCase() == $title) {
      $(this).closest('li').addClass('active');
    }
  });

  var active1 = false;
  var active2 = false;
  var active3 = false;
  var active4 = false;
  $('.mini-navbar').on('mousedown touchstart', function() {
    if (!active1) $(this).find('.usercp').css({
      'background-color': 'gray',
      'transform': 'translate(0px,125px)'
    });
    else $(this).find('.usercp').css({
      'background-color': 'dimGray',
      'transform': 'none'
    });
    if (!active2) $(this).find('.test2').css({
      'background-color': 'gray',
      'transform': 'translate(60px,105px)'
    });
    else $(this).find('.test2').css({
      'background-color': 'darkGray',
      'transform': 'none'
    });
    if (!active3) $(this).find('.test3').css({
      'background-color': 'gray',
      'transform': 'translate(105px,60px)'
    });
    else $(this).find('.test3').css({
      'background-color': 'silver',
      'transform': 'none'
    });
    if (!active4) $(this).find('.test4').css({
      'background-color': 'gray',
      'transform': 'translate(125px,0px)'
    });
    else $(this).find('.test4').css({
      'background-color': 'silver',
      'transform': 'none'
    });
    active1 = !active1;
    active2 = !active2;
    active3 = !active3;
    active4 = !active4;
  });

  $modal = $('#modal-new-book');

  $btn = $('#btn-new-book');

  $span = $('.close');

  $btn.click(function() {
    $modal.css('display', 'block')
  })

  $span.click(function() {
    $modal.fadeOut();
  })

  $('body').click(function(event) {
    if (event.target.id == $modal.attr('id')) {
      $modal.fadeOut();
    }
  })
});
