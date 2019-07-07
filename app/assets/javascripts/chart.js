
document.addEventListener('turbolinks:load', function() {

// ----------------------一回目のグラフ作成-----------------------------
  if (document.getElementById("myChart") !== null){

    var ctx = $("#myChart");
    load_chart = new Chart(ctx);

    var user_id = location.pathname.split('/')[2];
    var part = 'Total';
    var unit = $('input[name="unit"]').val();
    var url = `/users/${user_id}/training_records/draw_graph`
    var y_label = '(kg)'

    $.ajax({
      type: 'get',
      url: url,
      data: {
        part: part,
        unit: unit,
        user_id: user_id,
        y_label: y_label
      },
      datatype: 'json'
    })
    .done(function(data){
      draw_graph(data);
      data_label();
    })
    .fail(function(){
      alert('データの取得に失敗しました')
    })

  }
  // ---------------------二度目以降のチャート描写------------------------
  $(function(){
    $('.chart_btn').change(function(){
      var user_id = location.pathname.split('/')[2];
      var url = `/users/${user_id}/training_records/draw_graph`
      var part = $("[name=check_part]:checked").val(); // タブルクォテーションじゃないとエラーになる.
      var unit = $('input[name="unit"]:checked').val();
      if( part == '有酸素'){
        var y_label = '(minutes)'
      } else{
        var y_label = '(kg)'
      }

      $.ajax({
        type: 'get',
        url: url,
        data: {
          part: part,
          unit: unit,
          y_label: y_label
         },
        datatype: 'json'
      })
      .done(function(data){
        update_chart(data);
      })
      .fail(function(){
        alert('データの取得に失敗しました')
      })
    });
  });

})

// --------------------以下メソッド--------------------------

// --------------------グラフの描画--------------------------
function draw_graph(data){
  var ctx = $("#myChart");

  load_chart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: data.x_label, // x軸のラベル
      datasets: [{
        label: data.part,
        data: data.data,
        backgroundColor: 'rgba(255, 99, 132, 1.0)',
        borderColor: 'rgba(255, 50, 132, 1.0)',
        fill: false
      }]
    },
    options: {
      responsive: true,                  //グラフ自動設定
      legend: {                          //凡例設定
          display: false                 //表示設定
      },
      title:  {
        display: true,
        fontSize: 15,
        position: 'top',
        padding: 10,
        text: data.part
      },
      scales: {                          //軸設定
        yAxes: [{                      //y軸設定
            display: true,             //表示設定
            scaleLabel: {              //軸ラベル設定
                display: true,          //表示設定
                labelString: data.y_label,  //ラベル
                fontSize: 12               //フォントサイズ
            },
            ticks: {                      //最大値最小値設定
                suggestedMax: 100,
                min: 0,                   //最小値
                fontSize: 12,             //フォントサイズ
                stepSize: 0               //軸間隔
            },
        }],
        xAxes: [{                         //x軸設定
            display: true,                //表示設定
            barPercentage: 0.7,           //棒グラフ幅
            categoryPercentage: 0.4,      //棒グラフ幅
            scaleLabel: {                 //軸ラベル設定
                display: false,             //表示設定
                labelString: 'Month',  //ラベル
                fontSize: 12
            },
            ticks: {
                fontSize: 12            //フォントサイズ
            },
        }],

      },
    },

  });
}

// -------------------グラフの更新-------------------------------
function update_chart(data){
  load_chart.data.datasets[0].label = data.part
  load_chart.data.datasets[0].data = data.data
  load_chart.data.labels = data.x_label
  load_chart.options.title.text = data.part
  a = load_chart.options.scales.yAxes[0].scaleLabel.labelString = data.y_label
  load_chart.update();
}

//--------------------データラベルの表示--------------------------
function data_label(){
  Chart.plugins.register({
    afterDatasetsDraw: function (chart, easing) {
        // To only draw at the end of animation, check for easing === 1
      var ctx = chart.ctx;

      chart.data.datasets.forEach(function (dataset, i) {
        var meta = chart.getDatasetMeta(i);
        if (!meta.hidden) {
          meta.data.forEach(function (element, index) {
            // Draw the text in black, with the specified font
            ctx.fillStyle = 'rgb(0, 0, 0)';

            var fontSize = 12;
            var fontStyle = 'normal';
            var fontFamily = 'Helvetica Neue';
            ctx.font = Chart.helpers.fontString(fontSize, fontStyle, fontFamily);

            // Just naively convert to string for now
            var dataString = dataset.data[index].toString();

            // Make sure alignment settings are correct
            ctx.textAlign = 'center';
            ctx.textBaseline = 'middle';

            var padding = 5;
            var position = element.tooltipPosition();
            ctx.fillText(dataString, position.x, position.y - (fontSize / 2) - padding);
          });
        }
      });
    }
  });
}
//----------------------------------------------------------------
