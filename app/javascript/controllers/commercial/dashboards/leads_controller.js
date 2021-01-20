import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["main", "view", "viewTitle", "form", "saveBtn", "nameInput", "emailInput", "councilInput", "councilStateInput",
                    "prefixInput", "phoneInput", "notesInput", "addNewLeadBtn", "checklist", "linkInput",
                    "sourceDropdown", "sourceDropdownBtn", "sourceInput", "sourceList", "statusDropdown", "statusDropdownBtn", "statusInput", "statusList",
                    "chekListName", "checkListDescriptionName", "checkListEmail", "checkListDescriptionEmail",
                    "checkListPhone", "checkListDescriptionPhone", "checkListCouncilState", "checkListDescriptionCouncilState",
                    "checkListSource", "checkListDescriptionSource", "checkListNotes", "checkListDescriptionNotes",
                    "checkListOffice", "checkListDescriptionOffice", "checkListSignature", "checkListDescriptionSignature",
                    "checkListCouncil", "checkListDescriptionCouncil", "checkListPrefix", "checkListDescriptionPrefix"]


  connect() {
    this.current_lead = {}
    this.loader = this.getControllerByIdentifier("app--helpers--loaders").loader()
    this.cardLoader = this.getControllerByIdentifier("app--helpers--loaders").cardLoader()
    this.controllerName = `commercial--dashboards--leads`
    this.doPageGrid()
  }

  doPageGrid() {
    this.stopRefreshing()
    var html = `<div class="row my-4">
                  <div class="col-4" data-controller="commercial--dashboards--sources--events" data-target="commercial--dashboards--sources--events.main"></div>
                  <div class="col-4" data-controller="commercial--dashboards--sources--landings" data-target="commercial--dashboards--sources--landings.main"></div>
                </div>
                <div class="row my-4">
                  <div class="col-4">
                    <div class="row">
                      <div class="col-12 px-0">
                        <div class="card" style="width:100%;display:relative;" data-target="${this.controllerName}.view">
                          <div class="card-header d-flex align-items-center card-header-table-list f-065">
                            <h6 class="card-title display-4" style="padding:1rem;font-size:110%;margin-bottom:0px;" data-target="${this.controllerName}.viewTitle">Selecione um Lead e gere um novo SQL</h6>
                            <div class="card-actions ml-auto py-0 mc-tooltip">
                              <button aria-expanded="false" aria-haspopup="true" class="btn btn-outline my-0" data-target="${this.controllerName}.addNewLeadBtn" data-action="click->${this.controllerName}#addNewLead" type="button">
                                <span class="material-icons">add</span>
                              </button>
                              <span class="mc-tooltiptext">Adicionar Novo Lead</span>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="row my-4" data-target="${this.controllerName}.checklist">
                    </div>
                  </div>
                  <div class="col-8" data-target="${this.controllerName}.form"></div>
                </div>`

    this.mainTarget.innerHTML = html 
  }

  addNewLead() {
    this.current_lead = {}
    this.doFormHtml()
  }

  doFormHtml() {

    // if (this.application.permissions.medfiling_files.can_create) {
    var saveBtnHtml = `<button disabled type="button" class="btn btn-primary btn-sm btn-table f-065" data-action="click->${this.controllerName}#saveSalesLead" data-target="${this.controllerName}.saveBtn">Salvar</button>`
    // } else {
    //   var saveBtnHtml = ``
    // }

    var html = `<div class="card" style="width:100%;display:relative;">
                  
                  <div class="card-body py-0" style="overflow:auto;" data-target="${this.controllerName}.formCardBody">
                    <div class="row my-2">
                      <div class="col-6 pl-0 pr-2">
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
                      </div>
                      <div class="col-6 pr-0 pl-2">
                        <div class="row my-2">
                          <div class="col-12">
                            <div class="form-group">
                              <div class="floating-label floating-label-sm">
                                <label for="linkForm">Link Minha MedCapital</label>
                                <input aria-describedby="linkFormHelp" class="form-control" id="linkForm" data-target="${this.controllerName}.linkInput" placeholder="Link Minha MedCapital" type="text" required>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="row my-2">
                          <div class="col-12">
                            <div class="form-group">
                              <div class="floating-label floating-label-sm">
                                <label for="notesForm">Anotações</label>
                                <textarea aria-describedby="notesFormHelp" class="form-control textarea px-0" id="notesForm" data-target="${this.controllerName}.notesInput" placeholder="Anotações" type="text" required rows="7"></textarea>
                              </div>
                            </div>
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
      resolve(controller.formTarget.innerHTML = html)
    }).then(() => {
      var date = new Date()

      if (controller.current_lead.id) {
        controller.viewTitleTarget.innerText = `Novo SQL: ${this.current_lead.name}`

        controller.nameInputTarget.value = controller.current_lead.name
        // controller.nameInputTarget.disabled = true

        controller.emailInputTarget.value = controller.current_lead.email
        // controller.emailInputTarget.disabled = true

        controller.councilInputTarget.value = controller.current_lead.crm
        // controller.councilInputTarget.disabled = true
        controller.councilStateInputTarget.value = controller.current_lead.crm_state
        // controller.councilStateInputTarget.disabled = true

        controller.prefixInputTarget.value = controller.current_lead.ddd
        // controller.prefixInputTarget.disabled = true
        controller.phoneInputTarget.value = controller.getControllerByIdentifier("app--helpers--numbers").phoneMask(controller.current_lead.number)
        // controller.phoneInputTarget.disabled = true

        controller.sourceInputTarget.innerText = controller.current_lead.source_pretty
        controller.sourceInputTarget.dataset.source = controller.current_lead.source
        controller.sourceInputTarget.dataset.sourceType = controller.current_lead.source_type
        controller.sourceDropdownTarget.value = controller.current_lead.source
        controller.sourceDropdownBtnTarget.disabled = true

      } else {
        controller.viewTitleTarget.innerText = `Novo SQL`
        controller.sourceInputTarget.innerText = ``
        controller.sourceInputTarget.dataset.source = ``
        controller.sourceDropdownTarget.value = ``
      }

      controller.statusInputTarget.innerText = `Não Contactado`
      controller.statusInputTarget.dataset.status = `not_contact`
      controller.statusDropdownTarget.value = `not_contact`
      controller.statusDropdownBtnTarget.disabled = true

      controller.getControllerByIdentifier("app--helpers--forms").floatingLabel()
      controller.refreshSaveBtn()
      controller.doCheckListHtml()
    })
  }

  doCheckListHtml() {
    var html = `<div class="col-6 d-flex align-items-center my-1">
                    <div class="custom-control custom-checkbox px-0">
                      <input disabled type="checkbox" class="custom-control-input" id="chekListName" data-target="${this.controllerName}.chekListName">
                      <label class="custom-control-label pointer" for="chekListName"></label>
                    </div>
                    <span class="f-065 ml-3" data-target="${this.controllerName}.checkListDescriptionName"></span>
                  </div>
                  <div class="col-6 d-flex align-items-center my-1">
                    <div class="custom-control custom-checkbox px-0">
                      <input disabled type="checkbox" class="custom-control-input" id="checkListEmail" data-target="${this.controllerName}.checkListEmail">
                      <label class="custom-control-label pointer" for="checkListEmail"></label>
                    </div>
                    <span class="f-065 ml-3" data-target="${this.controllerName}.checkListDescriptionEmail"></span>
                  </div>
                  <div class="col-6 d-flex align-items-center my-1">
                    <div class="custom-control custom-checkbox px-0">
                      <input disabled type="checkbox" class="custom-control-input" id="checkListCouncil" data-target="${this.controllerName}.checkListCouncil">
                      <label class="custom-control-label pointer" for="checkListCouncil"></label>
                    </div>
                    <span class="f-065 ml-3" data-target="${this.controllerName}.checkListDescriptionCouncil"></span>
                  </div>
                  <div class="col-6 d-flex align-items-center my-1">
                    <div class="custom-control custom-checkbox px-0">
                      <input disabled type="checkbox" class="custom-control-input" id="checkListPrefix" data-target="${this.controllerName}.checkListPrefix">
                      <label class="custom-control-label pointer" for="checkListPrefix"></label>
                    </div>
                    <span class="f-065 ml-3" data-target="${this.controllerName}.checkListDescriptionPrefix"></span>
                  </div>
                  <div class="col-6 d-flex align-items-center my-1">
                    <div class="custom-control custom-checkbox px-0">
                      <input disabled type="checkbox" class="custom-control-input" id="checkListCouncilState" data-target="${this.controllerName}.checkListCouncilState">
                      <label class="custom-control-label pointer" for="checkListCouncilState"></label>
                    </div>
                    <span class="f-065 ml-3" data-target="${this.controllerName}.checkListDescriptionCouncilState"></span>
                  </div>
                  <div class="col-6 d-flex align-items-center my-1">
                    <div class="custom-control custom-checkbox px-0">
                      <input disabled type="checkbox" class="custom-control-input" id="checkListPhone" data-target="${this.controllerName}.checkListPhone">
                      <label class="custom-control-label pointer" for="checkListPhone"></label>
                    </div>
                    <span class="f-065 ml-3" data-target="${this.controllerName}.checkListDescriptionPhone"></span>
                  </div>
                  <div class="col-6 d-flex align-items-center my-1">
                    <div class="custom-control custom-checkbox px-0">
                      <input disabled type="checkbox" class="custom-control-input" id="checkListSource" data-target="${this.controllerName}.checkListSource">
                      <label class="custom-control-label pointer" for="checkListSource"></label>
                    </div>
                    <span class="f-065 ml-3" data-target="${this.controllerName}.checkListDescriptionSource"></span>
                  </div>
                  <div class="col-6 d-flex align-items-center my-1">
                    <div class="custom-control custom-checkbox px-0">
                      <input disabled type="checkbox" class="custom-control-input" id="checkListNotes" data-target="${this.controllerName}.checkListNotes">
                      <label class="custom-control-label pointer" for="checkListNotes"></label>
                    </div>
                    <span class="f-065 ml-3" data-target="${this.controllerName}.checkListDescriptionNotes"></span>
                  </div>`


    this.checklistTarget.innerHTML = html
  }

  cancelSave() {
    this.stopRefreshing()
    this.viewTitleTarget.innerText = `Selecione um Lead e gere um novo SQL`
    this.formTarget.innerHTML = ``
    this.checklistTarget.innerHTML = ``
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
    this.send_data.source.source_id = this.current_lead.source_id
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
          controller.current_lead.sql = true
          controller.refreshLeadTables()
        }
        controller.cancelSave()
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar(response.type, response.message, 2000)
      })
      .catch(error => {
        controller.getControllerByIdentifier("app--helpers--console").console(error)
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar("danger", controller.getControllerByIdentifier("app--shared--messages").generalError(), 3000)
      })
  }

  refreshLeadTables() {

    if (this.current_lead.source == `event`) {
      var leads = this.getControllerByIdentifier("commercial--dashboards--sources--events").leads

      leads.forEach((element, i) => {
        if (element.id == this.current_lead.id) {
          leads.splice(leads.indexOf(element), 1, this.current_lead)
        }
      })

      this.getControllerByIdentifier("commercial--dashboards--sources--events").leads = leads
      this.getControllerByIdentifier("commercial--dashboards--sources--events").doDataTable()
    } else if (this.current_lead.source == `landing`) {
      var leads = this.getControllerByIdentifier("commercial--dashboards--sources--landings").leads

      leads.forEach((element, i) => {
        if (element.id == this.current_lead.id) {
          leads.splice(leads.indexOf(element), 1, this.current_lead)
        }
      })

      this.getControllerByIdentifier("commercial--dashboards--sources--landings").leads = leads
      this.getControllerByIdentifier("commercial--dashboards--sources--landings").doDataTable()
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

  layout() {
    var targets = ["mainCard"]
    var identifier = ""
    // this.getControllerByIdentifier("app--helpers--layout").resizeMainCard(targets, identifier)
  }

  refreshSaveBtn() {
    var controller = this
    this.refreshTimer = setInterval(function () {
      var len = 0

      if (controller.nameInputTarget.value == ``) {
        len += 1
        controller.chekListNameTarget.checked = false
        controller.checkListDescriptionNameTarget.innerHTML = `<span>Nome do Lead</span>`
      } else {
        controller.chekListNameTarget.checked = true
        controller.checkListDescriptionNameTarget.innerHTML = `<span><s>Nome do Lead</s></span>`
      }

      if (controller.emailInputTarget.value == ``) {
        len += 1
        controller.checkListEmailTarget.checked = false
        controller.checkListDescriptionEmailTarget.innerHTML = `<span>E-mail do Lead</span>`
      } else {
        controller.checkListEmailTarget.checked = true
        controller.checkListDescriptionEmailTarget.innerHTML = `<span><s>E-mail do Lead</s></span>`
      }

      if (controller.councilInputTarget.value == ``) {
        len += 1
        controller.checkListCouncilTarget.checked = false
        controller.checkListDescriptionCouncilTarget.innerHTML = `<span>Número do Conselho</span>`
      } else {
        controller.checkListCouncilTarget.checked = true
        controller.checkListDescriptionCouncilTarget.innerHTML = `<span><s>Número do Conselho</s></span>`
      }
      if (controller.councilStateInputTarget.value == ``) {
        len += 1
        controller.checkListCouncilStateTarget.checked = false
        controller.checkListDescriptionCouncilStateTarget.innerHTML = `<span>UF do Conselho</span>`
      } else {
        controller.checkListCouncilStateTarget.checked = true
        controller.checkListDescriptionCouncilStateTarget.innerHTML = `<span><s>UF do Conselho</s></span>`
      }

      if (controller.prefixInputTarget.value == ``) {
        len += 1
        controller.checkListPrefixTarget.checked = false
        controller.checkListDescriptionPrefixTarget.innerHTML = `<span>DDD</span>`
      } else {
        controller.checkListPrefixTarget.checked = true
        controller.checkListDescriptionPrefixTarget.innerHTML = `<span><s>DDD</s></span>`
      }
      if (controller.phoneInputTarget.value == ``) {
        len += 1
        controller.checkListPhoneTarget.checked = false
        controller.checkListDescriptionPhoneTarget.innerHTML = `<span>Telefone</span>`
      } else {
        controller.checkListPhoneTarget.checked = true
        controller.checkListDescriptionPhoneTarget.innerHTML = `<span><s>Telefone</s></span>`
      }

      if (controller.sourceInputTarget.innerText == ``) {
        len += 1
        controller.checkListSourceTarget.checked = false
        controller.checkListDescriptionSourceTarget.innerHTML = `<span>Fonte Primária</span>`
      } else {
        controller.checkListSourceTarget.checked = true
        controller.checkListDescriptionSourceTarget.innerHTML = `<span><s>Fonte Primária</s></span>`
      }

      if (controller.statusInputTarget.innerText == ``) {
        len += 1
      }

      if (controller.notesInputTarget.value == ``) {
        len += 1
        controller.checkListNotesTarget.checked = false
        controller.checkListDescriptionNotesTarget.innerHTML = `<span>Anotações</span>`
      } else {
        controller.checkListNotesTarget.checked = true
        controller.checkListDescriptionNotesTarget.innerHTML = `<span><s>Anotações</s></span>`
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

  onlyUnique(value, index, self) {
    return self.indexOf(value) === index;
  }

  // var controller = this
  // new Promise(function (resolve) {
  //   resolve()
  // }).then(() => {
  // }) 

}
