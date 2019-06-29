
document.addEventListener('turbolinks:load', function() {

  $(function(){
    // アバター画像のプレビューを表示させる
    $('.avatar_image_edit').change(function(){
      // 投稿された画像をfileオブジェクトで取得する
      var avatar_image = $('.avatar_image_edit').prop('files');

      // FileReaderのインスタンスを作成
      var reader = new FileReader();
      reader.onload =function(e){
        var url = e.target.result;
        // imageタグのsrcを変更
        $('#avatar_image').attr('src',url)
      }
      reader.readAsDataURL(avatar_image[0]);
    })

    // 誕生年のバリデーションを出す
    $('.birth_year_number').keyup(function(){
      if ( $(this).val() < 1900 || $(this).val() > 2019){
        $('.birth_year_fail').removeClass('hide');
      }
      else {
        $('.birth_year_fail').addClass('hide');
      }
    })

    // 身長のバリデーションを出す
    $('.height_number').keyup(function(){
      if ( $(this).val() < 100 || $(this).val() > 300){
        $('.height_fail').removeClass('hide');
      }
      else {
        $('.height_fail').addClass('hide');
      }
    })

    // 体重のバリデーション出す
    $('.weight_number').keyup(function(){
      if ( $(this).val() < 20 || $(this).val() > 350){
        $('.weight_fail').removeClass('hide');
      }
      else {
        $('.weight_fail').addClass('hide');
      }
    })

  });
});
