document.addEventListener('turbolinks:load', function() {

  function add_set_html(count){
    html =
          `<div class="d-flex flex-wrap mt-2">
            <div class="form_group w-25 text-center">
              <input class="form-control" step="0.5" type="number" max="999.5" min="0.0" name="training_record[menus_attributes][${count}][weight]" id="training_record_menus_attributes_${count}_weight">
            </div>
            <div class="d-flex w-25 align-items-end">
              <span class="ml-2 mb-2">kg ✖️</span>
            </div>
            <div class="form_group w-25 text-center">
              <input class="form-control" type="number" max="999" min="0" name="training_record[menus_attributes][${count}][rep]" id="training_record_menus_attributes_${count}_rep">
            </div>
            <div class="d-flex w-25 align-items-end">
              <span class="ml-2 mb-2">rep</span>
            </div>
          </div>`

    $('#set-form').append(html);
  }

  function add_set_html_and_btn(){
    set_html =
              `<div class="d-flex flex-wrap mt-3">
                <div class="w-25 text-center">
                  <label for="training_record_menus_attributes_0_weight">重量</label>
                  <input class="form-control" step="0.5" type="number" max="999.5" min="0.0" name="training_record[menus_attributes][0][weight]" id="training_record_menus_attributes_0_weight">
                </div>
                <div class="d-flex w-25 align-items-end">
                  <span class="ml-2 mb-2">kg ✖️</span>
                </div>
                <div class="w-25 text-center">
                  <label for="training_record_menus_attributes_0_rep">回数</label>
                  <input class="form-control" type="number" max="999", min="0" name="training_record[menus_attributes][0][rep]" id="training_record_menus_attributes_0_rep">
                </div>
                <div class="d-flex w-25 align-items-end">
                  <span class="ml-2 mb-2">rep</span>
                </div>
              </div>`

    set_btn =
              `<div class="my-3">
                <div class="btn btn-outline-primary btn-sm" id="add-set">
                  セット追加
                </div>
                <div class="btn btn-outline-danger btn-sm ml-3" id="remove-set">
                  セット削除
                </div>
              </div>`

    $('#set-form').append(set_html);
    $('#set-form').after(set_btn);
  }

  function add_time_form(){
    html =
          `<div class="d-flex flex-wrap mt-3 align-items-center">
            <span class="mx-2">継続時間</span>
            <input class="form-control w-50" type="number" max="1440" min="0" name="training_record[menus_attributes][0][time]" id="training_record_menus_attributes_0_time">
            <span class="mx-2">分</span>
          </div>`

    $('#set-form').append(html);
  }

  function appendExercise(exercise){
    html =
          `<div class="records_boxes">${exercise.ja_name}</div>`

    $('#exercise_search_result').append(html);
  }

  $('#new_training_record').on('click','#add-set',function(){
    add_set_html($('#set-form').children().length);
  })

  $('#new_training_record').on('click','#remove-set',function(){
    if($('#set-form').children().length > 1){
      $('#set-form').children().last().remove();
    }
  })

  $('.day').on('click',function(){
    var date = $(this).children('div').attr('id');
    var that = $(this)
    var pathname = location.pathname + '/records_update';
    $('.day').removeClass('checked');
    $.ajax({
      type: 'GET',
      url: pathname,
      data: { date: date },
      datatype: 'json'
    }).done(function(data){
      that.addClass('checked');
      $('#day_records').html(data);
      $('#training_record_date').val(date);
      $('#training_record_date').attr('value',date);
    }).fail(function(){
      alert('通信に失敗しました');
    })
  })

  $('#training_record_part').change(function(){
    var selected_part = $(this).val();
    $('#set-form').empty();
    $('#add-set').remove();
    $('#remove-set').remove();
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

  // レコードの削除
  $('#training_records').on('click', '.record_delete_btn', function(){
    var url = location.pathname + "/training_records/" + $(this).attr('value');
    var li_obj = $(this).parent();
    var day = '#records_' + $('#training_record_date').val();

    $.ajax({
      type: 'DELETE',
      url: url,
      datatype: 'json'
    })
    .done(function(day_html){
      li_obj.remove();
      $(day).html(day_html);
    })
    .fail(function(){
      alert('通信に失敗しました')
    })
  })

  $('#new_training_record').on('ajax:success', function(event) {
    $('#new_training_record')[0].reset();
    $('#add-set').remove();
    $('#remove-set').remove();
    $('#set-form').empty();
  });

  $('#new_training_record').on('ajax:error', function(event) {
    alert("通信に失敗しました");
  });

  // インクリメンタルサーチ
  $('#training_record_exercise').on('keyup', function(){
    var input = $('#training_record_exercise').val();
    $('#exercise_search_result').empty();

    if(input){
      $.ajax({
        type: 'GET',
        url: '/exercises',
        data: { keyword: input },
        datatype: 'json'
      })
      .done(function(exercises){
        if(exercises.length !== 0){
          exercises.forEach(function(exercise){
            appendExercise(exercise);
          })
        }
      })
      .fail(function(){
        alert('インクリメンタルサーチに失敗しました');
      })
    }
  })

  $('#exercise_search_result').on('click','.records_boxes',function(){
    selected = $(this).text();
    $('#training_record_exercise').val(selected);
    $('#exercise_search_result').empty();
  })

  $('#day_records').on('click','.remove_hidden_class',function(){
    $(this).next().removeClass('hidden');
    $(this).addClass('hidden');
    $(this).nextAll('ul').removeClass('hidden');
  })
  $('#day_records').on('click','.add_hidden_class',function(){
    $(this).prev().removeClass('hidden');
    $(this).addClass('hidden');
    $(this).nextAll('ul').addClass('hidden');
  })
});
