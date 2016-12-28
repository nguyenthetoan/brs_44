$(document).on('turbolinks:load', function() {

  $req_id = '';

  $('body').on('click', '.modal-admin-request .edit_request', function() {
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

  $('body').on('click', '.btn-admin-request', function(e) {
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

  $('body').on('click', '#new_category', function() {
    $form = $(this)
    $parent_id = $('#parent_category').val();
    $parent_tr = '';
    $form.submit(function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      $.ajax({
        dataType: 'html',
        method: $form.attr('method'),
        url: $form.attr('action'),
        data: $form.serialize(),
        success: function(data) {
          $new_row = $('' + data)
          if (data == null) {
            sweetAlert(I18n.t('ops'),
              I18n.t("cate_may_exist"), 'error');
          }
          if ($parent_id.length == 0) {
            $('#categories tr:last').after($new_row)
          } else {
            $parent_tr = $('#category_' + $parent_id);
            $parent_tr.after($new_row)
            $parent_tr = '';
          }
          $new_row.hide().fadeIn(3000)
        },
        error: function(jqXHR, exception) {
          sweetAlert(I18n.t('ops'),
            I18n.t("create_cate_error") + jqXHR.status, 'error');
        }
      })
    })
  })

  delete_item('.btn-delete-author', 'author')
  delete_item('.btn-delete-category', 'category')
  delete_item('.btn-delete', 'book')
  new_item('#new_author', '#authors', 'create_author_error')
  new_item('#new_book', '#books', 'create_book_error')
  get_edit_data('.btn-edit-book', 'book')
  get_edit_data('.btn-edit-author', 'author')
  get_edit_data('.btn-edit-category', 'category')
  edit_item('.edit_book', 'create_book_error')
  edit_item('.edit_author', 'create_author_error')
  edit_item('.edit_category', 'create_category_error')
})
