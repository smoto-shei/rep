document.addEventListener('turbolinks:load', function() {
  function add_set_html(count){
    html =`
<div class="d-flex flex-wrap mt-2">
  <div class="form_group w-25 text-center">
    <input class="form-control" step="0.5" type="number" name="training_record[menus_attributes][${count}][weight]" id="training_record_menus_attributes_${count}_weight">
  </div>
  <div class="d-flex w-25 align-items-end">
    <span class="ml-2 mb-2">kg ✖️</span>
  </div>
  <div class="form_group w-25 text-center">
    <input class="form-control" type="number" name="training_record[menus_attributes][${count}][rep]" id="training_record_menus_attributes_${count}_rep">
  </div>
  <div class="d-flex w-25 align-items-end">
    <span class="ml-2 mb-2">rep</span>
  </div>
</div>`
    $('#set-form').append(html);
  }
  function add_set_html_and_btn(){
    set_html = `
<div class="d-flex flex-wrap mt-3">
  <div class="w-25 text-center">
    <label for="training_record_menus_attributes_0_weight">重量</label>
    <input class="form-control" step="0.5" type="number" name="training_record[menus_attributes][0][weight]" id="training_record_menus_attributes_0_weight">
  </div>
  <div class="d-flex w-25 align-items-end">
    <span class="ml-2 mb-2">kg ✖️</span>
  </div>
  <div class="w-25 text-center">
    <label for="training_record_menus_attributes_0_rep">回数</label>
    <input class="form-control" type="number" name="training_record[menus_attributes][0][rep]" id="training_record_menus_attributes_0_rep">
  </div>
  <div class="d-flex w-25 align-items-end">
    <span class="ml-2 mb-2">rep</span>
  </div>
</div>`
    set_btn =`
<div class="my-3">
  <div class="btn btn-outline-primary btn-sm" id="add-set">
    セット追加
  </div>
</div>`
    $('#set-form').append(set_html);
    $('#set-form').after(set_btn);
  }
  function add_time_form(){
    html = `
<div class="d-flex flex-wrap mt-3 align-items-center">
  <span class="mx-2">継続時間</span>
  <input class="form-control w-50" type="number" name="training_record[menus_attributes][0][time]" id="training_record_menus_attributes_0_time">
  <span class="mx-2">分</span>
</div>`
    $('#set-form').append(html);
  }

  $('#new_training_record').on('click','#add-set',function(){
    add_set_html($('#set-form').children().length);
  })


  $('.day').on('click',function(){
    var date = $(this).children('div').attr('id');
    var pathname = location.pathname + '/records_update';
    $.ajax({
      type: 'GET',
      url: pathname,
      data: { date: date },
      datatype: 'json'
    }).done(function(data){
      $('#day_records').empty();
      $('#day_records').append(data);
      $('#training_record_date').val(date);
    }).fail(function(){
      alert('通信に失敗しました');
    })
  })

  $('#training_record_part').change(function(){
    var selected_part = $(this).val();
    $('#set-form').empty();
    $('#add-set').remove();
    switch(selected_part){
      case "":;
        break;
      case "有酸素":
        add_time_form();
        break;
      default:
        add_set_html_and_btn();
        break;
    }

  })

  $('#training_records').on('click', '.record_delete_btn', function(){
    var url = location.pathname + "/training_records/" + $(this).attr('value');
    var li_obj = $(this).parent();
    $.ajax({
      type: 'DELETE',
      url: url,
      datatype: 'json'
    }).done(function(data){
      li_obj.remove();
    }).fail(function(){
      alert('通信に失敗しました')
    })
  })
});
