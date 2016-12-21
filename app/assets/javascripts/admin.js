$(document).on('turbolinks:load', function() {

  $req_id = '';

  $(document).on('click', '.modal-admin-request .edit_request', function() {
    $form = $(this);
    $form.submit(function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      $remove_tr = '#request_' + $req_id
      $.ajax({
        url: $form.attr('action'),
        method: $form.attr('method'),
        dataType: 'html',
        data: $form.serialize(),
        success: function(data) {
          $('#modal-edit-request').fadeOut();
          $('.proc_req > tbody').html(data).hide().fadeIn(1000);
          $($remove_tr).fadeOut();
        }
      })
    })
  });

  $(document).on('click', '.btn-admin-request', function(e) {
    e.preventDefault();
    $('#modal-edit-request').css('display', 'block')
    $url = $(this).attr('href')
    $req_id = $url.split('/')[3]
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

  $(document).on('click', '#new_book', function() {
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

  $(document).on('click', '.edit_book', function() {
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

  $(document).on('click', '.btn-edit-book', function(e) {
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

  $(document).on('click', '.btn-delete', function(e) {
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

})
