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
          $('tbody').prepend(data).hide().fadeIn(1000)
          console.log(data)
        },
        error: function(jqXHR, exception) {
          sweetAlert(I18n.t('ops'),
            I18n.t('create_book_error'),
            'error');
        }
      })
    })
  });
  $edit_book_id = '';
  $edit_tr_id = '';

  $('body').on('click', '.btn-edit-book', function(e) {
    e.preventDefault();
    $('#modal-edit-book').css('display', 'block')
    $url = $(this).attr('href')
    $edit_book_id = $(this).attr('href').split('/')[3]
    $edit_tr_id = '#book_' + $edit_book_id
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
          $($edit_tr_id).replaceWith(data)
          $edit_book_id = ''
          $edit_tr_id = ''
        },
        error: function(jqXHR, exception) {
          sweetAlert(I18n.t('ops'),
            I18n.t('create_book_error'),
            'error');
        }
      })
    })
  });

  $('body').on('click', '.btn-delete', function(e) {
    e.preventDefault();
    $book_id = $(this).attr('href').split('/')[3]
    $tr_id = '#book_' + $book_id
    $url = $(this).attr('href')
    swal({
      title: I18n.t('ask_sure'),
      text: I18n.t('warning_delete'),
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#DD6B55',
      confirmButtonText: I18n.t('confirm_button'),
      cancelButtonText: I18n.t('cancel_button'),
      closeOnConfirm: false,
      closeOnCancel: false
      },
      function(isConfirm) {
        if (isConfirm) {
          $.ajax({
            dataType: 'html',
            url: $url,
            method: 'DELETE',
            success: function() {
              swal(I18n.t('done_delete'),
                I18n.t('delete_desc'),
                'success');
              $($tr_id).fadeOut();
            }
          })
        } else {
          swal(I18n.t('canceled'), I18n.t('safe_data'), "error");
        }
      });
    return false;
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

  $('body').on('click', '.btn-delete-category', function(e) {
    e.preventDefault();
    $cate_id = $(this).attr('href').split('/')[3]
    $tr_id = '#category_' + $cate_id
    $url = $(this).attr('href')
    swal({
      title: I18n.t('ask_sure'),
      text: I18n.t('warning_delete'),
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#DD6B55',
      confirmButtonText: I18n.t('confirm_button'),
      cancelButtonText: I18n.t('cancel_button'),
      closeOnConfirm: false,
      closeOnCancel: false
    }, function(isConfirm) {
        if (isConfirm) {
          $.ajax({
            dataType: 'html',
            url: $url,
            method: 'DELETE',
            data: {
              $cate_id
            },
            success: function() {
              swal(I18n.t('done_delete'),
                I18n.t('delete_desc'),
                'success');
              $($tr_id).fadeOut();
            }, error: function(jqXHR, exception) {
              sweetAlert(I18n.t('ops'),
                I18n.t("delete_cate_error"), 'error');
            }
          })
        } else {
          swal(I18n.t('canceled'), I18n.t('safe_data'), "error");
        }
      });
    return false;
  })

  $edit_cate_id = '';

  $('body').on('click', '.btn-edit-category', function(e) {
    e.preventDefault();
    $('#modal-edit-category').css('display', 'block')
    $url = $(this).attr('href')
    $edit_cate_id = $(this).attr('href').split('/')[3]
    $edit_tr_id = '#category_' + $edit_cate_id
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

  $('body').on('click', '.edit_category', function() {
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
          if (data == null) {
            sweetAlert(I18n.t('ops'),
              I18n.t("cate_may_exist"), 'error');
          } else {
            $('#modal-edit-category').fadeOut();
            $($edit_tr_id).replaceWith(data)
            $edit_tr_id = ''
          }
        },
        error: function(jqXHR, exception) {
          sweetAlert(I18n.t('ops'),
            I18n.t('create_cate_error'),
            'error');
        }
      })
    })
  });
})
