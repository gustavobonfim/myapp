function chartDoughnut(element, dataLabel, dataSet) {

  var ctx = document.getElementById(element).getContext('2d');
  var myChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
      labels: dataLabel,
      datasets: [
        {
          label: "Population (millions)",
          backgroundColor: ["#3e95cd", "#8e5ea2", "#3cba9f", "#e8c3b9", "#c45850"],
          data: dataSet
        }
      ]
    },
    options: {
    }
    //data: {
    //  labels: dataLabel,
    //  datasets: [{
    //    data: dataSet,
    //    backgroundColor: [
    //      'rgba(207, 207, 207, 0.2)',
    //      'rgba(8, 107, 172, 0.2)',
    //    ],
    //    borderColor: [
    //      'rgba(207, 207, 207, 1)',
    //      'rgba(8, 107, 172, 1)',
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
    //      ticks: {
    //        beginAtZero: true,
    //        callback: function (value, index, values) {
    //          value = fromNumberToPretty(value.toString())
    //          return 'R$ ' + value;
    //        }
    //      },
    //      display: false,
    //    }],
    //    xAxes: [{
    //      display: true,
    //      label: {
    //        display: false
    //      },
    //      gridLines: {
    //        display: false
    //      },
    //      barPercentage: 0.8
    //    }]
    //  },
    //  legend: {
    //    display: false
    //  },
    //  tooltips: {
    //    callbacks: {
    //      //label: function (tooltipItem, data) {
    //      //  
    //      //  //return "R$ " + Number(tooltipItem.value).toFixed(0).replace(/./g, function (c, i, a) {
    //      //  //  return i > 0 && c !== "," && (a.length - i) % 3 === 0 ? "." + c : c;
    //      //  //});
    //      //}
    //    }
    //  },
    //}
  });

}