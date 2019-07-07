document.addEventListener('turbolinks:load', function() {

  send_file_obj = {}
  var stock_index = []

  // プレビューの表示、送信ファイル作成
  function make_preview(send_img_cnt,filelist){

    var num = stock_index.length

    $.each(filelist, function(i,file){
      stock_index.push(i)
      if (send_img_cnt > 0){
        var i = i + num
      }
      send_file_obj[i] = file
      // ファイルリーダーのインスタンスを作成する
      var reader = new FileReader();
      // ファイルの読み込みが成功した時の記述
      reader.onload =function(e){
        var url = e.target.result;
        // imageをデータとして取得する
        var preview =
                      `<li data-id='${i}'>
                        <figure class="image-preview">
                          <img src="${url}" class="image-preview">
                        </figure>
                        <div class="preview-btn">
                          <div class="preview-delete btn btn-outline-danger btn-sm px-4">削除</a>
                        </div>
                      </li>`

        $('#image-list-before').before(preview);
        change_drop_box_size();

      }
      reader.readAsDataURL(file);
    })
  }

  //画像プレビューの数に合わせてドロップボックスのサイズ変更
  function change_drop_box_size(){
    var preview_num = $('#image-list').children().length - 1;
    var target = $('#image-drop-box')
    if (preview_num === 0 || preview_num === 5){
      target.css('width','850');
      target.removeClass("hidden");
    } else if (preview_num === 1 || preview_num === 6){
      target.css('width','680');
      target.removeClass("hidden");
    } else if (preview_num === 2 || preview_num === 7){
      target.css('width','510');
      target.removeClass("hidden");
    } else if (preview_num === 3 || preview_num === 8){
      target.css('width','340');
      target.removeClass("hidden");
    } else if (preview_num === 4 || preview_num === 9){
      target.css('width','170');
      target.removeClass("hidden");
    } else if (preview_num === 10){
      target.addClass("hidden");
    } else {
      target.removeClass("hidden");
    }
  };

  // プレビューの削除
  $('#image-list').on('click','.preview-delete',function(){
    var preview_box = $(this).parent().parent()
    var i = preview_box.attr('data-id');
    preview_box.remove();
    delete send_file_obj[i]
    change_drop_box_size();
  });
  // -------------------------------------------------------------------
  // 発火（D&D）
  $('#image-drop-box').on('dragover',function(e){
    e.preventDefault();
  })

  $('#image-drop-box').on('drop',function(e){
    e.preventDefault();
    var image_filelist = e.originalEvent.dataTransfer.files;
    var file_count = image_filelist.length
    var send_img_cnt = Object.keys(send_file_obj).length

    if ( file_count != 0 && file_count + send_img_cnt <= 10){
      make_preview(send_img_cnt,image_filelist);
    }
  })

  // --------------------------------------------------------
  // 発火（File_field）
  $('#image_user_image').change(function(){
    // 投稿された画像をfileオブジェクトで取得する
    var image_filelist = $('#image_user_image').prop('files');
    var file_count = image_filelist.length;
    var send_img_cnt = Object.keys(send_file_obj).length;

    if ( file_count != 0 && file_count + send_img_cnt <= 10){
      make_preview(send_img_cnt,image_filelist);
      $('#image_user_image').val('');
    }
  })
// -----------------------------------------------------------
// formDataにプレビュー画像を入力してajax送信
  $("#image-submit, #image-edit").on('click',function(event){
    event.preventDefault();
    var formdata = new FormData($('#image-create').get(0));
    $.each(send_file_obj,function(index,file){
      formdata.append('image[user_image][]',file)
    })
    var url = $('#image-create').attr("action")
    var type = $('#image-create').attr("method")

    $.ajax({
      url: url,
      type: type,
      data: formdata,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(){
      location.href = location.href;
    })
    .fail(function(){
      alert("通信に失敗しました");
    })
  })
})