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

  $('.close').click(function() {
    $('#modal-new-book').fadeOut();
    $('#modal-edit-book').fadeOut();
  })

  $('body').click(function(event) {
    if (event.target.id == $('#modal-new-book').attr('id')) {
      $('#modal-new-book').fadeOut();
      $('#modal-edit-book').fadeOut();
    }
  })

  $('#btn-new-book').click(function(e) {
    e.preventDefault()
    $('#modal-new-book').css('display', 'block')
    $.ajax({
      dataType: "html",
      url: "books/new",
      method: "get",
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
        dataType: "html",
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
        dataType: "html",
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
      dataType: "html",
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
    if (confirm("Are you sure?")) {
      $book_id = $(this).attr('href').split('/')[3]
      $tr_id = '#book_' + $book_id
      console.log($tr_id)
      $.ajax({
        dataType: "html",
        url: $(this).attr('href'),
        method: "DELETE",
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
    $del_url = 'favorites/' + $book_id
    $.ajax({
      dataType: 'html',
      url: $url,
      method: 'post',
      success: function() {
        $btn.removeClass('btn-fav fa-heart-o').addClass('btn-unfav fa-heart')
        $btn.attr('href', $del_url)
      }
    })
    return false;
  });

  $('body').on('click', '.btn-unfav', function(e) {
    e.preventDefault();
    $btn = $(this)
    $url = $(this).attr('href')
    $book_id = $url.slice(-1)
    $add_url = 'favorites?id=' + $book_id
    $.ajax({
      dataType: 'html',
      url: $url,
      method: 'delete',
      success: function() {
        $btn.removeClass('btn-unfav fa-heart').addClass('btn-fav fa-heart-o')
        $btn.attr('href', $add_url)
      }
    })
    return false;
  });

})
