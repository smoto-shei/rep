
document.addEventListener('turbolinks:load', function() {

  $(function() {

    $('.slider').slick({
      prevArrow:'<i class="fa fa-angle-left arrow arrow-left"></i>',
      nextArrow:'<i class="fa fa-angle-right arrow arrow-right"></i>',
      autoplay: true,
      autoplaySpeed: 4,
      speed: 8000
    });

  });
});