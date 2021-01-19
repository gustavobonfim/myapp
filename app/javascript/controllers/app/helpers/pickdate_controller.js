import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["1111", "2222", "3333", "4444", "5555", "6666", "7777", "8888", "9999"]

  connect() {
  }

  pick(element, options) {

    if (options.months == undefined) {
      options.months = false
    }
    if (options.years == undefined) {
      options.months = false
    }

    if (options.kind) {
      
      var currentDate = new Date();
      var currentYear = currentDate.getFullYear();
      var currentMonth = currentDate.getMonth() + 1

      if (options.range_year) {
        var year = options.range_year
      } else {
        var year = this.application.current_date.year
      }
      if (options.range_month) {
        var month = options.range_month
      } else {
        var month = this.application.current_date.month
      }


      if (options.kind == "monthly") {
        if (currentMonth > month && currentYear == year) {
          options.max = new Date(year, month, 0)
        } else {
          options.max = true
        }
        options.min = new Date(year, Number(month - 1), 1)
      } else if (options.kind == "yearly") {
        if (currentYear > year) {
          options.max = new Date(year, 12, 0)
        } else {
          options.max = true
        }
        options.min = new Date(year, 0, 1)
      }

    }

    element.pickdate({
      today: 'Hoje',
      ok: 'Selecionar',
      cancel: 'Fechar',
      closeOnCancel: true,
      closeOnSelect: true,
      container: 'body',
      containerHidden: 'body',
      firstDay: 0,
      format: 'dd/mmm/yyyy',
      formatSubmit: 'yyyy-mm-dd',
      hiddenPrefix: 'pickdate-input-stimulus',
      labelMonthNext: 'Próximo Mês',
      labelMonthPrev: 'Mês Anterior',
      labelMonthSelect: 'Escolha um mês do menu',
      labelYearSelect: 'Escolha um ano do menu',
      monthsFull: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
      monthsShort: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
      weekdaysFull: ['Domingo', 'Segunda-Feira', 'Terça-Feira', 'Quarta-Feira', 'Quinta-Feira', 'Sexta-Feira', 'Sábado'],
      weekdaysShort: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'],
      showMonthsFull: true,
      showMonthsShort: true,
      showWeekdaysFull: true,
      showWeekdaysShort: true,
      selectMonths: options.months,
      selectYears: options.years,
      max: options.max,
      min: options.min,
      onClose: function (e) {
      },
    })

    element.on('mousedown', function (e) {
      e.preventDefault();
      $(this).dblclick()
    })
  }


  pickWithLimit(element, kind, year, month) {

    var currentDate = new Date();
    var currentYear = currentDate.getFullYear();
    var currentMonth = currentDate.getMonth() + 1

    if (kind == "monthly") {
      if (currentMonth > month && currentYear == year) {
        var maxDate = new Date(year, month, 0)
      } else {
        var maxDate = true
      }
      var minDate = new Date(year, Number(month - 1), 1)
    } else if (kind == "yearly") {
      if (currentYear > year) {
        var maxDate = new Date(year, 12, 0)
      } else {
        var maxDate = true
      }
      var minDate = new Date(year, 0, 1)
    } else {
      var maxDate = false
      var minDate = false
    }

    element.pickdate({
      today: 'Hoje',
      ok: 'Selecionar',
      cancel: 'Fechar',
      closeOnCancel: true,
      closeOnSelect: true,
      container: 'body',
      containerHidden: 'body',
      firstDay: 0,
      format: 'dd/mmm/yyyy',
      formatSubmit: 'yyyy-mm-dd',
      hiddenPrefix: 'pickdate-input',
      labelMonthNext: 'Próximo Mês',
      labelMonthPrev: 'Mês Anterior',
      labelMonthSelect: 'Escolha um mês do menu',
      labelYearSelect: 'Escolha um ano do menu',
      monthsFull: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
      monthsShort: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
      weekdaysFull: ['Domingo', 'Segunda-Feira', 'Terça-Feira', 'Quarta-Feira', 'Quinta-Feira', 'Sexta-Feira', 'Sábado'],
      weekdaysShort: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'],
      showMonthsFull: true,
      showMonthsShort: true,
      showWeekdaysFull: true,
      showWeekdaysShort: true,
      selectMonths: true,
      selectYears: true,
      max: maxDate,
      min: minDate
    });

    element.on('mousedown', function (e) {
      e.preventDefault();
      $(this).dblclick()
    });
  }

  pickOnlyFuture(element, kind, year, month) {

    var currentDate = new Date();
    var currentYear = currentDate.getFullYear();
    var currentMonth = currentDate.getMonth() + 1

    if (kind == "monthly") {
      if (currentMonth > month && currentYear == year) {
        var maxDate = new Date(year, month, 0)
      } else {
        var maxDate = false
      }
      var minDate = 1
    } else if (kind == "yearly") {
      if (currentYear > year) {
        var maxDate = new Date(year, 12, 0)
      } else {
        var maxDate = false
      }
      // var minDate = new Date(year, 11, currentDate.getDate())
      var minDate = new Date()
    } else {
      var maxDate = false
      // var minDate = new Date(year, 11, currentDate.getDate())
      var minDate = new Date()
    }

    element.pickdate({
      today: 'Hoje',
      ok: 'Selecionar',
      cancel: 'Fechar',
      closeOnCancel: true,
      closeOnSelect: true,
      container: 'body',
      containerHidden: 'body',
      firstDay: 0,
      format: 'dd/mmm/yyyy',
      formatSubmit: 'yyyy-mm-dd',
      hiddenPrefix: 'pickdate-input',
      labelMonthNext: 'Próximo Mês',
      labelMonthPrev: 'Mês Anterior',
      labelMonthSelect: 'Escolha um mês do menu',
      labelYearSelect: 'Escolha um ano do menu',
      monthsFull: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
      monthsShort: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
      weekdaysFull: ['Domingo', 'Segunda-Feira', 'Terça-Feira', 'Quarta-Feira', 'Quinta-Feira', 'Sexta-Feira', 'Sábado'],
      weekdaysShort: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'],
      showMonthsFull: true,
      showMonthsShort: true,
      showWeekdaysFull: true,
      showWeekdaysShort: true,
      selectMonths: true,
      selectYears: true,
      max: maxDate,
      min: minDate
    });

    element.on('mousedown', function (e) {
      e.preventDefault();
      $(this).dblclick()
    });

  }

}