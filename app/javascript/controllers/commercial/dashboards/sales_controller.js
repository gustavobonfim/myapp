import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["main", "view", "viewCard", "viewTitle", "mainCard", "bodyTable", "footerTable", "submenu", "addNewTaxFilingBtn",
                    "calculation", "goalLead", "goalLeadInput", "goalLeadInputSpan", "goalAmount", "goalAmountInput", "goalAmountInputSpan",
                    "goalGain", "goalGainInput", "goalGainInputSpan", "salesLeads", "sideCard"]

  connect() {
    this.loader = this.getControllerByIdentifier("app--helpers--loaders").loader()
    this.cardLoader = this.getControllerByIdentifier("app--helpers--loaders").cardLoader()
    this.controllerName = `commercial--dashboards--sales`
    this.application.permissions = {}
    this.application.chart_accounts = []
    this.application.tax_filings = []
    this.itemsOnPage = 20
    this.pageNumber = 0
    this.numberPages = []
    this.sort = { mode: `asc`, field: `account_name` }
    this.doPageGrid()
    // this.addNewTaxFiling()
    this.doIndexSubmenuHtml()
    // this.getCurrentUserPermissions()
    this.getCommercialDates()
    // this.getOpportunities()
  }

  changeGoalLead() {
    this.goalLeadTarget.classList.add("d-none")
    this.goalLeadInputSpanTarget.classList.remove("d-none")
  }

  changeGoalAmount() {
    this.goalAmountTarget.classList.add("d-none")
    this.goalAmountInputSpanTarget.classList.remove("d-none")
  }

  changeGoalGain() {
    this.goalGainTarget.classList.add("d-none")
    this.goalGainInputSpanTarget.classList.remove("d-none")
  }

  doCalculationCards() {

    if (this.application.current_user.account_kind == "admin") {
      var goalLeads = `<span class="pointer" data-target="${this.controllerName}.goalLead" data-action="click->${this.controllerName}#changeGoalLead">
                        ${this.application.current_calculation.goal_leads}
                      </span>
                      <span class="d-none" data-target="${this.controllerName}.goalLeadInputSpan">
                        <div class="row d-flex align-items-center">
                          <div class="col-8 pr-0">
                            <div class="form-group w-100">
                              <div class="floating-label floating-label-sm">
                                <label for="goalLeadForm">Objetivo</label>
                                <input id="goalLeadForm" aria-describedby="goalLeadFormHelp" class="form-control f-1p25" data-field="goal_leads" autofocus data-target="${this.controllerName}.goalLeadInput" data-action="blur->${this.controllerName}#cancelEdit keyup->${this.controllerName}#cancelEdit" type="number" required>
                              </div>
                            </div>
                          </div>
                          <div class="col-2">
                            <button data-action="click->${this.controllerName}#updateCalculation" data-field="goal_leads" type="button" class="btn btn-sm btn-table p-0 mc-tooltip">
                              <span class="material-icons md-sm md-dark">save</span>
                              <span class="mc-tooltiptext">Salvar</span>
                            </button>
                          </div>
                        </div>
                      </span>`
      var goalAmount = `<span class="pointer" data-target="${this.controllerName}.goalAmount" data-action="click->${this.controllerName}#changeGoalAmount">
                          ${this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(this.application.current_calculation.goal_amount * 100))}
                        </span>
                        <span class="d-none" data-target="${this.controllerName}.goalAmountInputSpan">
                          <div class="row d-flex align-items-center">
                            <div class="col-8 pr-0">
                              <div class="form-group w-100">
                                <div class="floating-label floating-label-sm">
                                  <label for="goalAmountForm">Objetivo</label>
                                  <input id="goalAmountForm" aria-describedby="goalAmountFormHelp" class="form-control f-1p25" data-field="goal_amount" autofocus data-target="${this.controllerName}.goalAmountInput" data-action="blur->${this.controllerName}#currencyMask keyup->${this.controllerName}#currencyMask keypress->${this.controllerName}#currencyMask blur->${this.controllerName}#cancelEdit keyup->${this.controllerName}#cancelEdit" type="text" required>
                                </div>
                              </div>
                            </div>
                            <div class="col-2">
                              <button data-action="click->${this.controllerName}#updateCalculation" data-field="goal_amount" type="button" class="btn btn-sm btn-table p-0 mc-tooltip">
                                <span class="material-icons md-sm md-dark">save</span>
                                <span class="mc-tooltiptext">Salvar</span>
                              </button>
                            </div>
                          </div>
                        </span>`
      var goalGain = `<span class="pointer" data-target="${this.controllerName}.goalGain" data-action="click->${this.controllerName}#changeGoalGain">
                          ${this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(this.application.current_calculation.goal_gain * 100))}
                        </span>
                        <span class="d-none" data-target="${this.controllerName}.goalGainInputSpan">
                          <div class="row d-flex align-items-center">
                            <div class="col-8 pr-0">
                              <div class="form-group w-100">
                                <div class="floating-label floating-label-sm">
                                  <label for="goalGainForm">Objetivo</label>
                                  <input id="goalGainForm" aria-describedby="goalGainFormHelp" class="form-control f-1p25" data-field="goal_gain" autofocus data-target="${this.controllerName}.goalGainInput" data-action="blur->${this.controllerName}#currencyMask keyup->${this.controllerName}#currencyMask keypress->${this.controllerName}#currencyMask blur->${this.controllerName}#cancelEdit keyup->${this.controllerName}#cancelEdit" type="text" required>
                                </div>
                              </div>
                            </div>
                            <div class="col-2">
                              <button data-action="click->${this.controllerName}#updateCalculation" data-field="goal_gain" type="button" class="btn btn-sm btn-table p-0 mc-tooltip">
                                <span class="material-icons md-sm md-dark">save</span>
                                <span class="mc-tooltiptext">Salvar</span>
                              </button>
                            </div>
                          </div>
                        </span>`
    } else {
      var goalLeads = `${this.application.current_calculation.goal_leads}`
      var goalAmount = `${this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(this.application.current_calculation.goal_amount * 100))}`
      var goalGain = `${this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(this.application.current_calculation.goal_gain * 100))}`
    }

    if (this.application.current_calculation.leads_rate < 100) {
      var leadsRate = `<span class="f-bold pointer badge badge-secondary-danger">${this.getControllerByIdentifier("app--helpers--numbers").percentMask(parseInt(this.application.current_calculation.leads_rate * 100))}</span>`
    } else {
      var leadsRate = `<span class="f-bold pointer badge badge-secondary-success">${this.getControllerByIdentifier("app--helpers--numbers").percentMask(parseInt(this.application.current_calculation.leads_rate * 100))}</span>`
    }    

    if (this.application.current_calculation.amount_rate < 100) {
      var amountRate = `<span class="f-bold pointer badge badge-secondary-danger">${this.getControllerByIdentifier("app--helpers--numbers").percentMask(parseInt(this.application.current_calculation.amount_rate * 100))}</span>`
    } else {
      var amountRate = `<span class="f-bold pointer badge badge-secondary-success">${this.getControllerByIdentifier("app--helpers--numbers").percentMask(parseInt(this.application.current_calculation.amount_rate * 100))}</span>`
    }

    if (this.application.current_calculation.gain_rate < 100) {
      var gainRate = `<span class="f-bold pointer badge badge-secondary-danger">${this.getControllerByIdentifier("app--helpers--numbers").percentMask(parseInt(this.application.current_calculation.gain_rate * 100))}</span>`
    } else {
      var gainRate = `<span class="f-bold pointer badge badge-secondary-success">${this.getControllerByIdentifier("app--helpers--numbers").percentMask(parseInt(this.application.current_calculation.gain_rate * 100))}</span>`
    }

    var html = `<div class="col-3 pr-2">
                  <div class="card border-top-primary">
                    <div class="card-header p-1 text-center f-075 f-bold">
                      <span>Novos Leads</span>
                    </div>
                    <div class="card-body text-center f-075 px-0 py-1">
                      <div class="row my-1 d-flex align-items-center">
                        <div class="col-4 text-right px-1">
                          novos
                        </div>
                        <div class="col-7 offset-1 text-left f-1p25 px-1">
                          ${this.application.current_calculation.marketing_leads}
                        </div>
                      </div>
                      <div class="row d-flex align-items-center">
                        <div class="col-4 text-right px-1">
                          objetivo
                        </div>
                        <div class="col-7 offset-1 text-left f-1p25 px-1">
                          ${goalLeads}
                        </div>
                      </div>
                      <div class="row d-flex align-items-center">
                        <div class="col-7 offset-5 text-left f-1 px-1 py-0">
                          ${leadsRate}
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-3 px-2">
                  <div class="card border-top-primary">
                    <div class="card-header p-1 text-center f-075 f-bold">
                      <span>Novas Oportunidades</span>
                    </div>
                    <div class="card-body text-center f-075 px-0 py-1">
                      <div class="row my-1 d-flex align-items-center">
                        <div class="col-4 text-right px-1">
                          novos
                        </div>
                        <div class="col-7 offset-1 text-left f-1p25 px-1">
                          ${this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(this.application.current_calculation.total_amount * 100))}
                        </div>
                      </div>
                      <div class="row d-flex align-items-center">
                        <div class="col-4 text-right px-1">
                          objetivo
                        </div>
                        <div class="col-7 offset-1 text-left f-1p25 px-1">
                          ${goalAmount}
                        </div>
                      </div>
                      <div class="row d-flex align-items-center">
                        <div class="col-7 offset-5 text-left f-1 px-1 py-0">
                          ${amountRate}
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-3 px-2">
                  <div class="card border-top-primary">
                    <div class="card-header p-1 text-center f-075 f-bold">
                      <span>Ganhos</span>
                    </div>
                    <div class="card-body text-center f-075 px-0 py-1">
                      <div class="row my-1 d-flex align-items-center">
                        <div class="col-4 text-right px-1">
                          novos
                        </div>
                        <div class="col-7 offset-1 text-left f-1p25 px-1">
                          ${this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(this.application.current_calculation.total_gain * 100))}
                        </div>
                      </div>
                      <div class="row d-flex align-items-center">
                        <div class="col-4 text-right px-1">
                          objetivo
                        </div>
                        <div class="col-7 offset-1 text-left f-1p25 px-1">
                          ${goalGain}
                        </div>
                      </div>
                      <div class="row d-flex align-items-center">
                        <div class="col-7 offset-5 text-left f-1 px-1 py-0">
                          ${gainRate}
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-2 offset-1">
                  <div class="card border-top-primary">
                    <div class="card-header p-1 text-center f-075 f-bold">
                      <span>Tickets</span>
                    </div>
                    <div class="card-body text-center f-075 px-0 py-1">
                      <div class="row my-1 d-flex align-items-center">
                        <div class="col-6 text-right px-1">
                          total
                        </div>
                        <div class="col-6 text-left f-1p25 px-1">
                          ${this.application.current_calculation.total_tickets}
                        </div>
                      </div>
                      <div class="row d-flex align-items-center">
                        <div class="col-6 text-right px-1">
                          ligações
                        </div>
                        <div class="col-6 text-left f-1p25 px-1">
                          ${this.application.current_calculation.total_calls}
                        </div>
                      </div>
                      <div class="row d-flex align-items-center">
                        <div class="col-6 text-right px-1">
                          contatos
                        </div>
                        <div class="col-6 text-left f-1p25 px-1">
                          ${this.application.current_calculation.total_contacts}
                        </div>
                      </div>
                    </div>
                  </div>
                </div>`


    var controller = this
    new Promise(function (resolve) {
      resolve(controller.calculationTarget.innerHTML = html)
    }).then(() => {
      controller.goalLeadInputTarget.value = controller.application.current_calculation.goal_leads
      controller.goalAmountInputTarget.value = controller.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(controller.application.current_calculation.goal_amount * 100))
      controller.goalGainInputTarget.value = controller.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(controller.application.current_calculation.goal_gain * 100))
      controller.getControllerByIdentifier("app--helpers--forms").floatingLabel()
    })

  }

  updateCalculation(ev) {
    ev.currentTarget.disabled = true
    var field = ev.currentTarget.dataset.field

    if (field == `goal_leads`) {
      var newValue = this.goalLeadInputTarget.value
      var oldValue = this.application.current_calculation.goal_leads
    } else if (field == `goal_amount`) {
      var newValue = this.getControllerByIdentifier("app--helpers--numbers").fromCurrencyToNumber(this.goalAmountInputTarget.value)
      var oldValue = this.application.current_calculation.goal_amount
    } else if (field == `goal_gain`) {
      var newValue = this.getControllerByIdentifier("app--helpers--numbers").fromCurrencyToNumber(this.goalGainInputTarget.value)
      var oldValue = this.application.current_calculation.goal_gain
    }

    this.requestFetchParams = { url: "/commercial/config/calculations/update", method: "PUT", data: { current_user: {}, calculation: {} } }

    this.requestFetchParams.data.current_user.current_user_id = this.application.current_user.id
    this.requestFetchParams.data.calculation.id = this.application.current_calculation.id
    this.requestFetchParams.data.calculation.field = field
    this.requestFetchParams.data.calculation.value = newValue

    if (parseInt(newValue * 100) != parseInt(oldValue * 100)) {
      this.requestFetch()
    } else {
      this.doCalculationCards()
    }
  }

  requestFetch() {
    const init = { method: this.requestFetchParams.method, credentials: "same-origin", headers: { "X-CSRF-Token": this.application.token, 'Content-Type': 'application/json' }, body: JSON.stringify(this.requestFetchParams.data) }
    var controller = this
    fetch(this.requestFetchParams.url, init)
      .then(response => response.json())
      .then(response => {
        if (response.save) {
          this.application.current_calculation = response.data.cln
        }
        controller.doCalculationCards()
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar(response.type, response.message, 2000)
      })
      .catch(error => {
        controller.getControllerByIdentifier("app--helpers--console").console(error)
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar("danger", controller.getControllerByIdentifier("app--shared--messages").generalError(), 3000)
        controller.doCalculationCards()
      })
  }

  currencyMask(ev) {
    this.getControllerByIdentifier("app--helpers--numbers").changeNumberToCurrency(ev)
  }

  cancelEdit(ev) {
    if ((ev.type == "keyup" && ev.key == "Escape" && ev.shiftKey == false)) {
      var field = ev.currentTarget.dataset.field

      if (field == `goal_leads`) {
        this.goalLeadTarget.classList.remove("d-none")
        this.goalLeadInputSpanTarget.classList.add("d-none")
      } else if (field == `goal_amount`) {
        this.goalAmountTarget.classList.remove("d-none")
        this.goalAmountInputSpanTarget.classList.add("d-none")
      } else if (field == `goal_gain`) {
        this.goalGainTarget.classList.remove("d-none")
        this.goalGainInputSpanTarget.classList.add("d-none")
      }
    }
  }

  doIndexSubmenuHtml() {
    var submenuHtml = `<div class="dropdown mc-tooltip">
                        <button aria-expanded="false" aria-haspopup="true" class="btn btn-outline my-0" data-toggle="dropdown" id="marketingMenuDrop" type="button"><i class="material-icons">apps</i></button>
                        <div aria-labelledby="marketingMenuDrop" class="dropdown-menu dropdown-menu-right menu" style="font-size:80%">
                          <span data-action="click->${this.controllerName}#goToDashboard" class="dropdown-item py-1 pointer">Dashboard</span>
                          <span data-action="click->${this.controllerName}#goToOnboards" class="dropdown-item py-1 pointer">Onboards</span>
                          <span data-action="click->${this.controllerName}#goToSetttings" class="dropdown-item py-1 pointer">Configurações</span>
                        </div>
                        <span class="mc-tooltiptext">Submenu</span>
                      </div>`

    this.submenuTarget.innerHTML = submenuHtml
  }

  goToURL(ev) {
    var url = ev.target.closest(".itemRow").dataset.productPath
    window.open(url, `_self`)
  }

  goToDashboard() {
    this.doPageGrid()
    this.doIndexListHtml()
  }

  goToSetttings() {
    var html = `<div class="row">
                  <div class="col-12" data-controller="operations--products--tax-filings--entities--settings" data-target="operations--products--tax-filings--entities--settings.main"></div>
                </div>`

    this.mainTarget.innerHTML = html
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
        controller.doCalculationCards()
      })
      .catch(error => {
        controller.getControllerByIdentifier("app--helpers--console").console(error)
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar("danger", controller.getControllerByIdentifier("app--helpers--messages").generalError(), 3000)
      })
  }

  goToURL(ev) {
    var url = ev.currentTarget.dataset.url
    window.open(url, `_self`)
  }

  doSideCardHtml() {
    var html = `<div class="col-4 px-1">
                  <div class="card border-top-primary">
                    <div class="card-header p-1 text-center f-065">
                      <span>Fluxo Prospecção</span>
                    </div>
                    <div class="card-body text-center py-2 mc-tooltip pointer" data-url="/fluxo-prospeccao" data-action="click->${this.controllerName}#goToURL">
                      <span class="material-icons md-lg md-dark">account_box</span>
                      <span class="mc-tooltiptext">Fluxo Prospecção</span>
                    </div>
                  </div>
                </div>
                <div class="col-4 px-1">
                  <div class="card border-top-primary">
                    <div class="card-header p-1 text-center f-065">
                      <span>Fluxo Fechamento</span>
                    </div>
                    <div class="card-body text-center py-2 mc-tooltip pointer" data-url="/fluxo-fechamento" data-action="click->${this.controllerName}#goToURL">
                      <span class="material-icons md-lg md-dark">account_box</span>
                      <span class="mc-tooltiptext">Fluxo Fechamento</span>
                    </div>
                  </div>
                </div>`

    this.sideCardTarget.innerHTML = html
  }

  doPageGrid() {

    var html = `<div class="row my-3" data-target="${this.controllerName}.calculation">
                  <div class="col-3">
                    ${this.cardLoader}
                  </div>
                  <div class="col-3">
                    ${this.cardLoader}
                  </div>
                  <div class="col-3">
                    ${this.cardLoader}
                  </div>
                  <div class="col-3">
                    ${this.cardLoader}
                  </div>
                </div>
                <div class="row my-5">
                  <div class="col-8" data-controller="commercial--sales--leads--entities--index" data-target="commercial--sales--leads--entities--index.main">
                    <div class="card" style="width:100%;display:relative;" data-target="${this.controllerName}.mainCard">
                      <div class="card-header py-0">
                        <div class="row my-2"><div class="col">${this.loader}</div></div>  
                      </div>
                      <div class="card-body">
                        <div class="row my-2"><div class="col">${this.loader}</div></div>
                        <div class="row my-2"><div class="col">${this.loader}</div></div>
                        <div class="row my-2"><div class="col">${this.loader}</div></div>
                      </div>
                      <div class="card-footer py-0">
                        <div class="row my-2"><div class="col">${this.loader}</div></div>
                      </div>
                    </div>
                  </div>
                  <div class="col-4" data-controller="commercial--sales--leads--entities--save">
                    <div class="row my-2">
                      <h6 class="mb-0 text-center">Acesso Rápido</h6>
                      <hr class="mt-1">
                    </div>
                    <div class="row my-2" data-target="${this.controllerName}.sideCard">
                      ${this.loader}
                    </div>
                  </div>
                </div>`

    this.mainTarget.innerHTML = html
  }

  getControllerByIdentifier(identifier) {
    return this.application.controllers.find(controller => {
      return controller.context.identifier === identifier;
    });
  }

  nameTarget(target) {
    return this.targets.find(target)
  }

  layout() {
    var targets = ["mainCard"]
    var identifier = "${this.controllerName}"
    this.getControllerByIdentifier("app--helpers--layout").resizeMainCard(targets, identifier)
  }

  // new Promise(function (resolve) {
  //   resolve()
  // }).then(() => {
  // }) 

}
