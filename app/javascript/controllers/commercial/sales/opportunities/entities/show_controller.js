import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["main", "token", "info", "listLeads", "listProducts", "opportunityProspector", "opportunityProspectorName", "opportunityProspectorEdit",
                    "opportunityProspectorInput", "prospectorFilter", "prospectorFilterItem", "opportunityCloser", "opportunityCloserName",
                    "opportunityCloserEdit", "opportunityCloserInput", "closerFilter", "closerFilterItem", "opportunityStage", "opportunityStageName",
                    "opportunityStageEdit", "opportunityStageInput", "stageFilter", "stageFilterItem", "opportunityStartedAt", "opportunityOpenDays", "opportunityStatus",
                    "opportunityStatus", "opportunityStatusName", "opportunityStatusEdit", "opportunityStatusInput", "statusFilter", "statusFilterItem"]

  connect() {
    this.loader = this.getControllerByIdentifier("app--helpers--loaders").loader()
    this.controllerName = `commercial--sales--opportunities--entities--show`
    this.doGridHtml()
    this.application.opportunity_token = location.pathname.split("/").pop()
    this.getOpportunity()
  }

  addNewOpportunity() {
    this.getControllerByIdentifier("commercial--sales--opportunities--entities--save").current_lead = {}
    this.getControllerByIdentifier("commercial--sales--opportunities--entities--save").doFormHtml()
  }

  doGridHtml() {
    var html = `<div class="row">
                  <div class="col-2 text-center px-2">
                    <h6 class="mb-0 text-center">SDR</h6>
                    <hr class="my-1">
                    <span class="f-065 pointer" data-target="${this.controllerName}.opportunityProspector">
                      ${this.loader}
                    </span>
                  </div>
                  <div class="col-2 text-center px-2">
                    <h6 class="mb-0 text-center">Closer</h6>
                    <hr class="my-1">
                    <span class="f-065 pointer" data-target="${this.controllerName}.opportunityCloser">
                      ${this.loader}
                    </span>
                  </div>
                  <div class="col-2 text-center px-2">
                    <h6 class="mb-0 text-center">Estágio</h6>
                    <hr class="my-1">
                    <span class="f-065 pointer" data-target="${this.controllerName}.opportunityStage">
                      ${this.loader}
                    </span>
                  </div>
                  <div class="col-2 text-center px-2">
                    <h6 class="mb-0 text-center">Status</h6>
                    <hr class="my-1">
                    <span class="f-065 pointer" data-target="${this.controllerName}.opportunityStatus">
                      ${this.loader}
                    </span>
                  </div>
                  <div class="col-2 text-center px-2">
                    <h6 class="mb-0 text-center">Data Início</h6>
                    <hr class="my-1">
                    <span class="f-065 pointer" data-target="${this.controllerName}.opportunityStartedAt">
                      ${this.loader}
                    </span>
                  </div>
                  <div class="col-2 text-center px-2">
                    <h6 class="mb-0 text-center">Dias em Aberto</h6>
                    <hr class="my-1">
                    <span class="f-065 pointer" data-target="${this.controllerName}.opportunityOpenDays">
                      ${this.loader}
                    </span>
                  </div>
                </div>
                <div class="row my-5">
                  <div class="col-2 px-2">
                    <div class="row">
                      <div class="col-12 px-0">
                        <h6 class="mb-0 d-flex align-items-center">
                          <span>Médicos</span>
                          <span class="mc-tooltip ml-auto pointer" data-action="click->${this.controllerName}#addLead">
                             <span class="material-icons md-sm md-dark">add</span>
                             <span class="mc-tooltiptext">Adicionar Médico</span>
                           </span>
                        </h6>
                        <hr class="my-1">
                      </div>
                    </div>
                    <div class="row" data-target="${this.controllerName}.listLeads">
                      <span>${this.loader}</span>
                    </div>
                    <div class="row" style="margin-top:12rem;">
                      <div class="col-12 px-0">
                        <h6 class="mb-0 d-flex align-items-center">
                          <span>Produtos</span>
                          <span class="mc-tooltip ml-auto pointer" data-action="click->${this.controllerName}#addProduct">
                             <span class="material-icons md-sm md-dark">add</span>
                             <span class="mc-tooltiptext">Adicionar Produto</span>
                           </span>
                        </h6>
                        <hr class="my-1">
                      </div>
                    </div>
                    <div class="row" data-target="${this.controllerName}.listProducts">
                      <span>${this.loader}</span>
                    </div>
                  </div>
                  <div class="col-5 px-2">
                    <h6 class="mb-0 d-flex align-items-center">
                      <span>Tickets</span>
                      <span class="mc-tooltip ml-auto pointer" data-action="click->${this.controllerName}#addTicket">
                          <span class="material-icons md-sm md-dark">add</span>
                          <span class="mc-tooltiptext">Adicionar Ticket</span>
                        </span>
                    </h6>
                    <hr class="my-1">
                    <span>${this.loader}</span>
                  </div>
                  <div class="col-5 px-2">
                    <h6 class="mb-0 d-flex align-items-center">
                      <span>Anotações</span>
                      <span class="mc-tooltip ml-auto pointer" data-action="click->${this.controllerName}#addTicket">
                          <span class="material-icons md-sm md-dark">add</span>
                          <span class="mc-tooltiptext">Adicionar Anotação</span>
                        </span>
                    </h6>
                    <hr class="my-1">
                    <span>${this.loader}</span>
                  </div>
                </div>`

    this.mainTarget.innerHTML = html
  }

  getOpportunity() {
    var data = { opportunity: { token: this.application.opportunity_token }, current_user: { current_user_id: this.application.current_user.id } }
    const url = "/commercial/sales/opportunities/entities/read"
    const init = { method: "POST", credentials: "same-origin", headers: { "X-CSRF-Token": this.application.token, 'Content-Type': 'application/json' }, body: JSON.stringify(data) }
    var controller = this
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        console.log(response)
        if (response.process) {
          controller.application.opportunity = response.data.cln
          // controller.application.domain_type = "Oportunidade Negócio"
          // controller.application.domain.type = "Oportunidade Negócio"
          // controller.application.domain.id = controller.application.opportunity.id
          // controller.getControllerByIdentifier(`app--navigation--desktop--breadcrumb`).breadcrumbNameTarget.innerText = controller.application.booking.account_name
          controller.setPageTitle()
          controller.setPageHeader()
          

          controller.setLeads()
          controller.setProducts()
        } else {
          controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar(response.type, response.message, 2000)
        }
      })
      .catch(error => {
        controller.getControllerByIdentifier("app--helpers--console").console(error)
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar("danger", controller.getControllerByIdentifier("app--shared--messages").generalError(), 3000)
      })
  }

  setPageTitle() {
    this.tokenTarget.innerText = this.application.opportunity.token
    this.infoTarget.innerText = `Valor Total: ${this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(this.application.opportunity.total_amount * 100))}`
    this.infoTarget.innerText += ` | Total Médicos: ${this.application.opportunity.total_leads}`
    this.infoTarget.innerText += ` | Fonte Primária: ${this.application.opportunity.source_pretty}`
  }

  setPageHeader() {
    this.setProspector()
    this.setCloser()
    this.setStage()
    this.setStatus()
    this.setStartedAt()
    this.setOpenDays()
  }

  showInlineEditor(ev) {
    ev.currentTarget.classList.add("d-none")
    ev.currentTarget.nextElementSibling.classList.remove("d-none")
  }

  hideInlineEditor(ev) {
    ev.currentTarget.closest(".editInput").classList.add("d-none")
    ev.currentTarget.closest(".editInput").previousElementSibling.classList.remove("d-none")
  }

  setProspector() {

    if (this.application.opportunity.prospector_id == null || this.application.opportunity.prospector_id == undefined) {
      this.application.opportunity.prospector_name = `Não Definido`
    }

    var html = `<div class="row d-flex align-items-center">
                    <div class="col-12 px-0 pointer mc-tooltip text-center" data-target="${this.controllerName}.opportunityProspectorName" data-action="click->${this.controllerName}#showInlineEditor">
                      ${this.application.opportunity.prospector_name}
                    </div>
                    <div class="col-12 px-1 d-flex align-items-center d-none editInput" data-target="${this.controllerName}.opportunityProspectorEdit">
                      <div class="form-group w-100 mb-0">
                        <input class="form-control f-075 pt-0" autofocus data-target="${this.controllerName}.opportunityProspectorInput" data-filter-mode="simple" data-action="focus->${this.controllerName}#prospectorFilter keyup->${this.controllerName}#prospectorFilter blur->${this.controllerName}#hideList" type="text" placeholder="Prospector" required>
                        <ul class="ul-filter filter-list d-none w-75" style="z-index:1" data-target="${this.controllerName}.prospectorFilter"></ul>
                      </div>
                      <div class="ml-3 mb-0">
                        <button data-target="${this.controllerName}.cancelBtn" data-action="click->${this.controllerName}#hideInlineEditor" type="button" class="btn btn-sm btn-table p-0 mc-tooltip">
                          <span aria-hidden="true">&times;</span>
                          <span class="mc-tooltiptext">Cancelar</span>
                        </button>
                      </div>
                    </div>
                  </div>`
    


    this.opportunityProspectorTarget.innerHTML = html
    this.listProspector()
  }

  listProspector() {
    this.application.users = [{ id: 1, nickname: "Gustavo Bonfim" }, { id: 2, nickname: "Breno Morais" }, { id: 3, nickname: "Bruna Correa" }]


    var html = ``
    this.application.users.forEach(element => {
      html += `<li data-action="click->${this.controllerName}#selectProspector" data-target="${this.controllerName}.prospectorFilterItem" data-text="${element.nickname}" data-filter="${element.id}" class="li-selector dark f-065">${element.nickname}</li>`
    })

    this.prospectorFilterTarget.innerHTML = html
  }

  prospectorFilter(ev) {
    this.getControllerByIdentifier("app--helpers--input").filterList(ev, 2)
  }  

  selectProspector(ev) {
    this.getControllerByIdentifier("app--helpers--input").selectItem(ev)
    this.send_data = { current_user: {}, opportunity: {} }

    this.send_data.current_user.current_user_id = this.application.current_user.id

    this.send_data.opportunity.id = this.application.opportunity.id
    this.send_data.opportunity.prospector_id = this.opportunityProspectorInputTarget.dataset.filter
    this.send_data.opportunity.prospector_name = this.opportunityProspectorInputTarget.dataset.text
    
    this.requestSaveOpportunity()
  }

  setCloser() {

    if (this.application.opportunity.closer_id == null || this.application.opportunity.closer_id == undefined) {
      this.application.opportunity.closer_name = `Não Definido`
    }

    var html = `<div class="row d-flex align-items-center">
                    <div class="col-12 px-0 pointer mc-tooltip text-center" data-target="${this.controllerName}.opportunityCloserName" data-action="click->${this.controllerName}#showInlineEditor">
                      ${this.application.opportunity.closer_name}
                    </div>
                    <div class="col-12 px-1 d-flex align-items-center d-none editInput" data-target="${this.controllerName}.opportunityCloserEdit">
                      <div class="form-group w-100 mb-0">
                        <input class="form-control f-075 pt-0" autofocus data-target="${this.controllerName}.opportunityCloserInput" data-filter-mode="simple" data-action="focus->${this.controllerName}#closerFilter keyup->${this.controllerName}#closerFilter blur->${this.controllerName}#hideList" type="text" placeholder="Closer" required>
                        <ul class="ul-filter filter-list d-none w-75" style="z-index:1" data-target="${this.controllerName}.closerFilter"></ul>
                      </div>
                      <div class="ml-3 mb-0">
                        <button data-target="${this.controllerName}.cancelBtn" data-action="click->${this.controllerName}#hideInlineEditor" type="button" class="btn btn-sm btn-table p-0 mc-tooltip">
                          <span aria-hidden="true">&times;</span>
                          <span class="mc-tooltiptext">Cancelar</span>
                        </button>
                      </div>
                    </div>
                  </div>`



    this.opportunityCloserTarget.innerHTML = html
    this.listCloser()
  }

  listCloser() {
    this.application.users = [{ id: 1, nickname: "Gustavo Bonfim" }, { id: 2, nickname: "Breno Morais" }, { id: 3, nickname: "Bruna Correa" }]


    var html = ``
    this.application.users.forEach(element => {
      html += `<li data-action="click->${this.controllerName}#selectCloser" data-target="${this.controllerName}.closerFilterItem" data-text="${element.nickname}" data-filter="${element.id}" class="li-selector dark f-065">${element.nickname}</li>`
    })

    this.closerFilterTarget.innerHTML = html
  }

  closerFilter(ev) {
    this.getControllerByIdentifier("app--helpers--input").filterList(ev, 2)
  }

  selectCloser(ev) {
    this.getControllerByIdentifier("app--helpers--input").selectItem(ev)

    this.send_data = { current_user: {}, opportunity: {} }

    this.send_data.current_user.current_user_id = this.application.current_user.id

    this.send_data.opportunity.id = this.application.opportunity.id
    this.send_data.opportunity.closer_id = this.opportunityCloserInputTarget.dataset.filter
    this.send_data.opportunity.closer_name = this.opportunityCloserInputTarget.dataset.text

    this.requestSaveOpportunity()
  }

  setStage() {

    var html = `<div class="row d-flex align-items-center">
                    <div class="col-12 px-0 pointer mc-tooltip text-center" data-target="${this.controllerName}.opportunityStageName" data-action="click->${this.controllerName}#showInlineEditor">
                      ${this.application.opportunity.stage_pretty}
                    </div>
                    <div class="col-12 px-1 d-flex align-items-center d-none editInput" data-target="${this.controllerName}.opportunityStageEdit">
                      <div class="form-group w-100 mb-0">
                        <input class="form-control f-075 pt-0" autofocus data-target="${this.controllerName}.opportunityStageInput" data-filter-mode="simple" data-action="focus->${this.controllerName}#stageFilter keyup->${this.controllerName}#stageFilter blur->${this.controllerName}#hideList" type="text" placeholder="Estágio" required>
                        <ul class="ul-filter filter-list d-none w-75" style="z-index:1" data-target="${this.controllerName}.stageFilter"></ul>
                      </div>
                      <div class="ml-3 mb-0">
                        <button data-target="${this.controllerName}.cancelBtn" data-action="click->${this.controllerName}#hideInlineEditor" type="button" class="btn btn-sm btn-table p-0 mc-tooltip">
                          <span aria-hidden="true">&times;</span>
                          <span class="mc-tooltiptext">Cancelar</span>
                        </button>
                      </div>
                    </div>
                  </div>`



    this.opportunityStageTarget.innerHTML = html
    this.listStage()
  }

  listStage() {

    var html = `<li data-action="click->${this.controllerName}#selectStage" data-target="${this.controllerName}.stageFilterItem" data-text="Prospecção" data-filter="prospecting" class="li-selector dark f-065">Prospecção</li>
                <li data-action="click->${this.controllerName}#selectStage" data-target="${this.controllerName}.stageFilterItem" data-text="Qualificação" data-filter="qualification" class="li-selector dark f-065">Qualificação</li>
                <li data-action="click->${this.controllerName}#selectStage" data-target="${this.controllerName}.stageFilterItem" data-text="Agendamento" data-filter="booking" class="li-selector dark f-065">Agendamento</li>
                <li data-action="click->${this.controllerName}#selectStage" data-target="${this.controllerName}.stageFilterItem" data-text="Consultoria" data-filter="meeting" class="li-selector dark f-065">Consultoria</li>
                <li data-action="click->${this.controllerName}#selectStage" data-target="${this.controllerName}.stageFilterItem" data-text="Proposta" data-filter="proposal" class="li-selector dark f-065">Proposta</li>
                <li data-action="click->${this.controllerName}#selectStage" data-target="${this.controllerName}.stageFilterItem" data-text="Fechamento" data-filter="closing" class="li-selector dark f-065">Fechamento</li>
                <li data-action="click->${this.controllerName}#selectStage" data-target="${this.controllerName}.stageFilterItem" data-text="Ganho" data-filter="gain" class="li-selector dark f-065">Ganho</li>
                <li data-action="click->${this.controllerName}#selectStage" data-target="${this.controllerName}.stageFilterItem" data-text="Perdido" data-filter="lost" class="li-selector dark f-065">Perdido</li>`

    this.stageFilterTarget.innerHTML = html
  }

  stageFilter(ev) {
    this.getControllerByIdentifier("app--helpers--input").filterList(ev, 2)
  }

  selectStage(ev) {
    var r = confirm(`Confirma o novo estágio de ${ev.currentTarget.dataset.text} para a Oportunidade?`)

    if (r) {
      this.getControllerByIdentifier("app--helpers--input").selectItem(ev)

      this.send_data = { current_user: {}, journey: {} }

      this.send_data.current_user.current_user_id = this.application.current_user.id

      this.send_data.journey.opportunity_id = this.application.opportunity.id
      this.send_data.journey.stage = this.opportunityStageInputTarget.dataset.filter
      this.send_data.journey.date = new Date()

      this.requestSaveJourney()
    } else {
      this.setStage()
    }
  }

  setStatus() {

    var html = `<div class="row d-flex align-items-center">
                    <div class="col-12 px-0 pointer mc-tooltip text-center" data-target="${this.controllerName}.opportunityStatusName" data-action="click->${this.controllerName}#showInlineEditor">
                      ${this.application.opportunity.status_pretty}
                    </div>
                    <div class="col-12 px-1 d-flex align-items-center d-none editInput" data-target="${this.controllerName}.opportunityStatusEdit">
                      <div class="form-group w-100 mb-0">
                        <input class="form-control f-075 pt-0" autofocus data-target="${this.controllerName}.opportunityStatusInput" data-filter-mode="simple" data-action="focus->${this.controllerName}#statusFilter keyup->${this.controllerName}#statusFilter blur->${this.controllerName}#hideList" type="text" placeholder="Status" required>
                        <ul class="ul-filter filter-list d-none w-75" style="z-index:1" data-target="${this.controllerName}.statusFilter"></ul>
                      </div>
                      <div class="ml-3 mb-0">
                        <button data-target="${this.controllerName}.cancelBtn" data-action="click->${this.controllerName}#hideInlineEditor" type="button" class="btn btn-sm btn-table p-0 mc-tooltip">
                          <span aria-hidden="true">&times;</span>
                          <span class="mc-tooltiptext">Cancelar</span>
                        </button>
                      </div>
                    </div>
                  </div>`



    this.opportunityStatusTarget.innerHTML = html
    this.listStatus()
  }

  listStatus() {
    
    var html = `<li data-action="click->${this.controllerName}#selectStatus" data-target="${this.controllerName}.statusFilterItem" data-text="Quente" data-filter="hot" class="li-selector dark f-065">Quente</li>
                <li data-action="click->${this.controllerName}#selectStatus" data-target="${this.controllerName}.statusFilterItem" data-text="Morno" data-filter="warn" class="li-selector dark f-065">Morno</li>
                <li data-action="click->${this.controllerName}#selectStatus" data-target="${this.controllerName}.statusFilterItem" data-text="Frio" data-filter="cold" class="li-selector dark f-065">Frio</li>`

    this.statusFilterTarget.innerHTML = html
  }

  statusFilter(ev) {
    this.getControllerByIdentifier("app--helpers--input").filterList(ev, 2)
  }

  selectStatus(ev) {
    this.getControllerByIdentifier("app--helpers--input").selectItem(ev)
    this.send_data = { current_user: {}, opportunity: {} }

    this.send_data.current_user.current_user_id = this.application.current_user.id

    this.send_data.opportunity.id = this.application.opportunity.id
    this.send_data.opportunity.status = this.opportunityStatusInputTarget.dataset.filter

    this.requestSaveOpportunity()
  }

  setStartedAt() {
    this.opportunityStartedAtTarget.innerText = this.application.opportunity.started_at_pretty
  }

  setOpenDays() {
    if (this.application.opportunity.open_days == 1) {
      this.opportunityOpenDaysTarget.innerText = `${this.application.opportunity.open_days} dia`
    } else {
      this.opportunityOpenDaysTarget.innerText = `${this.application.opportunity.open_days} dias`
    }
  }

  hideList(ev) {
    // this.getControllerByIdentifier("app--helpers--input").hideList(ev)
  }

  setLeads() {
    // `<button class="card-show-dropbtn">${element.lead_name}</button>`
    var html = ``
    this.application.opportunity.leads.forEach(element => {
      html += `<div class="row my-2 w-100" data-id="${element.id}" data-target="${this.controllerName}.card-${element.id}">
                  <div class="col-12 px-1">
                    <div class="card">
                      <div class="card-body px-0 py-2 f-065 text-center pointer">
                        <div class="row my-2">
                          <div class="col-12">
                            <div class="card-show-dropdown">
                              ${element.lead_name}
                              <div class="card-show-dropdown-content text-left">
                                <p class="mb-0 f-065">${element.lead_phone}</p>
                                <p class="mb-0 f-065">${element.lead_email}</p>
                                <p class="mb-0 f-065">${element.lead_council}</p>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>`      
    })


    this.listLeadsTarget.innerHTML = html
  }

  setProducts() {
    var html = ``
    this.application.opportunity.products.forEach(element => {
      html += `<div class="row my-2 w-100" data-id="${element.id}" data-target="${this.controllerName}.card-${element.id}">
                  <div class="col-12 px-1">
                    <div class="card">
                      <div class="card-body px-0 py-2 pb-0 f-065 pointer text-center">
                        <div class="row my-2">
                          <div class="col-12">
                            <div class="card-show-dropdown">
                              ${element.name_pretty}
                              <div class="card-show-dropdown-content text-left">
                                <p class="mb-0 f-065">${element.kind_pretty}</p>
                                <p class="mb-0 f-065">${element.plan_pretty}</p>
                                <p class="mb-0 f-065">${this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(element.amount * 100))}</p>
                              </div>
                            </div>
                          </div>
                          
                        </div>
                      </div>
                    </div>
                  </div>
                </div>`
    })


    this.listProductsTarget.innerHTML = html
  }

  requestSaveOpportunity() {
    var url = "/commercial/sales/opportunities/entities/update"
    var method = "PUT"
    const init = { method: method, credentials: "same-origin", headers: { "X-CSRF-Token": this.application.token, 'Content-Type': 'application/json' }, body: JSON.stringify(this.send_data) }
    var controller = this
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        if (response.save) {
          this.application.opportunity = response.data.cln
          controller.setPageHeader()
        }
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar(response.type, response.message, 2000)
      })
      .catch(error => {
        controller.getControllerByIdentifier("app--helpers--console").console(error)
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar("danger", controller.getControllerByIdentifier("app--shared--messages").generalError(), 3000)
      })
  }

  requestSaveJourney() {
    var url = "/commercial/sales/opportunities/journeys/create"
    var method = "POST"
    const init = { method: method, credentials: "same-origin", headers: { "X-CSRF-Token": this.application.token, 'Content-Type': 'application/json' }, body: JSON.stringify(this.send_data) }
    var controller = this
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        if (response.save) {
          var journey = response.data.cln
          this.application.opportunity.stage = journey.stage
          this.application.opportunity.stage_pretty = journey.stage_pretty
        }
        controller.setPageHeader()
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar(response.type, response.message, 2000)
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
