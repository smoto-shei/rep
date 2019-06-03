$(function(){
  $('#edit_body').on('click',function(){
    $('.body_modal').css('display', 'block');
    $('.overlay').css('display', 'block');    $('html').addClass('modal_open');
  });

  $('.close_button').on('click',function(){
    $('.body_modal').css('display', 'none');
    $('.overlay').css('display', 'none');
    $('html').removeClass('modal_open');
  })
});