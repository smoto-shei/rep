
document.addEventListener('turbolinks:load', function() {

  $(function(){

    // モーダルを出す、隠す
    $('#edit_body').on('click',function(){
      $('.body_modal').css('display', 'block');
      $('.overlay').css('display', 'block');    $('html').addClass('modal_open');
    });

    $('.close_button').on('click',function(){
      $('.body_modal').css('display', 'none');
      $('.overlay').css('display', 'none');
      $('html').removeClass('modal_open');
    });


    // 誕生年のバリデーションを出す
    $('.birth_year_number').keyup(function(){
      if ( $(this).val() < 1900 || $(this).val() > 2019){
        $('.birth_year_fail').removeClass('hide');
      } else {
        $('.birth_year_fail').addClass('hide');
      }
    })

    // 身長のバリデーションを出す
    $('.height_number').keyup(function(){
      if ( $(this).val() < 100 || $(this).val() > 300){
        $('.height_fail').removeClass('hide');
      } else {
        $('.height_fail').addClass('hide');
      }
    })

    // 体重のバリデーション出す
    $('.weight_number').keyup(function(){
      if ( $(this).val() < 20 || $(this).val() > 350){
        console.log(200)
        $('.weight_fail').removeClass('hide');
      } else {
        $('.weight_fail').addClass('hide');
      }
    })

  });
});
