import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["main", "viewTitle", "subtitle", "4444", "5555", "6666", "7777", "8888", "9999",
                    "prospectingFlow", "qualificationFlow", "bookingFlow", "meetingFlow", "proposalFlow", "closingFlow", "ticketsFlow",
                    "prospectingTotal", "qualificationTotal", "bookingTotal", "meetingTotal", "proposalTotal", "closingTotal", "ticketsTotal",
                    "prospectingAmount", "qualificationAmount", "bookingAmount", "meetingAmount", "proposalAmount", "closingAmount"]
  
  connect() {
    this.application.opportunities = []
    this.application.tickets = []
    this.loader = this.getControllerByIdentifier("app--helpers--loaders").loader()
    this.controllerName = `commercial--sales--opportunities--dealflow--dashboard`
    this.getCommercialDates()
  }

  addNewOpportunity() {
    this.getControllerByIdentifier("commercial--sales--opportunities--dealflow--save").current_lead = {}
    this.getControllerByIdentifier("commercial--sales--opportunities--dealflow--save").doFormHtml()
  }

  setGrid() {
    if (window.location.pathname == `/fluxo-prospeccao`) {
      this.flow = `prospecting`
      this.doProspectionGrid()
      this.subtitleTarget.innerText = `Gestão do Pipeline de Negócios | Fluxo de Prospecção`
    } else if (window.location.pathname == `/fluxo-fechamento`) {
      this.flow = `closing`
      this.doClosingGrid()
      this.subtitleTarget.innerText = `Gestão do Pipeline de Negócios | Fluxo de Fechamento`
    }
  }

  doProspectionGrid() {
    var html = `<div class="row my-2" data-controller="commercial--sales--opportunities--dealflow--flow">
                  <div class="col-3">
                    <div class="card border-top-primary">
                      <div class="card-header p-1 text-center f-075 f-bold">
                        <span>Prospecção</span>
                      </div>
                      <div class="card-body text-center f-075 px-0 py-1">
                        <div class="row my-1 d-flex align-items-center">
                          <div class="col-4 text-right px-1">
                            total
                          </div>
                          <div class="col-7 offset-1 text-left f-1p25 px-1" data-target="${this.controllerName}.prospectingTotal">
                            ${this.loader}
                          </div>
                        </div>
                        <div class="row d-flex align-items-center">
                          <div class="col-4 text-right px-1">
                            valores
                          </div>
                          <div class="col-7 offset-1 text-left f-1p25 px-1" data-target="${this.controllerName}.prospectingAmount">
                            ${this.loader}
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="mt-4" data-target="${this.controllerName}.prospectingFlow"></div>
                  </div>
                  <div class="col-3">
                    <div class="card border-top-primary">
                      <div class="card-header p-1 text-center f-075 f-bold">
                        <span>Qualificação</span>
                      </div>
                      <div class="card-body text-center f-075 px-0 py-1">
                        <div class="row my-1 d-flex align-items-center">
                          <div class="col-4 text-right px-1">
                            total
                          </div>
                          <div class="col-7 offset-1 text-left f-1p25 px-1" data-target="${this.controllerName}.qualificationTotal">
                            ${this.loader}
                          </div>
                        </div>
                        <div class="row d-flex align-items-center">
                          <div class="col-4 text-right px-1">
                            valores
                          </div>
                          <div class="col-7 offset-1 text-left f-1p25 px-1" data-target="${this.controllerName}.qualificationAmount">
                            ${this.loader}
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="mt-4" data-target="${this.controllerName}.qualificationFlow"></div>
                  </div>
                  <div class="col-3">
                    <div class="card border-top-primary">
                      <div class="card-header p-1 text-center f-075 f-bold">
                        <span>Agendamento</span>
                      </div>
                      <div class="card-body text-center f-075 px-0 py-1">
                        <div class="row my-1 d-flex align-items-center">
                          <div class="col-4 text-right px-1">
                            total
                          </div>
                          <div class="col-7 offset-1 text-left f-1p25 px-1" data-target="${this.controllerName}.bookingTotal">
                            ${this.loader}
                          </div>
                        </div>
                        <div class="row d-flex align-items-center">
                          <div class="col-4 text-right px-1">
                            valores
                          </div>
                          <div class="col-7 offset-1 text-left f-1p25 px-1" data-target="${this.controllerName}.bookingAmount">
                            ${this.loader}
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="mt-4" data-target="${this.controllerName}.bookingFlow"></div>
                  </div>
                  <div class="col-3">
                    <div class="card border-top-primary">
                      <div class="card-header p-1 text-center f-075 f-bold">
                        <span>Tickets</span>
                      </div>
                      <div class="card-body text-center f-075 px-0 py-1">
                        <div class="row my-1 d-flex align-items-center">
                          <div class="col-4 text-right px-1">
                            total
                          </div>
                          <div class="col-7 offset-1 text-left f-1p25 px-1" data-target="${this.controllerName}.ticketsTotal">
                            ${this.loader}
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="mt-4" data-target="${this.controllerName}.ticketsFlow"></div>
                  </div>
                </div>`

    var controller = this
    new Promise(function (resolve) {
      resolve(controller.mainTarget.innerHTML = html)
    }).then(() => {
      controller.getOpportunities()
    })
  }

  doClosingGrid() {
    var html = `<div class="row my-2" data-controller="commercial--sales--opportunities--dealflow--flow">
                  <div class="col-3">
                    <div class="card border-top-primary mb-3">
                      <div class="card-header p-1 text-center f-075 f-bold">
                        <span>Consultoria</span>
                      </div>
                      <div class="card-body text-center f-075 px-0 py-1">
                        <div class="row my-1 d-flex align-items-center">
                          <div class="col-4 text-right px-1">
                            total
                          </div>
                          <div class="col-7 offset-1 text-left f-1p25 px-1" data-target="${this.controllerName}.meetingTotal">
                            ${this.loader}
                          </div>
                        </div>
                        <div class="row d-flex align-items-center">
                          <div class="col-4 text-right px-1">
                            valores
                          </div>
                          <div class="col-7 offset-1 text-left f-1p25 px-1" data-target="${this.controllerName}.meetingAmount">
                            ${this.loader}
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="mt-4" data-target="${this.controllerName}.meetingFlow"></div>
                  </div>
                  <div class="col-3">
                    <div class="card border-top-primary">
                      <div class="card-header p-1 text-center f-075 f-bold">
                        <span>Proposta</span>
                      </div>
                      <div class="card-body text-center f-075 px-0 py-1">
                        <div class="row my-1 d-flex align-items-center">
                          <div class="col-4 text-right px-1">
                            total
                          </div>
                          <div class="col-7 offset-1 text-left f-1p25 px-1" data-target="${this.controllerName}.proposalTotal">
                            ${this.loader}
                          </div>
                        </div>
                        <div class="row d-flex align-items-center">
                          <div class="col-4 text-right px-1">
                            valores
                          </div>
                          <div class="col-7 offset-1 text-left f-1p25 px-1" data-target="${this.controllerName}.proposalAmount">
                            ${this.loader}
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="mt-4" data-target="${this.controllerName}.proposalFlow"></div>
                  </div>
                  <div class="col-3">
                    <div class="card border-top-primary">
                      <div class="card-header p-1 text-center f-075 f-bold">
                        <span>Fechamento</span>
                      </div>
                      <div class="card-body text-center f-075 px-0 py-1">
                        <div class="row my-1 d-flex align-items-center">
                          <div class="col-4 text-right px-1">
                            total
                          </div>
                          <div class="col-7 offset-1 text-left f-1p25 px-1" data-target="${this.controllerName}.closingTotal">
                            ${this.loader}
                          </div>
                        </div>
                        <div class="row d-flex align-items-center">
                          <div class="col-4 text-right px-1">
                            valores
                          </div>
                          <div class="col-7 offset-1 text-left f-1p25 px-1" data-target="${this.controllerName}.closingAmount">
                            ${this.loader}
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="mt-4" data-target="${this.controllerName}.closingFlow"></div>
                  </div>
                  <div class="col-3">
                    <div class="card border-top-primary">
                      <div class="card-header p-1 text-center f-075 f-bold">
                        <span>Tickets</span>
                      </div>
                      <div class="card-body text-center f-075 px-0 py-1">
                        <div class="row my-1 d-flex align-items-center">
                          <div class="col-4 text-right px-1">
                            total
                          </div>
                          <div class="col-7 offset-1 text-left f-1p25 px-1" data-target="${this.controllerName}.ticketsTotal">
                            ${this.loader}
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="mt-4" data-target="${this.controllerName}.ticketsFlow"></div>
                  </div>
                </div>`

    var controller = this
    new Promise(function (resolve) {
      resolve(controller.mainTarget.innerHTML = html)
    }).then(() => {
      controller.getOpportunities()
    })
  }

  doTicketsHtml() {
    this.ticketsTotalTarget.innerText = this.application.tickets.length
    this.in_process_tickets = []
    this.resolved_tickets = []
    this.application.tickets.forEach(element => {
      if (element.date_id == this.application.current_date.id) {
        if (element.stage == `in_process`) {
          this.in_process_tickets[this.in_process_tickets.length] = element
        } else if (element.stage == `resolved`) {
          this.resolved_tickets[this.resolved_tickets.length] = element
        }
      }
    })
    var tickets = this.getControllerByIdentifier("app--helpers--data").sortByKeyAsc(this.in_process_tickets, `due_at_time`)

    this.listData(tickets)
  }

  listData(data) {
    this.ticketsFlowTarget.innerHTML = ""
    if (data == undefined || data == [] || data.length == 0) {
      var noData = `<div class="row w-100" style="height:100px;">
                      <div class="col-12 px-0 d-flex align-items-center justify-content-center">
                        <span class="fa-stack fa-1x">
                          <i class="fas fa-list fa-stack-1x"></i>
                        </span>
                        <span class="f-075 align-middle">Não há Tickets em Aberto</span>
                      </div>
                    </div>`

      this.ticketsFlowTarget.innerHTML = noData
    } else {
      var place = 1
      var elements = []
      var columns = 4
      var rows = Math.floor(data.length / columns) + 1
      var row = 1
      if (data.length <= columns) {
        data.forEach(element => {
          elements[elements.length] = element
        })
        this.ticketsFlowTarget.insertAdjacentHTML("beforeend", this.ticketPartial(elements))
      } else {
        data.forEach(element => {
          elements[elements.length] = element
          place += 1

          if (place > columns) {
            this.ticketsFlowTarget.insertAdjacentHTML("beforeend", this.ticketPartial(elements))
            place = 1
            elements = []
            row += 1
          }
        })
        if (row == rows) {
          this.ticketsFlowTarget.insertAdjacentHTML("beforeend", this.ticketPartial(elements))
        }
      }

    }
  }

  ticketPartial(elements) {
    var elementHtml = ``
    elements.forEach(element => {
      var viewBtn = `<div class="col-2 ml-auto px-0 d-flex align-items-center justify-content-center mc-tooltip bg-shadow">
                      <span class="material-icons md-150 md-dark pointer" data-ticket-id="${element.id}" data-action="click->${this.controllerName}#goToURL" data-url="${element.url}">launch</span>
                      <span class="mc-tooltiptext">Ver na Oportunidade</span>
                    </div>`

      var dateBtn = `<div class="col-4 mr-auto px-1 d-flex align-items-center mc-tooltip">
                      <span>${element.due_at_pretty}</span>
                      <span class="mc-tooltiptext">Data de Entrega</span>
                    </div>`

      elementHtml += `<div class="col-12 px-1 my-2">
                        <div class="card border-top-primary border-flag-${element.flag}" data-id="${element.id}">
                          <div class="card-header p-1 text-center f-065 d-flex">
                            ${dateBtn}
                            ${viewBtn}
                          </div>
                          <div class="card-body p-1 text-center f-065" data-target="${this.controllerName}.ticketCardBody">
                            <div class="row py-1 px-2">
                              <div class="col-12 px-0 d-flex align-items-center text-left ticket-content" data-target="${this.controllerName}.bodyShow-${element.id}">${element.body}</div>
                            </div>
                          </div>
                        </div>
                      </div>`
    })

    var html = elementHtml

    return html
  }

  goToURL(ev) {
    var url = ev.currentTarget.dataset.url
    window.open(url, `_blank`)
  }

  getOpportunities() {
    const data = { opportunity: { active: true, flow: this.flow }, current_user: { current_user_id: this.application.current_user.id } }
    const url = "/commercial/sales/opportunities/entities/list"
    const init = { method: "POST", credentials: "same-origin", headers: { "X-CSRF-Token": this.application.token, 'Content-Type': 'application/json' }, body: JSON.stringify(data) }
    var controller = this
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        controller.application.opportunities = response.data.cln
        controller.getControllerByIdentifier("commercial--sales--opportunities--dealflow--flow").doDataFlow()
        controller.getControllerByIdentifier("commercial--sales--opportunities--dealflow--flow").doDataIndicator()
      })
      .catch(error => {
        controller.getControllerByIdentifier("app--helpers--console").console(error)
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar("danger", controller.getControllerByIdentifier("app--shared--messages").generalError(), 3000)
      })
  }

  getCommercialDates() {
    const data = { date: { active: true }, current_user: { current_user_id: this.application.current_user.id } }
    const url = "/commercial/config/dates/list"
    const init = { method: "POST", credentials: "same-origin", headers: { "X-CSRF-Token": this.application.token, 'Content-Type': 'application/json' }, body: JSON.stringify(data) }
    var controller = this
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        this.application.dates = response.data.cln
        this.application.current_date = response.data.cln[0]
        this.application.current_calculation = response.data.cln[0].calculation
        controller.setGrid()
      })
      .catch(error => {
        controller.getControllerByIdentifier("app--helpers--console").console(error)
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar("danger", controller.getControllerByIdentifier("app--helpers--messages").generalError(), 3000)
      })
  }

  getCurrentUserPermissions() {
    const featureNames = ["medfiling", "doctor"]
    const data = { permission: { features: featureNames }, current_user: { current_user_id: this.application.current_user.id } }
    const token = $('meta[name=csrf-token]').attr('content');
    const url = "/users/permissions/list_by_features"
    const init = { method: "POST", credentials: "same-origin", headers: { "X-CSRF-Token": token, 'Content-Type': 'application/json' }, body: JSON.stringify(data) }
    var controller = this
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        response.data.cln.forEach(permission => {
          controller.application.permissions[permission.name] = permission.data
        });
        controller.getProducts()
      })
      .catch(error => {
        controller.getControllerByIdentifier("app--helpers--console").console(error)
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar("danger", controller.getControllerByIdentifier("app--shared--messages").generalError(), 3000)
      })
  }

  getControllerByIdentifier(identifier) {
    return this.application.controllers.find(controller => {
      return controller.context.identifier === identifier;
    });
  }

  nameTarget(target) {
    return this.targets.find(target)
  }

  // new Promise(function (resolve) {
  //   resolve()
  // }).then(() => {
  // }) 

}
