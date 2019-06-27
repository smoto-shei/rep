document.addEventListener('turbolinks:load', function() {

    // モーダル出す
    $('body').on('click','.show_modal',function(){
      $('.body_modal').css('display', 'block');
      $('.overlay').css('display', 'block');
      $('html').addClass('modal_open');
      var target = $(this).attr('value');
      $(target).removeClass('hide');
    });

    // モーダル隠す
    $('.body_modal').on('click','.close_button',function(){
      $('.body_modal').css('display', 'none');
      $('.overlay').css('display', 'none');
      $('html').removeClass('modal_open');
      var target = $(this).attr('value');
      $(target).addClass('hide');
    });

  // 記事削除ボタン押したときのモーダル作成
  $(".delete_btn").on('click',function(){
    var delete_path = location.pathname + '/' + $(this).attr('id');
    $('#delete-submit').attr('href',delete_path)
  })

  // 記事コメント編集ボタン押した時のモーダル作成。追加要素のためセレクタとクリックボタンを分けている。
  $("#user_images_box").on('click','.edit-comment',function(){
    var image_id = $(this).attr('id');
    var url = location.pathname + '/' + image_id + '/edit';
    $.ajax({
      url: url,
      type: 'GET',
      data: {id: image_id},
      dataType: 'html',
      processData: false,
      contentType: false
    })
    .done(function(html){
      $('#html_to_modal_box').html(html);
    })
    .fail(function(){
      alert('通信に失敗しました');
    })
  })

})