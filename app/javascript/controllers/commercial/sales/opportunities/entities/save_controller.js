import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["main", "viewTitle", "saveBtn", "sourceDropdown", "sourceDropdownBtn", "sourceInput", "sourceList", "nameInput",
                    "startedAtInput", "stageDropdown", "stageDropdownBtn", "stageInput", "stageList", "notesInput"]

  connect() {
    this.controllerName = `commercial--sales--opportunities--entities--save`
  }

  doFormHtml() {

    // if (this.application.permissions.medfiling_files.can_create) {
      var saveBtnHtml = `<button disabled type="button" class="btn btn-primary btn-sm btn-table f-065" data-action="click->${this.controllerName}#saveOpportunity" data-target="${this.controllerName}.saveBtn">Salvar</button>`
    // } else {
    //   var saveBtnHtml = ``
    // }

    var html = `<div class="card" style="width:100%;display:relative;" data-target="${this.controllerName}.main">
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
                            <label for="startedAtForm">Data Início</label>
                            <input aria-describedby="startedAtFormHelp" class="form-control" id="startedAtForm" data-target="${this.controllerName}.startedAtInput" placeholder="Data Início" type="text" required>
                          </div>
                        </div>
                      </div>
                    </div>
                    
                    <div class="row my-2">
                      <div class="col-4 pl-0 pr-2">
                        <div class="form-group">
                          <div class="floating-label floating-label-sm">
                            <label>Fonte</label>
                            <div class="dropdown dropdown-selector" data-controller="app--helpers--search app--helpers--selector" data-target="app--helpers--selector.dropdown ${this.controllerName}.sourceDropdown">
                              <button class="dropdown-toggle form-control d-flex" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="height:32px;" data-target="app--helpers--selector.btn ${this.controllerName}.sourceDropdownBtn"><span class="mr-auto w-100 selected-item" data-target="app--helpers--selector.input ${this.controllerName}.sourceInput"></span></button>
                              <div class="dropdown-menu dropdown-menu-selector w-100 box-shadow-selector">
                                <input class="form-control form-control-selector" data-target="app--helpers--search.searchInput" data-action="keyup->app--helpers--search#doSearchList" type="text" placeholder="Buscar ...">
                                <ul class="ul-select" data-target="${this.controllerName}.sourceList app--helpers--search.searchList">
                                  <li data-source="base" data-action="click->app--helpers--selector#select" data-target="app--helpers--selector.select" class="li-selector dark f-065">Base</li>
                                  <li data-source="referrer" data-action="click->app--helpers--selector#select" data-target="app--helpers--selector.select" class="li-selector dark f-065">Indicação</li>
                                  <li data-source="landing" data-action="click->app--helpers--selector#select" data-target="app--helpers--selector.select" class="li-selector dark f-065">Landing</li>
                                  <li data-source="event" data-action="click->app--helpers--selector#select" data-target="app--helpers--selector.select" class="li-selector dark f-065">Evento</li>
                                </ul>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="col-4 px-2">
                        <div class="form-group">
                          <div class="floating-label floating-label-sm">
                            <label>Estágio</label>
                            <div class="dropdown dropdown-selector" data-controller="app--helpers--search app--helpers--selector" data-target="app--helpers--selector.dropdown ${this.controllerName}.stageDropdown">
                              <button class="dropdown-toggle form-control d-flex" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="height:32px;" data-target="app--helpers--selector.btn ${this.controllerName}.stageDropdownBtn"><span class="mr-auto w-100 selected-item" data-target="app--helpers--selector.input ${this.controllerName}.stageInput"></span></button>
                              <div class="dropdown-menu dropdown-menu-selector w-100 box-shadow-selector">
                                <input class="form-control form-control-selector" data-target="app--helpers--search.searchInput" data-action="keyup->app--helpers--search#doSearchList" type="text" placeholder="Buscar ...">
                                <ul class="ul-select" data-target="${this.controllerName}.stageList app--helpers--search.searchList">
                                  <li data-stage="prospecting" data-action="click->app--helpers--selector#select" data-target="app--helpers--selector.select" class="li-selector dark f-065">Prospecção</li>
                                  <li data-stage="qualification" data-action="click->app--helpers--selector#select" data-target="app--helpers--selector.select" class="li-selector dark f-065">Qualificação</li>
                                  <li data-stage="booking" data-action="click->app--helpers--selector#select" data-target="app--helpers--selector.select" class="li-selector dark f-065">Agendamento</li>
                                  <li data-stage="meeting" data-action="click->app--helpers--selector#select" data-target="app--helpers--selector.select" class="li-selector dark f-065">Consultoria</li>
                                  <li data-stage="proposal" data-action="click->app--helpers--selector#select" data-target="app--helpers--selector.select" class="li-selector dark f-065">Proposta</li>
                                  <li data-stage="closing" data-action="click->app--helpers--selector#select" data-target="app--helpers--selector.select" class="li-selector dark f-065">Fechamento</li>
                                </ul>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                     
                    </div>

                    <div class="row my-2">
                        <div class="col-12 px-2">
                          <div class="form-group">
                            <div class="floating-label floating-label-sm">
                              <label for="notesForm">Anotações</label>
                              <textarea aria-describedby="notesFormHelp" class="form-control textarea px-0" id="notesForm" data-target="${this.controllerName}.notesInput" placeholder="Anotações" type="text" required rows="4"></textarea>
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
      var date = new Date()

      if (controller.current_lead.id) {
        controller.viewTitleTarget.innerText = `Nova Oportunidade para ${this.current_lead.name}`

        controller.nameInputTarget.value = controller.current_lead.name
        controller.nameInputTarget.disabled = true

        controller.startedAtInputTarget.value = controller.getControllerByIdentifier("app--helpers--date").transformPrettyDate(date)
        controller.startedAtInputTarget.disabled = true

        controller.sourceInputTarget.innerText = controller.current_lead.primary_source_pretty
        controller.sourceInputTarget.dataset.source = controller.current_lead.primary_source
        controller.sourceDropdownTarget.value = controller.current_lead.primary_source
        controller.sourceDropdownBtnTarget.disabled = true

        controller.stageInputTarget.innerText = `Prospecção`
        controller.stageInputTarget.dataset.stage = `prospecting`
        controller.stageDropdownTarget.value = `prospecting`
        controller.stageDropdownBtnTarget.disabled = true

        controller.notesInputTarget.value = controller.current_lead.notes
      } else {
        controller.viewTitleTarget.innerText = `Nova Oportunidade`
        controller.getControllerByIdentifier("app--helpers--pickdate").pickWithLimit($(controller.startedAtInputTarget), "monthly", this.application.current_date.year, this.application.current_date.month)
      }

      controller.getControllerByIdentifier("app--helpers--forms").floatingLabel()
      controller.refreshSaveBtn()
    })
  }

  cancelSave() {
    this.stopRefreshing()
    this.getControllerByIdentifier("commercial--sales--opportunities--entities--view").doViewHtml()
  }

  saveOpportunity() {
    this.saveBtnTarget.disabled = true
    this.stopRefreshing()
    this.send_data = { current_user: {}, lead: {}, opportunity: {} }

    this.send_data.lead.id = this.current_lead.id

    this.send_data.opportunity.status = `hot`
    this.send_data.opportunity.stage = this.stageInputTarget.dataset.stage
    this.send_data.opportunity.source = this.sourceInputTarget.dataset.source
    this.send_data.opportunity.started_at = this.getControllerByIdentifier("app--helpers--date").transformFullDate(this.startedAtInputTarget.value)
    this.send_data.opportunity.notes = this.current_lead.notes

    this.send_data.current_user.current_user_id = this.application.current_user.id

    this.requestSave()
  }

  requestSave() {
    var url = "/commercial/sales/opportunities/entities/create"
    var method = "POST"
    const init = { method: method, credentials: "same-origin", headers: { "X-CSRF-Token": this.application.token, 'Content-Type': 'application/json' }, body: JSON.stringify(this.send_data) }
    var controller = this
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        if (response.save) {
          var opportunity = response.data.cln

          window.open(opportunity.url, `_self`)

          // var lead = response.data.cln
          // controller.application.leads.forEach((element, i) => {
          //   if (element.id == lead.id) {
          //     controller.application.leads.splice(controller.application.leads.indexOf(element), 1, lead)
          //   }
          // })
        }
        controller.getControllerByIdentifier("commercial--sales--leads--entities--index").doDataTable()
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar(response.type, response.message, 2000)
      })
      .catch(error => {
        controller.getControllerByIdentifier("app--helpers--console").console(error)
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar("danger", controller.getControllerByIdentifier("app--shared--messages").generalError(), 3000)
        controller.getControllerByIdentifier("commercial--sales--leads--entities--index").doDataTable()
      })
  }

  refreshSaveBtn() {
    var controller = this
    this.refreshTimer = setInterval(function () {
      var len = 0

      if (controller.nameInputTarget.value == ``) {
        len += 1
      }

      if (controller.startedAtInputTarget.value == ``) {
        len += 1
      }

      if (controller.sourceInputTarget.innerText == ``) {
        len += 1
      }

      if (controller.stageInputTarget.innerText == ``) {
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
