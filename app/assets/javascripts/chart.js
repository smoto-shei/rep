document.addEventListener('turbolinks:load', function() {
  var ctx = document.getElementById("myChart").getContext('2d');
  var myChart = new Chart(ctx, {
      type: 'bar',
      data: {
          labels: ['２月','３月','４月','5月','6月'],
          datasets: [{
              label: "肩",
              data: [3800,2000,1500,3000,1800],
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
});
