import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["main", "list", "view", "viewCard", "viewTitle", "mainCard", "bodyTable", "footerTable", "submenu", "addNewTaxFilingBtn"]

  connect() {
    console.log("connects")
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
  }

  addNewTaxFiling() {
    var html = `<div class="row">
                  <div class="col-12" data-controller="operations--products--tax-filings--add--dashboard" data-target="operations--products--tax-filings--add--dashboard.main"></div>
                </div>`

    this.mainTarget.innerHTML = html
  }


  doPageGrid() {
    var loader = `<div class='card timeline-item-100 m-0 p-1 w-100' style="box-shadow:none;"><div class='animated-background animated-background-20'><div class='background-masker title'></div></div></div>`

    var html = `<div class="row">
                  <div class="col-12" data-target="operations--products--tax-filings--entities--index.list">
                    <div class="card" style="width:100%;display:relative;" data-target="operations--products--tax-filings--entities--index.mainCard">
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
    // `<div class="dropdown">
    //   <button aria-expanded="false" aria-haspopup="true" class="btn btn-outline my-0" data-toggle="dropdown" id="cardFilterTaxReturnBtn" type="button"><i class="material-icons">filter_list</i></button>
    //   <div aria-labelledby="cardFilterTaxReturnBtn" class="dropdown-menu dropdown-menu-right menu" id="cardFilterTaxReturnDiv"></div>
    // </div>`

    var html = `<div class="card" style="width:100%;display:relative;" data-controller="app--helpers--search" data-target="operations--products--tax-filings--entities--index.mainCard" data-action="resize@window->operations--products--tax-filings--entities--index#layout">
                  <div class="card-header d-flex align-items-center card-header-table-list f-065">
                    <h6 class="card-title display-4 card-title-table-list">Todos os Clientes</h6>
                    <input class="form-control s-title-0p7rem w-50 ml-auto" data-target="app--helpers--search.searchInput" data-action="keyup->app--helpers--search#doSearchTable" id="" placeholder="Buscar ..." type="text">
                    <div class="card-actions ml-auto py-0 mc-tooltip">
                      <button aria-expanded="false" aria-haspopup="true" class="btn btn-outline my-0" data-target="operations--products--tax-filings--entities--index.addNewTaxFilingBtn" data-action="click->operations--products--tax-filings--entities--index#addNewTaxFiling" type="button">
                        <span class="material-icons">add</span>
                      </button>
                      <span class="mc-tooltiptext">Adicionar Declaração IRPF</span>
                    </div>
                  </div>
                  <div class="card-body py-0" style="overflow:auto;">
                    <div class="row">
                      <div class="col p-0">
                        <div class="table-responsive">
                          <table class="table table-sm table-hover" style="font-size:80%;" data-target="app--helpers--search.searchTable">
                            <thead>
                              <tr>
                                <th style="font-size:80%;" scope="col" class="p-1 table-20 align-middle pointer">
                                  Nome
                                  <span class="material-icons md-sm md-dark" data-action="click->operations--products--tax-filings--entities--index#sortTable" data-field="account_name" data-mode="desc">south</span>
                                  <span class="material-icons md-sm md-dark d-none" data-action="click->operations--products--tax-filings--entities--index#sortTable" data-field="account_name" data-mode="asc">north</span>
                                </th>
                                <th class="table-5"></th>
                                <th style="font-size:80%;" scope="col" class="p-1 table-10 align-middle text-center">Ver Conta</th>
                                <th style="font-size:80%;" scope="col" class="p-1 table-10 align-middle">CPF</th>
                                <th class="table-5"></th>
                                <th style="font-size:80%;" scope="col" class="p-1 table-10 align-middle text-center">Data Início</th>
                                <th style="font-size:80%;" scope="col" class="p-1 table-20 align-middle pointer text-center">
                                  Status
                                  <span class="material-icons md-sm md-dark" data-action="click->operations--products--tax-filings--entities--index#sortTable" data-field="status_pretty" data-mode="desc">south</span>
                                  <span class="material-icons md-sm md-dark d-none" data-action="click->operations--products--tax-filings--entities--index#sortTable" data-field="status_pretty" data-mode="asc">north</span>
                                </th>
                                <th style="font-size:80%;" scope="col" class="p-1 table-10 align-middle text-center">Ver Página</th>
                                <th style="font-size:80%;" scope="col" class="p-1 table-10 align-middle text-center">Notificações</th>
                                <th style="font-size:80%;" scope="col" class="p-1 table-5 align-middle text-center">Status</th>
                                <th style="font-size:80%;" scope="col" class="p-1 table-5 align-middle text-center">Usuário</th>
                              </tr>
                            </thead>
                            <tbody data-target="operations--products--tax-filings--entities--index.bodyTable">
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="card-footer py-0" data-target="operations--products--tax-filings--entities--index.footerTable">
                  </div>
                </div>`

    var controller = this
    new Promise(function (resolve) {
      resolve(controller.listTarget.innerHTML = html)
    }).then(() => {
      controller.mainCardTarget.style.height = ($(window).height() * 0.5) + "px"
      controller.bodyTableTarget.insertAdjacentHTML("beforeend", controller.getControllerByIdentifier("app--helpers--table").doTablePreloader(10, 4))
      controller.doDataTable()
    })
  }

  doDataTable() {
    // var tax_filings = this.getControllerByIdentifier("app--helpers--data").sortByKeyAsc(this.application.tax_filings, "account_name")

    if (this.sort.mode == `asc`) {
      var tax_filings = this.getControllerByIdentifier("app--helpers--data").sortByKeyAsc(this.application.tax_filings, this.sort.field)
    } else if (this.sort.mode == `desc`) {
      var tax_filings = this.getControllerByIdentifier("app--helpers--data").sortByKeyDesc(this.application.tax_filings, this.sort.field)
    }

    if (tax_filings.length == 0) {
      this.listData()
    } else {
      var itemsOnPage = this.itemsOnPage
      var pageNumber = this.pageNumber
      var numberPages = this.numberPages
      var pages = []
      var itemLoop = Math.ceil(tax_filings.length / itemsOnPage)
      var x = 0
      var i = 1
      for (i; i < itemLoop + 1; i++) {
        var internPage = []
        for (x; x < itemsOnPage * i; x++) {
          if (tax_filings[x] !== undefined) {
            internPage[internPage.length] = tax_filings[x]
          }
        }
        pages[pages.length] = internPage
        numberPages[numberPages.length] = i - 1
      }

      var fromItem = itemsOnPage * pageNumber + 1
      var toItem = Math.min(itemsOnPage * (pageNumber + 1), (itemsOnPage * pageNumber) + pages[pageNumber].length)
      var pagination = { itemsOnPage: itemsOnPage, fromItem: fromItem, toItem: toItem, totalItems: tax_filings.length }
      this.listData(pages[pageNumber])
      this.doFooterTable(pagination)
    }
  }

  listData(data) {
    this.bodyTableTarget.innerHTML = ""
    if (data == undefined || data == [] || data.length == 0) {
      var noData = `</tr>
                      <td colspan="11" class="p-3 align-middle text-center" style="font-size:100%;">
                        <span class="fa-stack fa-1x">
                          <i class="fas fa-list fa-stack-1x"></i>
                        </span>
                        <span class="f-075 align-middle">Não há Clientes</span>
                      </td>
                    </tr>`

      this.bodyTableTarget.innerHTML = noData
    } else {
      data.forEach(element => {
        this.bodyTableTarget.insertAdjacentHTML("beforeend", this.taxFilingTablePartial(element))
      });
    }
  }

  taxFilingTablePartial(element) {
    var notificationsCount = 0

    this.application.notifications.forEach(notification => {
      if (notification.domain_id == element.id) {
        notificationsCount++
      }
    });
    if (this.application.notifications.length > 0) {

    }

    if (this.application.permissions.medfiling.can_select) {
      var check = `<div class="custom-control custom-checkbox pl-1 d-flex align-items-center">
                    <input type="checkbox" class="custom-control-input" id="check-${element.id}" data-target="operations--products--tax-filings--entities--index.checkboxShow" data-action="click->operations--products--tax-filings--entities--index#showTaxReturn">
                    <label class="custom-control-label pointer" for="check-${element.id}"></label>
                  </div>`
    } else {
      var check = ''
    }

    if (this.application.permissions.medfiling.can_copy) {
      var copyPath = `<button type="button" class="btn btn-sm btn-table copy p-0 mc-tooltip">
                        <span class="material-icons md-sm md-light">file_copy</span>
                        <span class="mc-tooltiptext">Copiar</span>
                      </button>`
    } else {
      var copyPath = ``
    }

    if (element.blocked) {
      var statusBlocked = `<span style="color:#F25F5C;" class="mc-tooltip">
                            <span class="material-icons md-sm">clear</span>
                            <span class="mc-tooltiptext">Bloqueado</span>
                          </span>`
    } else {
      var statusBlocked = `<span style="color:#26C485;" class="mc-tooltip">
                            <span class="material-icons md-sm">done_all</span>
                            <span class="mc-tooltiptext">Status Ok</span>
                          </span>`
    }

    if (element.user) {
      var statusUser = `<span style="color:#26C485;" class="mc-tooltip">
                          <span class="material-icons md-sm">done_all</span>
                          <span class="mc-tooltiptext">Usuário Ok</span>
                        </span>`
    } else {
      var statusUser = `<span style="color:#F25F5C;" class="mc-tooltip">
                          <span class="material-icons md-sm">clear</span>
                          <span class="mc-tooltiptext">Sem Conta</span>
                        </span>`
    }

    var accountPath = `<button data-action="click->operations--products--tax-filings--entities--index#goToUserPage" type="button" class="btn btn-sm btn-table p-0 mc-tooltip">
                        <span class="material-icons md-sm md-dark">launch</span>
                        <span class="mc-tooltiptext">Ver Conta ${element.account_name}</span>
                      </button>`
    var productPath = `<button data-action="click->operations--products--tax-filings--entities--index#goToShowPage" type="button" class="btn btn-sm btn-table p-0 mc-tooltip">
                        <span class="material-icons md-sm md-dark">launch</span>
                        <span class="mc-tooltiptext">Ir para as Declarações de ${element.account_name}</span>
                      </button>`

    var rowHtml = `<tr class="itemRow" data-id="${element.id}" data-account-path="${element.account_path}" data-product-path="${element.product_path}">
                    
                    <td style="font-size:80%;" scope="col" class="p-1 align-middle">${element.account_name}</td>
                    <td style="font-size:80%;" scope="col" class="p-1 align-middle" data-copy="${element.account_name}">${copyPath}</td>
                    <td style="font-size:80%;" scope="col" class="p-1 align-middle text-center">${accountPath}</td>
                    <td style="font-size:80%;" scope="col" class="p-1 align-middle">${element.account_cpf_pretty}</td>
                    <td style="font-size:80%;" scope="col" class="p-1 align-middle" data-copy="${element.account_cpf}">${copyPath}</td>
                    <td style="font-size:80%;" scope="col" class="p-1 align-middle text-center">${element.started_at_pick_date}</td>
                    <td style="font-size:80%;" scope="col" class="p-1 align-middle text-center pointer">
                      <span class="" data-target="operations--products--tax-filings--entities--index.statusSpan-${element.id}" data-action="click->operations--products--tax-filings--entities--index#editStatus">
                        ${element.status_pretty}
                      </span>
                      <span class="d-flex align-items-center w-100 d-none" data-target="operations--products--tax-filings--entities--index.statusSelect-${element.id}">
                        <div class="form-group ml-3 mb-0 w-100">
                          <div class="floating-label floating-label-sm">
                            <label>Status</label>
                            <div class="dropdown dropdown-selector" data-controller="app--helpers--search app--helpers--selector" data-target="app--helpers--selector.dropdown operations--products--tax-filings--entities--index.statusDropdown-${element.id}">
                              <button class="dropdown-toggle form-control d-flex" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="height:25px;" data-target="app--helpers--selector.btn operations--products--tax-filings--entities--index.statusDropdownBtn"><span class="mr-auto w-100 selected-item f-065" data-target="app--helpers--selector.input operations--products--tax-filings--entities--index.statusInput-${element.id}"></span></button>
                              <div class="dropdown-menu dropdown-menu-selector w-100 box-shadow-selector">
                                <ul class="ul-select" data-target="operations--products--tax-filings--entities--index.statusList app--helpers--search.searchList">
                                  <li data-action="click->operations--products--tax-filings--entities--index#selectStatus click->app--helpers--selector#select" data-status="going" data-target="app--helpers--selector.select" class="li-selector dark f-065">Ativo</li>
                                  <li data-action="click->operations--products--tax-filings--entities--index#selectStatus click->app--helpers--selector#select" data-status="onboard" data-target="app--helpers--selector.select" class="li-selector dark f-065">Onboard</li>
                                  <li data-action="click->operations--products--tax-filings--entities--index#selectStatus click->app--helpers--selector#select" data-status="renewal" data-target="app--helpers--selector.select" class="li-selector dark f-065">Renovação</li>
                                  <li data-action="click->operations--products--tax-filings--entities--index#selectStatus click->app--helpers--selector#select" data-status="blocked" data-target="app--helpers--selector.select" class="li-selector dark f-065">Bloqueado</li>
                                  <li data-action="click->operations--products--tax-filings--entities--index#selectStatus click->app--helpers--selector#select" data-status="cancel" data-target="app--helpers--selector.select" class="li-selector dark f-065">Cancelado</li>
                                </ul>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="ml-3 mb-0">
                          <button data-target="operations--products--tax-filings--entities--index.cancelBtn" data-action="click->operations--products--tax-filings--entities--index#cancelInput" type="button" class="btn btn-sm btn-table p-0 mc-tooltip">
                            <span aria-hidden="true">&times;</span>
                            <span class="mc-tooltiptext">Cancelar</span>
                          </button>
                        </div>
                      </span>
                    </td>
                    <td style="font-size:80%;" scope="col" class="p-1 align-middle text-center">${productPath}</td>
                    <td style="font-size:80%;" scope="col" class="p-1 align-middle text-center">${notificationsCount}</td>
                    <td style="font-size:80%;" scope="col" class="p-1 align-middle text-center">${statusBlocked}</td>
                    <td style="font-size:80%;" scope="col" class="p-1 align-middle text-center">${statusUser}</td>
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
                            <span class="dropdown-item pointer" data-action="click->operations--products--tax-filings--entities--index#itemsLength" data-items="20">20</span>
                            <span class="dropdown-item pointer" data-action="click->operations--products--tax-filings--entities--index#itemsLength" data-items="50">50</span>
                            <span class="dropdown-item pointer" data-action="click->operations--products--tax-filings--entities--index#itemsLength" data-items="100">100</span>
                          </div>
                        </div>
                        <span class="align-self-center mb-1 mr-2 text-muted">${pagination.fromItem}-${pagination.toItem} de ${pagination.totalItems}</span>
                        <a class="btn btn-outline py-0" data-action="click->operations--products--tax-filings--entities--index#previousTablePage"><i class="material-icons md-sm">chevron_left</i></a>
                        <a class="btn btn-outline py-0" data-action="click->operations--products--tax-filings--entities--index#nextTablePage"><i class="material-icons md-sm">chevron_right</i></a>
                      </div>`

    this.footerTableTarget.innerHTML = footerHtml
  }

  cancelAllInputs() {
    this.application.tax_filings.forEach(element => {
      if (this.nameTarget(`statusInput-${element.id}`) && this.nameTarget(`statusInput-${element.id}`).innerText) {
        this.nameTarget(`statusSpan-${element.id}`).classList.remove("d-none")
        this.nameTarget(`statusSelect-${element.id}`).classList.add("d-none")
        this.nameTarget(`statusSpan-${element.id}`).innerText = this.nameTarget(`statusInput-${element.id}`).innerText
      }
    })
  }

  cancelInput(ev) {
    var taxFilingId = ev.target.closest(".itemRow").dataset.id

    this.nameTarget(`statusSpan-${taxFilingId}`).classList.remove("d-none")
    this.nameTarget(`statusSelect-${taxFilingId}`).classList.add("d-none")
    this.nameTarget(`statusSpan-${taxFilingId}`).innerText = this.nameTarget(`statusInput-${taxFilingId}`).innerText
  }

  editStatus(ev) {
    this.cancelAllInputs()
    var taxFilingId = ev.target.closest(".itemRow").dataset.id
    this.application.tax_filings.forEach(element => {
      if (element.id == taxFilingId) {
        this.current_tax_filing = element
      }
    })

    this.nameTarget(`statusSpan-${taxFilingId}`).classList.add("d-none")
    this.nameTarget(`statusSelect-${taxFilingId}`).classList.remove("d-none")
    this.nameTarget(`statusInput-${taxFilingId}`).innerText = this.current_tax_filing.status_pretty
    this.nameTarget(`statusInput-${taxFilingId}`).dataset.status = this.current_tax_filing.status
    this.nameTarget(`statusDropdown-${taxFilingId}`).value = this.current_tax_filing.status
    this.getControllerByIdentifier("app--helpers--forms").floatingLabel()

  }

  selectStatus(ev) {
    this.cancelAllInputs()
    this.send_data = { current_user: {}, product: {} }
    this.application.tax_filings.forEach(element => {
      if (element.id == ev.target.closest(".itemRow").dataset.id) {
        this.current_tax_filing = element
      }
    })

    this.actionMode = `edit`

    this.send_data.product.id = this.current_tax_filing.id
    this.send_data.product.name = `medfiling`
    this.send_data.product.status = ev.currentTarget.dataset.status

    this.send_data.current_user.current_user_id = this.application.current_user.id

    this.nameTarget(`statusSpan-${this.current_tax_filing.id}`).innerText = ev.currentTarget.innerText

    this.requestSave()
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

  getProducts() {
    const data = { mode: { mode: "product" }, account: { account_id: "" }, product: { name: "medfiling", kind: "receivement" }, current_user: { current_user_id: this.application.current_user.id } }
    const token = $('meta[name=csrf-token]').attr('content');
    const url = "/operations/products/entities/list"
    const init = { method: "POST", credentials: "same-origin", headers: { "X-CSRF-Token": token, 'Content-Type': 'application/json' }, body: JSON.stringify(data) }
    var controller = this
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        this.application.tax_filings = response.data.cln
        controller.doIndexListHtml()
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
                          <span data-action="click->operations--products--tax-filings--entities--index#goToDashboard" class="dropdown-item py-1 pointer">Dashboard</span>
                          <span data-action="click->operations--products--tax-filings--entities--index#goToOnboards" class="dropdown-item py-1 pointer">Onboards</span>
                          <span data-action="click->operations--products--tax-filings--entities--index#goToSetttings" class="dropdown-item py-1 pointer">Configurações</span>
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
    var identifier = "operations--products--tax-filings--entities--index"
    this.getControllerByIdentifier("app--helpers--layout").resizeMainCard(targets, identifier)
  }

  // new Promise(function (resolve) {
  //   resolve()
  // }).then(() => {
  // }) 

}
