$(document).on('turbolinks:load', function() {

  $('body').on('click', '.show-search', function(e) {
    e.preventDefault();
    $('.search').fadeIn(1000)
    return false;
  })

  $('.welcome-msg').fadeIn(2000, function() {
    $('.story-img').fadeIn(1500, function() {
      $('.story-head').fadeIn(1500, function() {
        $('.story-para').fadeIn(1500);
      });
    })
  });

  $('.count').each(function() {
    $(this).prop('Counter', 0).animate({
      Counter: $(this).text()
    }, {
      duration: 6000,
      easing: 'swing',
      step: function(now) {
        $(this).text(Math.ceil(now));
      }
    });
  });

  $('.close').click(function() {
    $('#modal-new-book').fadeOut();
    $('#modal-edit-book').fadeOut();
    $('#modal-new-request').fadeOut();
    $('#modal-edit-request').fadeOut();
    $('#modal-edit-review').fadeOut();
    $('#modal-edit-comment').fadeOut();
  })

  $('body').click(function(event) {
    if (event.target.id == $('#modal-new-book').attr('id')) {
      $('#modal-new-book').fadeOut();
      $('#modal-edit-book').fadeOut();
      $('#modal-new-request').fadeOut();
      $('#modal-edit-request').fadeOut();
      $('#modal-edit-review').fadeOut();
      $('#modal-edit-comment').fadeOut();
    }
    $('#search').fadeOut();
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
        $btn.removeClass('btn-fav').addClass('btn-unfav')
        $btn.css('background-position', '-2800px 0')
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
        $btn.removeClass('btn-unfav').addClass('btn-fav')
        $btn.css('background-position', '0, 0');
        $btn.attr('href', $add_url)
        $('.favorited-count').html($fav_count - 1)
      }
    })
    return false;
  });

  $('.heart[data-method="delete"]').css('background-position', '-2800px, 0');

  $('#btn-new-request').click(function(e) {
    e.preventDefault()
    $('#modal-new-request').css('display', 'block')
    $.ajax({
      dataType: 'html',
      url: 'requests/new',
      method: 'get',
      success: function(data) {
        $('.modal-body').html(data)
      },
      error: function(jqXHR, exception) {

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
        },
        error: function(jqXHR, exception) {
          sweetAlert(I18n.t('ops'),
            I18n.t('create_request_error'),
            'error');
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
    $req_id = $(this).attr('href').split('/')[2]
    $tr_id = '#request_' + $req_id
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
              $($tr_id).fadeOut();
            }
          })
        } else {
          swal(I18n.t('canceled'), I18n.t('safe_data'), "error");
        }
      });
    return false;
  })

  $fill_star = $('input[name="review[rate]"]');

  $('.starrr').starrr();

  $fill_star.hide();
  $('#stars').on('starrr:change', function(e, value) {
    e.preventDefault();
    $fill_star.val(value);
  });

  $(function() {
    $('.review-item').slice(0, 4).show();
    $('#loadMore').on('click', function(e) {
      e.preventDefault();
      $('.review-item:hidden').slice(0, 4).slideDown();
      if ($('.review-item:hidden').length == 0) {
        $('#loadMore').fadeOut('slow');
      }
      $('html,body').animate({
        scrollTop: $(this).offset().top
      }, 1500);
    });
  });

  $('a[href="#top"]').click(function() {
    $('body,html').animate({
      scrollTop: 0
    }, 600);
    return false;
  });

  $(window).scroll(function() {
    if ($(this).scrollTop() > 50) {
      $('.totop').fadeIn();
      $('.totop a').fadeIn();
    } else {
      $('.totop').fadeOut();
      $('.totop a').fadeOut();
    }
  });

  function isEmpty(el) {
    return !$.trim(el.html())
  }

  if (isEmpty($('.no-rating'))) {
    $('.no-rating').hide();
  }
  $('[data-toggle="tooltip"]').tooltip();

  $(".btn-pref .btn").click(function() {
    $(".btn-pref .btn").removeClass("btn-primary").addClass("btn-default");
    $(this).removeClass("btn-default").addClass("btn-primary");
  });

  $('body').on('click', '#new_relationship', function(e) {
    $form = $(this);
    $url = window.location.href;
    $follower_count = parseInt($('.follower-count').text())
    $form.submit(function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      $.ajax({
        url: $form.attr('action'),
        method: $form.attr('method'),
        dataType: 'html',
        data: $form.serialize(),
        success: function(data) {
          $('#follow_form').html(data)
          $.ajax({
            url: $url + '/followers',
            method: 'get',
            success: function(d) {
              $('.follist').hide().fadeIn(1000).html(d)
              $('.follower-count').html($follower_count + 1)
            }
          })
        }
      })
    })
  });

  $('body').on('click', '.edit_relationship', function() {
    $form = $(this);
    $url = window.location.href;
    $follower_count = parseInt($('.follower-count').text())
    $form.submit(function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      $.ajax({
        url: $form.attr('action'),
        method: $form.attr('method'),
        dataType: 'html',
        data: $form.serialize(),
        success: function(data) {
          $('#follow_form').html(data)
          $('.follower-count').html($follower_count - 1)
          $.ajax({
            url: $url + '/followers',
            method: 'get',
            success: function() {
              $('.fol-item').first().fadeOut();
            }
          })
        }
      })
    })
  });

  $('body').on('click', '.btn-edit-review', function(e) {
    e.preventDefault();
    $('#modal-edit-review').css('display', 'block')
    $url = $(this).attr('href')
    $review_id = $url.split('/')[2]
    $book_id = window.location.href.split('/')[4]
    $.ajax({
      dataType: 'html',
      url: $url,
      method: 'get',
      data: {
        book_id: $book_id,
        review_id: $review_id
      },
      success: function(data) {
        $('.edit-modal-body').html(data);
        $('input[name="review[rate]"]').hide();
        $('.edit-starrr').starrr({
          rating: $('.edit-star').val(),
          change: function(e, value) {
            e.preventDefault();
            $('.edit-star').val(value)
          }
        })
      }
    });
    return false
  })

  $('body').on('click', '.edit_view', function() {
    $form = $(this);
    $form.submit(function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
    })
  });

  $('body').on('click', '.btn-new-comment', function(e) {
    e.preventDefault();
    $btn = $(this)
    $url = $(this).attr('href')
    $review_id = $(this).closest('li').attr('id').split('_')[1]
    $.ajax({
      url: $url,
      method: 'get',
      dataType: 'html',
      data: {
        review_id: $review_id
      },
      success: function(data) {
        $box = $btn.siblings('.comment-box')
        $box.html(data)
        $box.children().find('input[name="comment[review_id]"]').val($review_id);
      }
    })
    return false;
  })

  $('body').on('click', '#new_comment', function() {
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
          $form.closest('li').find('ul').prepend(data).hide().fadeIn(1000)
          $form[0].reset();
        },
        error: function(jqXHR, exception) {
          sweetAlert(I18n.t('ops'),
            I18n.t('create_comment_error'),
            'error');
        }
      })
    })
  });

  $('body').on('click', '.btn-edit-comment', function(e) {
    e.preventDefault();
    $('#modal-edit-comment').css('display', 'block')
    $url = $(this).attr('href')
    $comment_id = $url.split('/')[2]
    $.ajax({
      dataType: 'html',
      url: $url,
      method: 'get',
      data: {
        id: $comment_id,
      },
      success: function(data) {
        $('.edit-modal-body').html(data);
      }
    });
    return false
  })

  $('body').on('click', '.btn-delete-comment', function(e) {
    e.preventDefault();
    if (confirm(I18n.t('confirm_delete'))) {
      $cmt_id = $(this).attr('href').split('/')[2]
      $li_id = '#comment_' + $cmt_id
      $.ajax({
        dataType: 'html',
        url: $(this).attr('href'),
        method: 'DELETE',
        success: function() {
          $($li_id).fadeOut();
        }
      })
    } else {

    }
    return false;
  })

  $('body').on('click', '.btn-load-more', function(e) {
    e.preventDefault();
    $btn = $(this)
    $.ajax({
      url: $btn.attr('href'),
      method: 'get',
      success: function(data) {
        $('.activity-feed').html(data)
        $btn.hide()
      }
    })
    return false;
  })

  $return_like_id = 0;
  $like_form = ""
  $('body').on('click', '#new_like', function() {
    $form = $(this);
    $like_form = $form
    $form.submit(function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      $.ajax({
        url: $form.attr('action'),
        method: $form.attr('method'),
        dataType: 'json',
        data: $form.serialize(),
        success: function(data) {
          console.log(data.id)
          $return_like_id = data.id
          html = '<a class="btn btn-default" id="btn-unlike" href="/likes/' + $return_like_id + '"' + '>unlike</a>'
          $like_form.hide()
          $like_form.closest('.like').prepend(html)
        }
      })
    })
  });

  $edit_form = ""
  $('body').on('click', '.edit_like', function() {
    $form = $(this);
    $edit_form = $form
    $form.submit(function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      $.ajax({
        url: $form.attr('action'),
        method: $form.attr('method'),
        dataType: 'html',
        data: $form.serialize(),
        success: function() {
          html = '<a class="btn btn-default" id="btn-unlike" href="/likes/' + $return_like_id + '"' + '>unlike</a>'
          $edit_form.hide()
          $edit_form.closest('.like').html(html)
        }
      })
    })
  });

  $('body').on('click', '#btn-unlike', function(e) {
    $btn = $(this)
    e.preventDefault()
    $.ajax({
      url: $btn.attr('href'),
      method: 'delete',
      success: function() {
        $btn.hide()
        $like_form.fadeIn(1000)
      }
    })
    return false;
  })
})
