function chartMultipleLine(element, dataLabel, dataSet, dataPer) {
  var ctx = document.getElementById(element).getContext('2d');
  var myChart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: dataLabel,
      datasets: [{
        label: 'A',
        yAxisID: 'A',
        data: dataSet
      }, {
        label: 'B',
        yAxisID: 'B',
        data: dataPer
      }]
    },
    options: {
      scales: {
        yAxes: [{
          id: 'A',
          type: 'linear',
          position: 'left',
        }, {
          id: 'B',
          type: 'linear',
          position: 'right',
          ticks: {
            max: 1,
            min: 0
          }
        }]
      }
    }


    //type: 'bar',
    //data: {
    //  labels: dataLabel,
    //  datasets: [{
    //    label: 'Receita',
    //    data: dataSet,
    //    backgroundColor: [
    //      'rgba(8, 107, 172, 0.2)',
    //      'rgba(207, 207, 207, 0.2)',
    //    ],
    //    borderColor: [
    //      'rgba(8, 107, 172, 1)',
    //      'rgba(207, 207, 207, 1)',
    //    ],
    //    borderWidth: 1
    //  }]
    //},
    //options: {
    //  scales: {
    //    yAxes: [{
    //      gridLines: {
    //        display: false
    //      },
    //      display: false,
    //      id: 'A',
    //      type: 'linear',
    //      position: 'left',
    //      id: 'B',
    //      type: 'linear',
    //      position: 'right',
    //      ticks: {
    //        max: 1,
    //        min: 0
    //      }
    //    }],
    //    xAxes: [{
    //      display: true,
    //      gridLines: {
    //        display: false
    //      },
    //      barPercentage: 0.5
    //    }]
    //  },
    //  legend: {
    //    display: false
    //  },
    //  tooltips: {
    //    callbacks: {
    //      label: function (tooltipItem, data) {
    //        return fromNumberToPretty(tooltipItem.yLabel.toString())
    //      }
    //    }
    //  },
    //events: true,
    //tooltips: {
    //  enabled: true
    //},
    //hover: {
    //  animationDuration: 0
    //},
    //animation: {
    //  duration: 750,
    //  onComplete: function () {
    //    var chartInstance = this.chart,
    //      ctx = chartInstance.ctx;
    //    ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, Chart.defaults.global.defaultFontStyle, Chart.defaults.global.defaultFontFamily);
    //    ctx.textAlign = 'center';
    //    ctx.textBaseline = 'bottom';
    //    this.data.datasets.forEach(function (dataset, i) {
    //      var meta = chartInstance.controller.getDatasetMeta(i);
    //      meta.data.forEach(function (bar, index) {
    //        var data = dataset.data[index];
    //        data = fromNumberToPretty(data.toString());
    //        ctx.fillText(data, bar._model.x, bar._model.y - 5);
    //      });
    //    });
    //  }
    //}

  });

}