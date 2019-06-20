
document.addEventListener('turbolinks:load', function() {

  if (document.getElementById("user_search_form") != null){
    if (gon.formdata != undefined){

      var start = gon.formdata.user_body_experience_lteq
      var end = gon.formdata.user_body_experience_gteq
      $("#q_user_body_experience_lteq").val(start)
      $("#q_user_body_experience_gteq").val(end)
    }
  }
});
