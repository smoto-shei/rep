
document.addEventListener('turbolinks:load', function() {

// ---------------------------------------------------- 一回目空チャート作成
  if (document.getElementById("myChart") != null){
    var ctx = $("#myChart");
  load_chart = new Chart(ctx);

  var url = `/users/${gon.user_id}/training_records/draw_graph`
  var part = 'Total';
  var unit = $('input[name="unit"]').val();

  $.ajax({
    type: 'get',
    url: url,
    data: {
      part: part,
      unit: unit
    },
    datatype: 'json'
  })

  .done(function(data){
      draw_graph(data);
      data_label();
    })
  }

// ----------------------------------------------- 二度目以降analytic ページのチャート描写
  $(function(){
    $('.graph').on('click',function(e){
      var url = `/users/${gon.user_id}/training_records/draw_graph`
      var part = $(this).attr('value');
      var unit = $('input[name="unit"]:checked').val();

      $.ajax({
        type: 'get',
        url: url,
        data: {
          part: part,
          unit: unit
         },
        datatype: 'json'
      })

      .done(function(data){
        update_chart(data);
        })
    });
  });


})

// ------------------------------------------------------チャートの描画
function draw_graph(data){
  var ctx = $("#myChart");
  load_chart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: gon.label, // x軸のラベル
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
        fontSize: 22,                  //フォントサイズ
        text: data.part
      },
      scales: {                          //軸設定
        yAxes: [{                      //y軸設定
            display: true,             //表示設定
            scaleLabel: {              //軸ラベル設定
                display: true,          //表示設定
                // labelString: 'Kg',  //ラベル
                fontSize: 18               //フォントサイズ
            },
            ticks: {                      //最大値最小値設定
                suggestedMax: 100,
                min: 0,                   //最小値
                fontSize: 18,             //フォントサイズ
                stepSize: 0               //軸間隔
            },
        }],
        xAxes: [{                         //x軸設定
            display: true,                //表示設定
            barPercentage: 0.7,           //棒グラフ幅
            categoryPercentage: 0.4,      //棒グラフ幅
            scaleLabel: {                 //軸ラベル設定
                display: true,             //表示設定
                labelString: 'Month',  //ラベル
                fontSize: 18
            },
            ticks: {
                fontSize: 18             //フォントサイズ
            },
        }],

      },
      // layout: {                             //レイアウト
      //   padding: {                          //余白設定
      //       left: 0,
      //       right: 100,
      //       top: 0,
      //       bottom: 0
      //   }
      // }
    },

  });
}
// ----------------------------------------------------------
function update_chart(data){
  // load_chart.options.title.text = data.part
  load_chart.data.datasets[0].label = data.part
  load_chart.data.datasets[0].data = data.data
  load_chart.data.labels = data.x_label
  load_chart.options.title.text = data.part
  load_chart.update();
}


//------------------------------------------------------------- データラベルの表示
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

            var fontSize = 14;
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
