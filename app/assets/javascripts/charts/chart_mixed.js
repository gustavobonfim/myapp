function chart2Bar(element, dataLabel, dataSet) {

  var ctx = document.getElementById(element).getContext('2d');
  var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: dataLabel,
      datasets: [{
        label: 'Distribuição',
        data: dataSet,
        backgroundColor: [
          'rgba(8, 107, 172, 0.2)',
          'rgba(207, 207, 207, 0.2)',
        ],
        borderColor: [
          'rgba(8, 107, 172, 1)',
          'rgba(207, 207, 207, 1)',
        ],
        borderWidth: 1
      }]
    },
    options: {
      scales: {
        yAxes: [{
          gridLines: {
            display: false
          },
          ticks: {
            beginAtZero: true,
            callback: function (value, index, values) {
              value = fromNumberToPretty(value.toString())
              return 'R$ ' + value;
            }
          },
          display: false,
        }],
        xAxes: [{
          display: true,
          gridLines: {
            display: false
          },
          barPercentage: 0.5
        }]
      },
      legend: {
        display: false
      },
      tooltips: {
        callbacks: {
          label: function (tooltipItem, data) {
            return fromNumberToPretty(tooltipItem.yLabel.toString())
          }
        }
      },
    }
  });

}