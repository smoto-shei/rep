


document.addEventListener('turbolinks:load', function() {
  $(function(){
    $('.graph').mouseover(function(e){
      var url = `/users/${gon.user_id}/training_records/draw_graph`
      var part = $(this).attr('value');
      console.log(part)

      $.ajax({
        type: 'get',
        url: url,
        data: { part: part },
        datatype: 'json'
      })

      .done(function(data){
        console.log(data)
  // ------------------------------------------------------チャートの描画

          if (document.getElementById("myChart") != null){
            var ctx = $("#myChart"); //chartクラスをインスタンス化
            var total_load_chart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: gon.label, // x軸
                    datasets: [{                             // y軸
                        label: data.part,
                        data: data.data,
                        backgroundColor: 'rgba(255, 99, 132, 1.0)',
                        borderColor: 'rgba(255, 50, 132, 1.0)',
                        fill: false
                    }]
                },
                options: {
                    title:  {
                      display: true,
                    }
                }
            });
          }
          // ----------------------------------------------------------
        })
    });
  });
});