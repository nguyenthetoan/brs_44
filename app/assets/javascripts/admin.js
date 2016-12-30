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
    $('#modal-new').css('display', 'block')
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
    $selected_parent = $('#parent_category')[0].selectedIndex
    $parent_tr = '';
    $data = ''
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
          $new_id = $new_row.attr('id').split('_')[1]
          $new_val = $new_row.children().first().text().trim()
          if (data == null) {
            sweetAlert(I18n.t('ops'),
              I18n.t("cate_may_exist"), 'error');
          }
          if ($parent_id.length == 0) {
            $('#categories tr:last').after($new_row)
            $('#parent_category').append($('<option>', {
              value: $new_id,
              text: $new_val
            }))
          } else {
            $('#parent_category option').eq($selected_parent).after($('<option>',
              {value: $new_id, text: $new_val}))
            $parent_tr = $('#category_' + $parent_id);
            $parent_tr.after($new_row)
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

  $('#btn-new-publisher').click(function(e) {
    e.preventDefault()
    $('#modal-new-publisher').css('display', 'block')
    $.ajax({
      dataType: 'html',
      url: 'publishers/new',
      method: 'get',
      success: function(data) {
        $('.modal-body').html(data)
      }
    });
    return false
  })
  new_item('#new_publisher', '#publishers', 'create_publisher_error')
  delete_item('.btn-delete-publisher', 'publisher')
  get_edit_data('.btn-edit-publisher', 'publisher')
  edit_item('.edit_publisher', 'create_publisher_error')

 $count = 0;

$('body').on('click', '.add_fields', function(e) {
  e.preventDefault();
  $spec = $(this).attr('data-fields')
  if ($count < 4) {
    $('#spec').append($spec)
    $count += 1;
  } else {
    sweetAlert(I18n.t('ops'), I18n.t('exceed_spec'), "error");
    return;
  }
    return false;
  })

  $('body').on('click', '#remove_fields', function(e) {
    e.preventDefault();
    $fieldset = $(this).closest('fieldset')
    $fieldset.fadeOut(1000, function() {
      $fieldset.remove();
      $count -= 1;
    })
    return false;
  })

})

