import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["1111", "2222", "3333", "4444", "5555", "6666", "7777", "8888", "9999"]

  connect() {
  }

  transformPrettyDate(date) {
    var all_months = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez']

    if (date != null && date != undefined && date != ``) {
      var day = date.getDate()
      var month = date.getMonth()
      var year = date.getFullYear()

      month = all_months[month]
      if (day < 10) {
        day = `0${day}`
      }

      return `${day}/${month}/${year}`
    }
  }

  transformNumberDate(date) {
    if (date != null && date != undefined && date != ``) {
      var day = Number(date.split("/")[0])
      var month = Number(date.split("/")[1])
      var year = Number(date.split("/")[2])

      var new_date = new Date(year, month - 1, day)
      return new_date.toISOString()
    }
  }

  transformFullDate(date) {
    if (date != null && date != undefined && date != ``) {
      var all_ptBR_months = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez']
      var all_enUS_months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

      var month = date.split("/")[1]
      var new_month = all_enUS_months[all_ptBR_months.indexOf(month)]
      var new_date = new Date(date.replace(month, new_month))
      return new_date.toISOString()
    } else {
    }
  }

  mountDate(month, year) {
    var all_months = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez']
    var new_date = `${all_months[month - 1]}/${year.toString().slice(-2)}`

    return new_date
  }

  pickDate(ev) {
    ev.target.pickdate({
      today: 'Hoje',
      ok: 'Selecionar',
      cancel: 'Fechar',
      closeOnCancel: true,
      closeOnSelect: true,
      container: 'body',
      containerHidden: 'body',
      firstDay: 0,
      format: 'dd/mmm/yy',
      formatSubmit: 'yyyy-mm-dd',
      // hiddenPrefix: 'pickdate-input-' + input,
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
      selectMonths: true,
      selectYears: true,
      onClose: function (e) {
      },
    });

    element.on('mousedown', function (e) {
      e.preventDefault();
      // $(this).dblclick()
    });
  }

  fullExtension(date) {
    var all_ptBR_months = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez']
    var all_ptBR_full_months = ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro']

    var day = date.split("/")[0]
    var month = all_ptBR_full_months[all_ptBR_months.indexOf(date.split("/")[1])]
    var year = date.split("/")[2]

    return `${day} de ${month} de ${year}`
  }

  checkDate(date) {
    var currentDate = new Date()
    var check = {}

    var day = Number(date.split("/")[0])
    var month = Number(date.split("/")[1])
    var year = Number(date.split("/")[2])

    if (month > 12) {
      check.valid = false
      check.message = `Data Inválida - Mês inválido`
    } else if (this.checkMonthLength(day, month) == false) {
      check.valid = false
      check.message = `Data Inválida - Dia inválido`
    } else if (year > currentDate.getFullYear()) {
      check.valid = false
      check.message = `Data Inválida - Ano inválido`
    } else {
      check.valid = true
      check.message = ``
    }

    return check
  }

  checkMonthLength(day, month) {
    var monthLength = ['31', '28', '31', '30', '31', '30', '31', '31', '30', '31', '30', '31']

    if (day > monthLength[month - 1]) {
      return false
    } else {
      return true
    }

  }

}