function delete_item(button, type) {
  $('body').on('click', button, function(e) {
    e.preventDefault();
    $type_id = $(this).attr('href').split('/')[3]
    $tr_id = '#' + type + '_' + $type_id
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
            $type_id
          },
          success: function() {
            swal(I18n.t('done_delete'),
              I18n.t('delete_desc'),
              'success');
            $($tr_id).fadeOut();
          },
          error: function(jqXHR, exception) {
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
}

function new_item(button, container, error_message) {
  $('body').on('click', button, function() {
    $form = $(this)
    $form.submit(function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      $.ajax({
        dataType: 'html',
        method: $form.attr('method'),
        url: $form.attr('action'),
        data: $form.serialize(),
        success: function(data) {
          if ($('#modal-new').length > 0) {
            $('#modal-new').fadeOut()
          }
          $new_row = $('' + data)
          if (data == null) {
            sweetAlert(I18n.t('ops'),
              I18n.t('data_existed'), 'error');
          }
          swal(I18n.t('good_job'), I18n.t('done_create'), "success")
          $(container + ' tr:last').after($new_row)
          $new_row.hide().fadeIn(3000)
          $form[0].reset()
        },
        error: function(jqXHR, exception) {
          sweetAlert(I18n.t('ops'),
            I18n.t(error_message), 'error');
        }
      })
    })
  })
}

$id = ''
$edit_tr_id = ''

function get_edit_data(button, type) {
  $('body').on('click', button, function(e) {
    e.preventDefault();
    $('#modal-edit').css('display', 'block')
    $url = $(this).attr('href')
    $id = $(this).attr('href').split('/')[3]
    $edit_tr_id = '#' + type + '_' + $id
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
}

function edit_item(form, error_message ) {
  $('body').on('click', form, function() {
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
              I18n.t("data_existed"), 'error');
          }
          swal(I18n.t('good_job'), I18n.t('done_edit'), "success")
          $('#modal-edit').fadeOut();
          $($edit_tr_id).replaceWith(data)
          $id = ''
          $edit_tr_id = ''
        },
        error: function(jqXHR, exception) {
          sweetAlert(I18n.t('ops'),
            I18n.t(error_message),
            'error');
        }
      })
    })
  });
}

