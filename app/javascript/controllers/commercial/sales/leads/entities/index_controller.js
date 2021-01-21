import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["main", "list", "view", "viewCard", "viewTitle", "mainCard", "bodyTable", "footerTable", "submenu", "addNewLeadBtn"]

  connect() {
    this.application.leads = []
    this.controllerName = `commercial--sales--leads--entities--index`
    this.itemsOnPage = 20
    this.pageNumber = 0
    this.numberPages = []
    this.sort = { mode: `asc`, field: `name` }
    this.doIndexListHtml()
    this.getLeads()
  }

  addNewLead() {
    // var html = `<div class="row">
    //               <div class="col-12" data-controller="operations--products--tax-filings--add--dashboard" data-target="operations--products--tax-filings--add--dashboard.main"></div>
    //             </div>`
    // this.mainTarget.innerHTML = html
    this.getControllerByIdentifier("commercial--sales--leads--entities--save").doFormHtml()
  }

  addOpportunity(ev) {
    var leadId = ev.currentTarget.closest(".itemRow").dataset.id
    var lead = {}

    this.application.leads.forEach(element => {
      if (element.id == leadId) {
        lead = element
      }
    })

    this.getControllerByIdentifier("commercial--sales--opportunities--entities--save").current_lead = lead
    this.getControllerByIdentifier("commercial--sales--opportunities--entities--save").doFormHtml()
  }

  goToOpportunity(ev) {
    var url = ev.currentTarget.closest(".itemRow").dataset.opportunityPath
    window.open(url, `_blank`)
  }

  sortTable(ev) {
    var mode = ev.currentTarget.dataset.mode
    var field = ev.currentTarget.dataset.field

    if (mode == `desc`) {
      ev.currentTarget.nextElementSibling.classList.remove("d-none")
      ev.currentTarget.classList.add("d-none")
    } else if (mode == `asc`) {
      ev.currentTarget.previousElementSibling.classList.remove("d-none")
      ev.currentTarget.classList.add("d-none")
    }

    this.sort.mode = mode
    this.sort.field = field
    this.doDataTable()
  }

  doIndexListHtml() {
    var html = `<div class="card" style="width:100%;display:relative;" data-controller="app--helpers--search" data-target="${this.controllerName}.mainCard" data-action="resize@window->${this.controllerName}#layout">
                  <div class="card-header d-flex align-items-center card-header-table-list f-065">
                    <h6 class="card-title display-4 card-title-table-list">Todos os Leads Gerados</h6>
                    <input class="form-control s-title-0p7rem w-50 ml-auto" data-target="app--helpers--search.searchInput" data-action="keyup->app--helpers--search#doSearchTable" id="" placeholder="Buscar ..." type="text">
                    <div class="card-actions ml-auto py-0 mc-tooltip">
                      <button aria-expanded="false" aria-haspopup="true" class="btn btn-outline my-0" data-target="${this.controllerName}.addNewLeadBtn" data-action="click->${this.controllerName}#addNewLead" type="button">
                        <span class="material-icons">add</span>
                      </button>
                      <span class="mc-tooltiptext">Adicionar Novo Lead</span>
                    </div>
                  </div>
                  <div class="card-body py-0 card-overflow">
                    <div class="row">
                      <div class="col p-0">
                        <div class="table-responsive">
                          <table class="table table-sm table-hover" style="font-size:80%;" data-target="app--helpers--search.searchTable">
                            <thead>
                              <tr>
                                <th style="font-size:80%;" scope="col" class="p-1 table-15 align-middle">Data</th>
                                <th style="font-size:80%;" scope="col" class="p-1 table-20 align-middle pointer">
                                  Nome
                                  <span class="material-icons md-sm md-dark" data-action="click->${this.controllerName}#sortTable" data-field="account_name" data-mode="desc">south</span>
                                  <span class="material-icons md-sm md-dark d-none" data-action="click->${this.controllerName}#sortTable" data-field="account_name" data-mode="asc">north</span>
                                </th>
                                <th style="font-size:80%;" scope="col" class="p-1 table-20 align-middle">Fonte</th>
                                <th style="font-size:80%;" scope="col" class="p-1 table-20 align-middle">Conselho</th>                                
                                <th style="font-size:80%;" scope="col" class="p-1 table-20 align-middle pointer">
                                  Status
                                  <span class="material-icons md-sm md-dark" data-action="click->${this.controllerName}#sortTable" data-field="status_pretty" data-mode="desc">south</span>
                                  <span class="material-icons md-sm md-dark d-none" data-action="click->${this.controllerName}#sortTable" data-field="status_pretty" data-mode="asc">north</span>
                                </th>
                                <th style="font-size:80%;" scope="col" class="p-1 table-3 align-middle text-center"></th>
                                <th style="font-size:80%;" scope="col" class="p-1 table-3 align-middle text-center"></th>
                                <th style="font-size:80%;" scope="col" class="p-1 table-3 align-middle text-center"></th>
                              </tr>
                            </thead>
                            <tbody data-target="${this.controllerName}.bodyTable">
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="card-footer py-0" data-target="${this.controllerName}.footerTable">
                  </div>
                </div>`

    var controller = this
    new Promise(function (resolve) {
      resolve(controller.mainTarget.innerHTML = html)
    }).then(() => {
      controller.mainCardTarget.style.height = ($(window).height() * 0.5) + "px"
      controller.bodyTableTarget.insertAdjacentHTML("beforeend", controller.getControllerByIdentifier("app--helpers--table").doTablePreloader(8, 4))
      // controller.doDataTable()
    })
  }

  doDataTable() {

    if (this.sort.mode == `asc`) {
      var leads = this.getControllerByIdentifier("app--helpers--data").sortByKeyAsc(this.application.leads, this.sort.field)
    } else if (this.sort.mode == `desc`) {
      var leads = this.getControllerByIdentifier("app--helpers--data").sortByKeyDesc(this.application.leads, this.sort.field)
    }

    if (leads.length == 0) {
      this.listData()
    } else {
      var itemsOnPage = this.itemsOnPage
      var pageNumber = this.pageNumber
      var numberPages = this.numberPages
      var pages = []
      var itemLoop = Math.ceil(leads.length / itemsOnPage)
      var x = 0
      var i = 1
      for (i; i < itemLoop + 1; i++) {
        var internPage = []
        for (x; x < itemsOnPage * i; x++) {
          if (leads[x] !== undefined) {
            internPage[internPage.length] = leads[x]
          }
        }
        pages[pages.length] = internPage
        numberPages[numberPages.length] = i - 1
      }

      var fromItem = itemsOnPage * pageNumber + 1
      var toItem = Math.min(itemsOnPage * (pageNumber + 1), (itemsOnPage * pageNumber) + pages[pageNumber].length)
      var pagination = { itemsOnPage: itemsOnPage, fromItem: fromItem, toItem: toItem, totalItems: leads.length }
      this.listData(pages[pageNumber])
      this.doFooterTable(pagination)
    }
  }

  listData(data) {
    this.bodyTableTarget.innerHTML = ""
    if (data == undefined || data == [] || data.length == 0) {
      var noData = `</tr>
                      <td colspan="8" class="p-3 align-middle text-center" style="font-size:100%;">
                        <span class="fa-stack fa-1x">
                          <i class="fas fa-list fa-stack-1x"></i>
                        </span>
                        <span class="f-075 align-middle">Não há Leads Gerados</span>
                      </td>
                    </tr>`

      this.bodyTableTarget.innerHTML = noData
    } else {
      data.forEach(element => {
        this.bodyTableTarget.insertAdjacentHTML("beforeend", this.leadTablePartial(element, data.length))
      });
    }
  }

  leadTablePartial(element, length) {

    if (element.status == `not_contact`) {
      var actionBtn = `<button data-action="click->${this.controllerName}#addOpportunity" type="button" class="btn btn-sm btn-table p-0 mc-tooltip">
                        <span class="material-icons md-sm md-dark">add_circle_outline</span>
                        <span class="mc-tooltiptext">Criar Oportunidade</span>
                      </button>`
      var statusIcon = `<span class="mc-tooltip">
                          <span class="material-icons md-sm md-warning">new_releases</span>
                          <span class="mc-tooltiptext">${element.status_pretty}</span>
                        </span>`
    } else if (element.status == `in_process`) {
      var actionBtn = `<button data-action="click->${this.controllerName}#goToOpportunity" type="button" class="btn btn-sm btn-table p-0 mc-tooltip">
                        <span class="material-icons md-sm md-dark">launch</span>
                        <span class="mc-tooltiptext">Ver Oportunidade</span>
                      </button>`
      var statusIcon = `<span class="mc-tooltip">
                          <span class="material-icons md-sm md-primary">phone_in_talk</span>
                          <span class="mc-tooltiptext">${element.status_pretty}</span>
                        </span>`
    } else if (element.status == `gain`) {
      var actionBtn = ``
      var statusIcon = `<span class="mc-tooltip">
                          <span class="material-icons md-sm md-success">emoji_events</span>
                          <span class="mc-tooltiptext">${element.status_pretty}</span>
                        </span>`
    } else if (element.status == `lost`) {
      var actionBtn = ``
      var statusIcon = `<span class="mc-tooltip">
                          <span class="material-icons md-sm md-danger">clear</span>
                          <span class="mc-tooltiptext">${element.status_pretty}</span>
                        </span>`
    }

    if (length == 1) {
      var tableRow = `<tr class="itemRow" data-id="${element.id}" data-opportunity-path="${element.opportunity_path}" style="height:50px;">`
    } else {
      var tableRow = `<tr class="itemRow" data-id="${element.id}" data-opportunity-path="${element.opportunity_path}">`
    }


    var rowHtml = `${tableRow}
                    <td style="font-size:80%;" scope="col" class="p-1 align-middle">${element.created_at_pretty}</td>
                    <td style="font-size:80%;" scope="col" class="p-1 align-middle">${element.name}</td>
                    <td style="font-size:80%;" scope="col" class="p-1 align-middle">${element.primary_source_pretty}</td>
                    <td style="font-size:80%;" scope="col" class="p-1 align-middle">${element.council}</td>
                    <td style="font-size:80%;" scope="col" class="p-1 align-middle">${element.status_pretty}</td>
                    <td style="font-size:80%;" scope="col" class="p-1 align-middle pointer">${statusIcon}</td>
                    <td style="font-size:80%;" scope="col" class="p-1 px-3 align-middle pointer">${actionBtn}</td>
                    <td style="font-size:80%;" scope="col" class="p-1 align-middle pointer"></td>
                  </tr>`

    return rowHtml
  }

  itemsLength(ev) {
    this.itemsOnPage = ev.target.dataset.items
    this.pageNumber = 0
    this.numberPages = []
    this.doDataTable()
  }

  previousTablePage(ev) {
    if (this.numberPages.includes(this.pageNumber - 1)) {
      this.pageNumber -= 1
      this.doDataTable()
    }
  }

  nextTablePage(ev) {
    if (this.numberPages.includes(this.pageNumber + 1)) {
      this.pageNumber += 1
      this.doDataTable()
    }
  }

  doFooterTable(pagination) {
    var footerHtml = `<div class="card-actions align-items-center justify-content-end py-0 f-065">
                        <span class="align-self-center mb-1 mx-1 text-muted">Itens por Página:</span>
                        <div class="dropdown">
                          <button aria-expanded="false" aria-haspopup="true" class="btn btn-outline dropdown-toggle f-065" data-toggle="dropdown" type="button">${pagination.itemsOnPage}</button>
                          <div class="dropdown-menu dropdown-menu-right menu">
                            <span class="dropdown-item pointer" data-action="click->${this.controllerName}#itemsLength" data-items="20">20</span>
                            <span class="dropdown-item pointer" data-action="click->${this.controllerName}#itemsLength" data-items="50">50</span>
                            <span class="dropdown-item pointer" data-action="click->${this.controllerName}#itemsLength" data-items="100">100</span>
                          </div>
                        </div>
                        <span class="align-self-center mb-1 mr-2 text-muted">${pagination.fromItem}-${pagination.toItem} de ${pagination.totalItems}</span>
                        <a class="btn btn-outline py-0" data-action="click->${this.controllerName}#previousTablePage"><i class="material-icons md-sm">chevron_left</i></a>
                        <a class="btn btn-outline py-0" data-action="click->${this.controllerName}#nextTablePage"><i class="material-icons md-sm">chevron_right</i></a>
                      </div>`

    this.footerTableTarget.innerHTML = footerHtml
  }

  getLeads() {
    const data = { lead: { active: true }, current_user: { current_user_id: this.application.current_user.id } }
    const url = "/commercial/sales/leads/entities/list"
    const init = { method: "POST", credentials: "same-origin", headers: { "X-CSRF-Token": this.application.token, 'Content-Type': 'application/json' }, body: JSON.stringify(data) }
    var controller = this
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        this.application.leads = response.data.cln
        controller.doDataTable()
        controller.getControllerByIdentifier(`commercial--dashboards--sales`).doSideCardHtml()
      })
      .catch(error => {
        controller.getControllerByIdentifier("app--helpers--console").console(error)
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar("danger", controller.getControllerByIdentifier("app--shared--messages").generalError(), 3000)
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

  layout() {
    var targets = ["mainCard"]
    var identifier = "operations--products--tax-filings--entities--index"
    // this.getControllerByIdentifier("app--helpers--layout").resizeMainCard(targets, identifier)
  }

  // new Promise(function (resolve) {
  //   resolve()
  // }).then(() => {
  // }) 

}
