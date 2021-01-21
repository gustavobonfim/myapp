import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["main", "viewTitle", "saveBtn", "nameInput", "emailInput", "councilInput", "councilStateInput",
                    "prefixInput", "phoneInput", "notesInput", "linkInput", "sourceDropdown", "sourceDropdownBtn", "sourceInput", "sourceList",
                    "statusDropdown", "statusDropdownBtn", "statusInput", "statusList"]

  connect() {
    this.controllerName = `commercial--sales--leads--entities--save`
  }

  doFormHtml() {
    // if (this.application.permissions.medfiling_files.can_create) {
    var saveBtnHtml = `<button disabled type="button" class="btn btn-primary btn-sm btn-table f-065" data-action="click->${this.controllerName}#saveSalesLead" data-target="${this.controllerName}.saveBtn">Salvar</button>`
    // } else {
    //   var saveBtnHtml = ``
    // }

    var html = `<div class="card" style="width:100%;display:relative;">
                  <div class="card-header d-flex align-items-center card-header-table-list f-065">
                    <h6 class="card-title display-4" style="padding:1rem;font-size:110%;margin-bottom:0px;" data-target="${this.controllerName}.viewTitle"></h6>
                  </div>
                  <div class="card-body py-0" style="overflow:auto;" data-target="${this.controllerName}.formCardBody">

                      <div class="row my-2">
                        <div class="col-8 pl-0 pr-2">
                          <div class="form-group">
                            <div class="floating-label floating-label-sm">
                              <label for="nameForm">Nome</label>
                              <input aria-describedby="nameFormHelp" class="form-control" id="nameForm" data-target="${this.controllerName}.nameInput" placeholder="Nome" type="text" required>
                            </div>
                          </div>
                        </div>
                        <div class="col-4 pl-2 pr-0">
                          <div class="form-group">
                            <div class="floating-label floating-label-sm">
                              <label>Fonte</label>
                              <div class="dropdown dropdown-selector" data-controller="app--helpers--search app--helpers--selector" data-target="app--helpers--selector.dropdown ${this.controllerName}.sourceDropdown">
                                <button class="dropdown-toggle form-control d-flex" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="height:32px;" data-target="app--helpers--selector.btn ${this.controllerName}.sourceDropdownBtn"><span class="mr-auto w-100 selected-item" data-target="app--helpers--selector.input ${this.controllerName}.sourceInput"></span></button>
                                <div class="dropdown-menu dropdown-menu-selector w-100 box-shadow-selector">
                                  <input class="form-control form-control-selector" data-target="app--helpers--search.searchInput" data-action="keyup->app--helpers--search#doSearchList" type="text" placeholder="Buscar ...">
                                  <ul class="ul-select" data-target="${this.controllerName}.sourceList app--helpers--search.searchList">
                                    <li data-source="base" data-source-type="base" data-action="click->app--helpers--selector#select" data-target="app--helpers--selector.select" class="li-selector dark f-065">Base</li>
                                    <li data-source="referrer" data-source-type="referrer" data-action="click->app--helpers--selector#select" data-target="app--helpers--selector.select" class="li-selector dark f-065">Indicação</li>
                                    <li data-source="landing" data-source-type="landing_conversion" data-action="click->app--helpers--selector#select" data-target="app--helpers--selector.select" class="li-selector dark f-065">Landing</li>
                                    <li data-source="event" data-source-type="event_conversion" data-action="click->app--helpers--selector#select" data-target="app--helpers--selector.select" class="li-selector dark f-065">Evento</li>
                                    <li data-source="session" data-source-type="session_conversion" data-action="click->app--helpers--selector#select" data-target="app--helpers--selector.select" class="li-selector dark f-065">Sessões</li>
                                  </ul>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      
                      <div class="row my-2">
                        <div class="col-8 pl-0 pr-2">
                          <div class="form-group">
                            <div class="floating-label floating-label-sm">
                              <label for="emailForm">E-mail</label>
                              <input aria-describedby="emailFormHelp" class="form-control" id="emailForm" data-target="${this.controllerName}.emailInput" placeholder="Nome" type="text" required>
                            </div>
                          </div>
                        </div>
                        <div class="col-4 pl-2 pr-0">
                          <div class="form-group">
                            <div class="floating-label floating-label-sm">
                              <label>Estágio</label>
                              <div class="dropdown dropdown-selector" data-controller="app--helpers--search app--helpers--selector" data-target="app--helpers--selector.dropdown ${this.controllerName}.statusDropdown">
                                <button class="dropdown-toggle form-control d-flex" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="height:32px;" data-target="app--helpers--selector.btn ${this.controllerName}.statusDropdownBtn"><span class="mr-auto w-100 selected-item" data-target="app--helpers--selector.input ${this.controllerName}.statusInput"></span></button>
                                <div class="dropdown-menu dropdown-menu-selector w-100 box-shadow-selector">
                                  <input class="form-control form-control-selector" data-target="app--helpers--search.searchInput" data-action="keyup->app--helpers--search#doSearchList" type="text" placeholder="Buscar ...">
                                  <ul class="ul-select" data-target="${this.controllerName}.statusList app--helpers--search.searchList">
                                    <li data-status="in_process" data-action="click->app--helpers--selector#select" data-target="app--helpers--selector.select" class="li-selector dark f-065">Em Processo</li>
                                    <li data-status="gain" data-action="click->app--helpers--selector#select" data-target="app--helpers--selector.select" class="li-selector dark f-065">Ganho</li>
                                    <li data-status="lost" data-action="click->app--helpers--selector#select" data-target="app--helpers--selector.select" class="li-selector dark f-065">Perdido</li>
                                    <li data-status="not_contact" data-action="click->app--helpers--selector#select" data-target="app--helpers--selector.select" class="li-selector dark f-065">Não Contactado</li>
                                  </ul>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="row my-2">
                        <div class="col-4 pl-0 pr-2">
                          <div class="form-group">
                            <div class="floating-label floating-label-sm">
                              <label for="councilForm">CRM</label>
                              <input aria-describedby="councilFormHelp" class="form-control" id="councilForm" data-target="${this.controllerName}.councilInput" placeholder="Nome" type="text" required>
                            </div>
                          </div>
                        </div>
                        <div class="col-2 pl-2 pr-2">
                          <div class="form-group">
                            <div class="floating-label floating-label-sm">
                              <label for="councilStateForm">UF CRM</label>
                              <input aria-describedby="councilStateFormHelp" class="form-control" id="councilStateForm" data-target="${this.controllerName}.councilStateInput" placeholder="Nome" type="text" required>
                            </div>
                          </div>
                        </div>
                        <div class="col-2 pl-2 pr-2">
                          <div class="form-group">
                            <div class="floating-label floating-label-sm">
                              <label for="prefixForm">DDD</label>
                              <input aria-describedby="prefixFormHelp" class="form-control" id="prefixForm" data-target="${this.controllerName}.prefixInput" data-action="blur->${this.controllerName}#prefixMask keyup->${this.controllerName}#prefixMask keypress->${this.controllerName}#prefixMask" placeholder="DDD" type="tel" required>
                            </div>
                          </div>
                        </div>
                        <div class="col-4 pl-2 pr-0">
                          <div class="form-group">
                            <div class="floating-label floating-label-sm">
                              <label for="phoneForm">Telefone</label>
                              <input aria-describedby="phoneFormHelp" class="form-control" id="phoneForm" data-target="${this.controllerName}.phoneInput" data-action="blur->${this.controllerName}#phoneMask keyup->${this.controllerName}#phoneMask keypress->${this.controllerName}#phoneMask" placeholder="Número" type="tel" required>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="row my-2">
                        <div class="col-12 px-2">
                          <div class="form-group">
                            <div class="floating-label floating-label-sm">
                              <label for="linkForm">Link Minha MedCapital</label>
                              <input aria-describedby="linkFormHelp" class="form-control" id="linkForm" data-target="${this.controllerName}.linkInput" placeholder="Link Minha MedCapital" type="text" required>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="row my-2">
                        <div class="col-12 px-2">
                          <div class="form-group">
                            <div class="floating-label floating-label-sm">
                              <label for="notesForm">Anotações</label>
                              <textarea aria-describedby="notesFormHelp" class="form-control textarea px-0" id="notesForm" data-target="${this.controllerName}.notesInput" placeholder="Anotações" type="text" required rows="3"></textarea>
                            </div>
                          </div>
                        </div>
                      </div>                
                  </div>
                  <div class="card-footer border-top text-right py-1">
                    <button type="button" class="btn btn-secondary btn-sm btn-table f-065" data-action="click->${this.controllerName}#cancelSave">Fechar</button>
                    ${saveBtnHtml}
                  </div>
                </div>`


    var controller = this
    new Promise(function (resolve) {
      resolve(controller.getControllerByIdentifier(`commercial--dashboards--sales`).sideCardTarget.innerHTML = html)
    }).then(() => {
      
      controller.viewTitleTarget.innerText = `Novo SQL`
      controller.sourceInputTarget.innerText = ``
      controller.sourceInputTarget.dataset.source = ``
      controller.sourceDropdownTarget.value = ``

      controller.statusInputTarget.innerText = `Não Contactado`
      controller.statusInputTarget.dataset.status = `not_contact`
      controller.statusDropdownTarget.value = `not_contact`
      controller.statusDropdownBtnTarget.disabled = true

      controller.getControllerByIdentifier("app--helpers--forms").floatingLabel()
      controller.refreshSaveBtn()
    })
  }

  cancelSave() {
    this.stopRefreshing()
    this.getControllerByIdentifier(`commercial--dashboards--sales`).doSideCardHtml()
  }

  prefixMask(ev) {
    this.getControllerByIdentifier("app--helpers--numbers").changeNumberToDDD(ev)
  }

  phoneMask(ev) {
    this.getControllerByIdentifier("app--helpers--numbers").changeNumberToPhone(ev)
  }

  saveSalesLead() {
    this.saveBtnTarget.disabled = true
    this.stopRefreshing()
    this.send_data = { current_user: {}, lead: {}, source: {} }

    this.send_data.source.source = this.sourceInputTarget.dataset.source
    this.send_data.source.source_type = this.sourceInputTarget.dataset.sourceType

    this.send_data.lead.name = this.nameInputTarget.value
    this.send_data.lead.primary_source = this.sourceInputTarget.dataset.source
    this.send_data.lead.email = this.emailInputTarget.value
    this.send_data.lead.status = this.statusInputTarget.dataset.status
    this.send_data.lead.council_type = `CRM`
    this.send_data.lead.council_number = this.councilInputTarget.value
    this.send_data.lead.council_state = this.councilStateInputTarget.value
    this.send_data.lead.prefix = this.prefixInputTarget.value
    this.send_data.lead.phone = this.getControllerByIdentifier("app--helpers--numbers").fromPhoneToNumber(this.phoneInputTarget.value)
    this.send_data.lead.notes = this.notesInputTarget.value
    this.send_data.lead.link = this.linkInputTarget.value

    this.send_data.current_user.current_user_id = this.application.current_user.id

    this.requestSave()
  }

  requestSave() {
    var url = "/commercial/sales/leads/entities/create"
    var method = "POST"
    const init = { method: method, credentials: "same-origin", headers: { "X-CSRF-Token": this.application.token, 'Content-Type': 'application/json' }, body: JSON.stringify(this.send_data) }
    var controller = this
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        if (response.save) {
          var lead = response.data.cln

          this.application.leads.forEach((element, i) => {
            if (element.id == lead.id) {
              this.application.leads.splice(this.application.leads.indexOf(element), 1, lead)
            }
          })

          controller.getControllerByIdentifier(`commercial--sales--leads--entities--index`).doDataTable()
          controller.cancelSave()
        }
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar(response.type, response.message, 2000)
      })
      .catch(error => {
        controller.getControllerByIdentifier("app--helpers--console").console(error)
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar("danger", controller.getControllerByIdentifier("app--shared--messages").generalError(), 3000)
      })
  }

  refreshSaveBtn() {
    var controller = this
    this.refreshTimer = setInterval(function () {
      var len = 0

      if (controller.nameInputTarget.value == ``) {
        len += 1
      }

      if (controller.emailInputTarget.value == ``) {
        len += 1
      }

      if (controller.councilInputTarget.value == ``) {
        len += 1
      }
      if (controller.councilStateInputTarget.value == ``) {
        len += 1
      }

      if (controller.prefixInputTarget.value == ``) {
        len += 1
      }
      if (controller.phoneInputTarget.value == ``) {
        len += 1
      }

      if (controller.sourceInputTarget.innerText == ``) {
        len += 1
      }

      if (controller.statusInputTarget.innerText == ``) {
        len += 1
      }

      if (controller.notesInputTarget.value == ``) {
        len += 1
      }

      if (len == 0) {
        controller.saveBtnTarget.disabled = false
      } else {
        controller.saveBtnTarget.disabled = true
      }
    }, 200);
  }

  stopRefreshing() {
    if (this.refreshTimer) {
      clearInterval(this.refreshTimer)
    }
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
