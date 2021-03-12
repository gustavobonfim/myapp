function chart1HorizontalBar(element, dataSet, dataDiff, dataComp) {

  var ctx = document.getElementById(element).getContext('2d');
  var myChart = new Chart(ctx, {
    type: 'horizontalBar',
    data: {
      // labels: dataLabel,
      datasets: [{
        label: 'Receita',
        data: dataSet,
        backgroundColor: [
          'rgba(0, 107, 172, 0.2)',
        ],
        borderColor: [
          'rgba(0, 107, 172, 1)',
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
          barPercentage: 0.4,
        }],
        xAxes: [{
          gridLines: {
            display: false
          },
          barPercentage: 0.4,
          display: false
        }]
      },
      legend: {
        display: false
      },
      tooltips: {
        callbacks: {
          label: function (tooltipItem, data) {
            return "R$ " + Number(tooltipItem.yLabel).toFixed(0).replace(/./g, function (c, i, a) {
              return i > 0 && c !== "," && (a.length - i) % 3 === 0 ? "." + c : c;
            });
          }
        }
      },
      events: false,
      tooltips: {
        enabled: true
      },
      hover: {
        animationDuration: 0
      },
      animation: {
        duration: 750,
        onComplete: function () {
          var chartInstance = this.chart,
            ctx = chartInstance.ctx;
          ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, Chart.defaults.global.defaultFontStyle, Chart.defaults.global.defaultFontFamily);
          ctx.textAlign = 'center';
          ctx.textBaseline = 'bottom';
          this.data.datasets.forEach(function (dataset, i) {
            var meta = chartInstance.controller.getDatasetMeta(i);
            meta.data.forEach(function (bar, index) {
              var data = dataset.data[index];
              data = fromNumberToPretty(data.toString());
              ctx.fillText(data, bar._model.x - 40, bar._model.y + 5);
            });
          });
        }
      }
    }
  });

}