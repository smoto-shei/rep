document.addEventListener('turbolinks:load', function() {

  if (document.getElementById("myChart") != null){
    var ctx = $("#myChart"); //chartクラスをインスタンス化
    var total_load_chart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: gon.label, // x軸
            datasets: [{                             // y軸
                label: "肩",
                data: gon.data,
                backgroundColor: 'rgba(255, 99, 132, 1.0)',
                borderColor: 'rgba(255, 50, 132, 1.0)',
                fill: false
            }]
        },
        options: {
            title:  {
              display: true,
              text: "Training Record"
            }
        }
    });
  }
});
