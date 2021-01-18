import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["main", "list", "view", "viewCard", "viewTitle", "mainCard", "bodyTable", "footerTable", "submenu", "addNewTaxFilingBtn",
                    "calculation"]

  connect() {
    this.loader = this.getControllerByIdentifier("app--helpers--loaders").loader()
    this.cardLoader = this.getControllerByIdentifier("app--helpers--loaders").cardLoader()
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

  addNewTaxFiling() {
    var html = `<div class="row">
                  <div class="col-12" data-controller="operations--products--tax-filings--add--dashboard" data-target="operations--products--tax-filings--add--dashboard.main"></div>
                </div>`

    this.mainTarget.innerHTML = html
  }


  doPageGrid() {
    var loader = `<div class='card timeline-item-100 m-0 p-1 w-100' style="box-shadow:none;"><div class='animated-background animated-background-20'><div class='background-masker title'></div></div></div>`

    var html = `<div class="row my-5" data-target="commercial--sales--opportunities--entities--index.calculation">
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
                <div class="row">
                  <div class="col-12" data-target="commercial--sales--opportunities--entities--index.list">
                    <div class="card" style="width:100%;display:relative;" data-target="commercial--sales--opportunities--entities--index.mainCard">
                      <div class="card-header py-0">
                        <div class="row my-2"><div class="col">${loader}</div></div>  
                      </div>
                      <div class="card-body">
                        <div class="row my-2"><div class="col">${loader}</div></div>
                        <div class="row my-2"><div class="col">${loader}</div></div>
                        <div class="row my-2"><div class="col">${loader}</div></div>
                      </div>
                      <div class="card-footer py-0">
                        <div class="row my-2"><div class="col">${loader}</div></div>
                      </div>
                    </div>
                  </div>
                </div>`

    // this.mainTarget.innerHTML = html

    var controller = this
    new Promise(function (resolve) {
      resolve(controller.mainTarget.innerHTML = html)
    }).then(() => {
      // controller.mainCardTarget.style.height = ($(window).height() * 0.5) + "px"
    })
  }

  doCalculationCards() {
    var html = `<div class="col-3 pr-2">
                  <div class="card">
                    <div class="card-header p-1 card-header-indicator">
                      <span>Novos Leads</span>
                    </div>
                    <div class="card-body text-center f-075 card-body-indicator px-0 py-1">
                      <div class="row my-1 d-flex align-items-center">
                        <div class="col-3 text-right p-1">
                          novos
                        </div>
                        <div class="col-9 text-left f-1p5 p-1">
                          122
                        </div>
                      </div>
                      <div class="row d-flex align-items-center">
                        <div class="col-3 text-right p-1">
                          objetivo
                        </div>
                        <div class="col-9 text-left f-1p5 p-1">
                          180
                        </div>
                      </div>
                      <div class="row d-flex align-items-center">
                        <div class="col-9 offset-3 text-left f-1 px-1 py-0">
                          67,78%
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-3 px-2">
                  <div class="card">
                    <div class="card-header p-1 card-header-indicator">
                      <span>Novas Oportunidades</span>
                    </div>
                    <div class="card-body text-center f-075 card-body-indicator px-0 py-1">
                      <div class="row my-1 d-flex align-items-center">
                        <div class="col-3 text-right p-1">
                          novos
                        </div>
                        <div class="col-9 text-left f-1p5 p-1">
                          R$ 18.750,00
                        </div>
                      </div>
                      <div class="row d-flex align-items-center">
                        <div class="col-3 text-right p-1">
                          objetivo
                        </div>
                        <div class="col-9 text-left f-1p5 p-1">
                          R$ 30.000,00
                        </div>
                      </div>
                      <div class="row d-flex align-items-center">
                        <div class="col-9 offset-3 text-left f-1 px-1 py-0">
                          62,50%
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-3 px-2">
                  <div class="card">
                    <div class="card-header p-1 card-header-indicator">
                      <span>Ganhos</span>
                    </div>
                    <div class="card-body text-center f-075 card-body-indicator px-0 py-1">
                      <div class="row my-1 d-flex align-items-center">
                        <div class="col-3 text-right p-1">
                          novos
                        </div>
                        <div class="col-9 text-left f-1p5 p-1">
                          R$ 10.750,00
                        </div>
                      </div>
                      <div class="row d-flex align-items-center">
                        <div class="col-3 text-right p-1">
                          objetivo
                        </div>
                        <div class="col-9 text-left f-1p5 p-1">
                          R$ 15.000,00
                        </div>
                      </div>
                      <div class="row d-flex align-items-center">
                        <div class="col-9 offset-3 text-left f-1 px-1 py-0">
                          72,67%
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-2 offset-1">
                  <div class="card">
                    <div class="card-header p-1 card-header-indicator">
                      <span>Tickets</span>
                    </div>
                    <div class="card-body text-center f-075 card-body-indicator px-0 py-1">
                      <div class="row my-1 d-flex align-items-center">
                        <div class="col-6 text-right p-1">
                          total
                        </div>
                        <div class="col-6 text-left f-1p25 p-1">
                          265
                        </div>
                      </div>
                      <div class="row d-flex align-items-center">
                        <div class="col-6 text-right p-1">
                          ligações
                        </div>
                        <div class="col-6 text-left f-1p25 p-1">
                          214
                        </div>
                      </div>
                      <div class="row d-flex align-items-center">
                        <div class="col-6 text-right p-1">
                          contatos
                        </div>
                        <div class="col-6 text-left f-1p25 p-1">
                          240
                        </div>
                      </div>
                    </div>
                  </div>
                </div>`

    this.calculationTarget.innerHTML = html
  }

  requestSave() {
    var url = "/operations/products/entities/update"
    var method = "PUT"
    const init = { method: method, credentials: "same-origin", headers: { "X-CSRF-Token": token, 'Content-Type': 'application/json' }, body: JSON.stringify(this.send_data) }
    var controller = this
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        if (response.save) {
          var tax_filing = response.data.cln
          controller.application.tax_filings.forEach((element, i) => {
            if (element.id == tax_filing.id) {
              controller.application.tax_filings.splice(controller.application.tax_filings.indexOf(element), 1, tax_filing)
            }
          })
        }
        controller.doDataTable()
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar(response.type, response.message, 2000)
      })
      .catch(error => {
        controller.getControllerByIdentifier("app--helpers--console").console(error)
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar("danger", controller.getControllerByIdentifier("app--shared--messages").generalError(), 3000)
        controller.doDataTable()
      })
  }

  goToShowPage(ev) {
    var url = ev.target.closest(".itemRow").dataset.productPath
    window.open(url, `_self`)
  }

  goToUserPage(ev) {
    var url = ev.target.closest(".itemRow").dataset.accountPath
    window.open(url, `_blank`)
  }

  getCommercialDates() {
    console.log(this.application)
    const data = { date: { active: true }, current_user: { current_user_id: this.application.current_user.id } }
    const token = $('meta[name=csrf-token]').attr('content');
    const url = "/commercial/config/dates/list"
    const init = { method: "POST", credentials: "same-origin", headers: { "X-CSRF-Token": token, 'Content-Type': 'application/json' }, body: JSON.stringify(data) }
    var controller = this
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        this.application.dates = response.data.cln
        this.application.current_date = response.data.cln[0]
        controller.doCalculationCards()
      })
      .catch(error => {
        controller.getControllerByIdentifier("app--helpers--console").console(error)
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar("danger", controller.getControllerByIdentifier("app--shared--messages").generalError(), 3000)
      })
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

  doIndexSubmenuHtml() {
    var submenuHtml = `<div class="dropdown mc-tooltip">
                        <button aria-expanded="false" aria-haspopup="true" class="btn btn-outline my-0" data-toggle="dropdown" id="marketingMenuDrop" type="button"><i class="material-icons">apps</i></button>
                        <div aria-labelledby="marketingMenuDrop" class="dropdown-menu dropdown-menu-right menu" style="font-size:80%">
                          <span data-action="click->commercial--sales--opportunities--entities--index#goToDashboard" class="dropdown-item py-1 pointer">Dashboard</span>
                          <span data-action="click->commercial--sales--opportunities--entities--index#goToOnboards" class="dropdown-item py-1 pointer">Onboards</span>
                          <span data-action="click->commercial--sales--opportunities--entities--index#goToSetttings" class="dropdown-item py-1 pointer">Configurações</span>
                        </div>
                        <span class="mc-tooltiptext">Submenu</span>
                      </div>`

    this.submenuTarget.innerHTML = submenuHtml
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
    var identifier = "commercial--sales--opportunities--entities--index"
    this.getControllerByIdentifier("app--helpers--layout").resizeMainCard(targets, identifier)
  }

  // new Promise(function (resolve) {
  //   resolve()
  // }).then(() => {
  // }) 

}
