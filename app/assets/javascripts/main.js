$(document).on('turbolinks:load', function() {

  $('ul.nav > li > a').each(function() {
    $title = $(document).find('title').text().split(' ')[0].toLowerCase();
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

  $('.close').click(function() {
    $('#modal-new-book').fadeOut();
    $('#modal-edit-book').fadeOut();
    $('#modal-new-request').fadeOut();
    $('#modal-edit-request').fadeOut();
  })

  $('body').click(function(event) {
    if (event.target.id == $('#modal-new-book').attr('id')) {
      $('#modal-new-book').fadeOut();
      $('#modal-edit-book').fadeOut();
      $('#modal-new-request').fadeOut();
      $('#modal-edit-request').fadeOut();
    }
  })

  $('#btn-new-book').click(function(e) {
    e.preventDefault()
    $('#modal-new-book').css('display', 'block')
    $.ajax({
      dataType: 'html',
      url: 'books/new',
      method: 'get',
      success: function(data) {
        $('.modal-body').html(data)
      }
    });
    return false
  })

  $('body').on('click', '#new_book', function() {
    $form = $(this);
    $form.submit(function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      $.ajax({
        url: $form.attr('action'),
        method: $form.attr('method'),
        dataType: 'html',
        data: $form.serialize(),
        success: function(data) {
          $('#modal-new-book').fadeOut();
          $('tbody').append(data).children(':last').hide().fadeIn(1000)
        }
      })
    })
  });

  $('body').on('click', '.edit_book', function() {
    $form = $(this);
    $form.submit(function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      $.ajax({
        url: $form.attr('action'),
        method: $form.attr('method'),
        dataType: 'html',
        data: $form.serialize(),
        success: function(data) {
          $('#modal-edit-book').fadeOut();
          $('tbody').html(data).hide().fadeIn(1000)
        }
      })
    })
  });

  $('body').on('click', '.btn-edit-book', function(e) {
    e.preventDefault();
    $('#modal-edit-book').css('display', 'block')
    $url = $(this).attr('href')
    console.log($url)
    $.ajax({
      dataType: 'html',
      url: $url,
      method: $(this).attr('method'),
      success: function(data) {
        $('.edit-modal-body').html(data)
      }
    });
    return false
  })

  $('body').on('click', '.btn-delete', function(e) {
    e.preventDefault();
    if (confirm(I18n.t('confirm_delete'))) {
      $book_id = $(this).attr('href').split('/')[3]
      $tr_id = '#book_' + $book_id
      console.log($tr_id)
      $.ajax({
        dataType: 'html',
        url: $(this).attr('href'),
        method: 'DELETE',
        success: function() {
          $($tr_id).fadeOut();
        }
      })
    } else {

    }
    return false;
  })

  $('body').on('click', '.btn-fav', function(e) {
    e.preventDefault();
    $btn = $(this)
    $url = $(this).attr('href')
    $book_id = $url.split('=')[1]
    $del_url = '/favorites/' + $book_id
    $fav_count = parseInt($('.favorited-count').text())
    $.ajax({
      dataType: 'html',
      url: $url,
      method: 'post',
      success: function() {
        $btn.removeClass('btn-fav fa-heart-o').addClass('btn-unfav fa-heart')
        $btn.html(I18n.t('remove_fav_book'))
        $btn.attr('href', $del_url)
        $('.favorited-count').html($fav_count + 1)
      }
    })
    return false;
  });

  $('body').on('click', '.btn-unfav', function(e) {
    e.preventDefault();
    $btn = $(this)
    $url = $(this).attr('href')
    $book_id = $url.slice(-1)
    $add_url = '/favorites?id=' + $book_id
    $fav_count = parseInt($('.favorited-count').text())
    $.ajax({
      dataType: 'html',
      url: $url,
      method: 'delete',
      success: function() {
        $btn.removeClass('btn-unfav fa-heart').addClass('btn-fav fa-heart-o')
        $btn.attr('href', $add_url)
        $btn.html(I18n.t('add_fav_book'))
        $('.favorited-count').html($fav_count - 1)
      }
    })
    return false;
  });

  $('#btn-new-request').click(function(e) {
    e.preventDefault()
    $('#modal-new-request').css('display', 'block')
    $.ajax({
      dataType: 'html',
      url: 'requests/new',
      method: 'get',
      success: function(data) {
        $('.modal-body').html(data)
      }
    });
    return false
  })

  $('body').on('click', '#new_request', function() {
    $form = $(this);
    $form.submit(function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      $.ajax({
        url: $form.attr('action'),
        method: $form.attr('method'),
        dataType: 'html',
        data: $form.serialize(),
        success: function(data) {
          $('#modal-new-request').fadeOut();
          $('tbody').prepend(data).hide().fadeIn(1000)
        }
      })
    })
  });

  $('body').on('click', '.btn-edit-request', function(e) {
    e.preventDefault();
    $('#modal-edit-request').css('display', 'block')
    $url = $(this).attr('href')
    console.log($url)
    $.ajax({
      dataType: 'html',
      url: $url,
      method: $(this).attr('method'),
      success: function(data) {
        $('.edit-modal-body').html(data)
      }
    });
    return false
  })

$('body').on('click', '.edit_request', function() {
    $form = $(this);
    $form.submit(function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      $.ajax({
        url: $form.attr('action'),
        method: $form.attr('method'),
        dataType: 'html',
        data: $form.serialize(),
        success: function(data) {
          $('#modal-edit-request').fadeOut();
          $('tbody').html(data).hide().fadeIn(1000)
        }
      })
    })
  });

  $('body').on('click', '.btn-delete-request', function(e) {
    e.preventDefault();
    if (confirm(I18n.t('confirm_delete'))) {
      $req_id = $(this).attr('href').split('/')[2]
      $tr_id = '#request_' + $req_id
      $.ajax({
        dataType: 'html',
        url: $(this).attr('href'),
        method: 'DELETE',
        success: function() {
          $($tr_id).fadeOut();
        }
      })
    } else {

    }
    return false;
  })

})
