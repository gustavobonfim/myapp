import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["mainCard", "addTicketBtn", "ticketBoard", "resolvedBtn", "bodyShow", "bodyEdit", "bodyEditInput", "cancelDateBtn", "9999",
                    "dateShow", "dateShowDiv", "dateEdit", "dateEditInput", "saveDateBtn", "ticketCardBody", "collapseDate"]

  connect() {
    this.controllerName = `commercial--sales--opportunities--entities--tickets`
    this.canRequest = true
  }

  doDataTable() {
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
    this.ticketBoardTarget.innerHTML = ""
    if (data == undefined || data == [] || data.length == 0) {
      var noData = `<div class="row w-100" style="height:100px;">
                      <div class="col-12 px-0 d-flex align-items-center justify-content-center">
                        <span class="fa-stack fa-1x">
                          <i class="fas fa-list fa-stack-1x"></i>
                        </span>
                        <span class="f-075 align-middle">Não há Tickets em Aberto</span>
                      </div>
                    </div>`

      this.ticketBoardTarget.innerHTML = noData
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
        this.ticketBoardTarget.insertAdjacentHTML("beforeend", this.ticketPartial(elements))
      } else {
        data.forEach(element => {
          elements[elements.length] = element
          place += 1
          
          if (place > columns) {
            this.ticketBoardTarget.insertAdjacentHTML("beforeend", this.ticketPartial(elements))
            place = 1
            elements = []
            row += 1
          }
        })
        if (row == rows) {
          this.ticketBoardTarget.insertAdjacentHTML("beforeend", this.ticketPartial(elements))
        }
      }
      
    }

    // var bodyHeights = []
    // var maxHeight = 0
    // this.ticketCardBodyTargets.forEach(element => {
    //   if (element.offsetHeight > maxHeight) {
    //     maxHeight = element.offsetHeight  
    //   }
    //   bodyHeights[bodyHeights.length] = element.offsetHeight
    // })

    this.ticketCardBodyTargets.forEach(element => {
      element.style.height = 75 + `px`
    })
    

  }

  ticketPartial(elements) {
    var elementHtml = ``
    elements.forEach(element => {
      // if (this.application.permissions.medfiling_tickets.can_update && (element.stage == `in_process`)) {
        var resolvedBtnHtml = `<button type="button" class="btn btn-primary btn-sm btn-table f-065 p-1" data-action="click->${this.controllerName}#resolvedTicket" data-target="${this.controllerName}.resolvedBtn">Resolvido</button>`
      // } else {
      //   var resolvedBtnHtml = ``
      // }

      // if (this.application.permissions.medfiling_tickets.can_delete && (element.stage == `in_process`)) {
        var deleteBtnHtml = `<button type="button" class="btn btn-secondary btn-sm btn-table f-065 p-1" data-action="click->${this.controllerName}#cancelTicket">Cancelar</button>`
      // } else {
      //   var deleteBtnHtml = ``
      // }

      if (element.sharing == `internal`) {
        var sharingBtn = `<div class="col-2 mx-1 px-0 d-flex align-items-center justify-content-center mc-tooltip bg-shadow" data-action="click->${this.controllerName}#setNewSharing" data-sharing="external">
                            <span class="material-icons md-150 md-dark pointer">visibility_off</span>
                            <span class="mc-tooltiptext">Atividade ${element.sharing_pretty}</span>
                          </div>`
      } else if (element.sharing == `external`) {
        var sharingBtn = `<div class="col-2 mx-1 px-0 d-flex align-items-center justify-content-center mc-tooltip bg-shadow" data-action="click->${this.controllerName}#setNewSharing" data-sharing="internal">
                            <span class="material-icons md-150 md-dark pointer">visibility</span>
                            <span class="mc-tooltiptext">Atividade ${element.sharing_pretty}</span>
                          </div>`
      }

      // if (this.application.permissions.medfiling_tickets.can_update && (element.stage == `in_process`)) {
        var performerBtn = `<div class="col-2 mx-1 px-0 d-flex align-items-center justify-content-center mc-tooltip bg-shadow">
                              <span class="material-icons md-150 md-dark pointer" data-toggle="collapse" href="#collapsePerformer-${element.id}" data-ticket-id="${element.id}">person</span>
                              <span class="mc-tooltiptext">Executor da Atividade</span>
                            </div>`

        var performerBody = `<div id="collapsePerformer-${element.id}" class="collapse" data-ticket-id="${element.id}" data-target="${this.controllerName}.performerCollapse-${element.id}">
                              <div class="card m-1">
                                <div class="card-footer p-0">
                                  <div class="row p-1 d-flex align-items-center">
                                    <div class="col-12 px-0 d-flex align-items-center pointer f-065 mc-tooltip" data-target="${this.controllerName}.performerNameShow-${element.id}" data-action="click->${this.controllerName}#inlineEditPerformerName">
                                      ${element.performer_name}
                                      <span class="mc-tooltiptext">Responsável</span>
                                    </div>
                                    <div class="col-12 px-1 d-flex align-items-center d-none" data-target="${this.controllerName}.performerNameEdit-${element.id}">
                                      <div class="form-group w-100">
                                        <div class="floating-label floating-label-sm">
                                          <label for="performerNameForm-${element.id}">Nome Responsável</label>
                                          <input id="performerNameForm-${element.id}" aria-describedby="performerNameForm-${element.id}-Help" class="form-control f-075" autofocus data-target="${this.controllerName}.performerNameEditInput-${element.id}" data-filter-mode="simple" data-action="focus->${this.controllerName}#performerNameFilter keyup->${this.controllerName}#performerNameFilter blur->${this.controllerName}#hideList" type="text" required>
                                          <ul class="ul-filter filter-list d-none w-100" style="z-index:1" data-target="${this.controllerName}.performerNameFilter-${element.id}"></ul>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>`
      // } else {
      //   var performerBtn = ``
      //   var performerBody = ``
      // }

      // if (this.application.permissions.medfiling_comments.can_index) {
        if (element.total_comments > 0) {
          var commentBadge = `<span class="badge badge-danger notice-badge" data-target="${this.controllerName}.totalComments-${element.id}">${element.total_comments}</span>`
        } else {
          var commentBadge = `<span class="badge badge-danger notice-badge d-none" data-target="${this.controllerName}.totalComments-${element.id}">${element.total_comments}</span>`
        }
        var commentBtn = `<div class="col-2 px-0 d-flex align-items-center justify-content-center mc-tooltip bg-shadow">
                            <span class="material-icons md-150 md-dark pointer" data-toggle="collapse" href="#collapseComments-${element.id}" data-ticket-id="${element.id}" data-action="click->${this.controllerName}#doCommentHtml">comment</span>
                            ${commentBadge}
                            <span class="mc-tooltiptext">Comentários</span>
                          </div>`

        var commentBody = `<div id="collapseComments-${element.id}" class="collapse" data-ticket-id="${element.id}" data-controller="operations--products--tax-filings--management--comment" data-target="operations--products--tax-filings--management--comment.collapse-${element.id}"></div>`
      // } else {
      //   var commentBtn = ``
      //   var commentBody = ``
      // }

      var dateBtn = `<div class="col-4 mr-auto px-1 d-flex align-items-center pointer bg-shadow mc-tooltip" data-toggle="collapse" href="#collapseDate-${element.id}" data-ticket-id="${element.id}">
                      <span>${element.due_at_pretty}</span>
                      <span class="mc-tooltiptext">Data de Entrega</span>
                    </div>`
      var dateBody = `<div id="collapseDate-${element.id}" class="collapse" data-ticket-id="${element.id}" data-target="${this.controllerName}.collapseDate-${element.id}">
                        <div class="card m-1">
                          <div class="card-footer p-0">
                            <div class="col-12 p-1 d-flex align-items-center pointer f-065" data-ticket-id="${element.id}" data-target="${this.controllerName}.dateShowDiv-${element.id}" data-action="click->${this.controllerName}#inlineEditDate">
                              <span data-target="${this.controllerName}.dateShow-${element.id}">${element.due_at_pretty}</span>
                              <span class="material-icons md-sm pointer ml-auto" data-action="click->${this.controllerName}#inlineEditDate">edit</span>
                            </div>
                            <div class="col-12 p-1 d-flex align-items-center d-none f-065" data-target="${this.controllerName}.dateEdit-${element.id}">
                              <input autofocus data-target="${this.controllerName}.dateEditInput-${element.id}" class="form-control p-1 f-065" type="text" required>
                              <span class="material-icons md-sm pointer mx-2" data-target="${this.controllerName}.saveDateBtn-${element.id}" data-action="click->${this.controllerName}#saveDate">save</span>
                            </div>
                          </div>
                        </div>
                      </div>`
      
      elementHtml += `<div class="col-6 px-1 my-2">
                        <div class="card border-top-primary border-flag-${element.flag}" data-id="${element.id}">
                          <div class="card-header p-1 text-center f-065 d-flex" style="height:40px;">
                            ${dateBtn}
                            ${performerBtn}
                            ${commentBtn}
                          </div>
                          <div class="card-body p-1 text-center f-065" data-target="${this.controllerName}.ticketCardBody">
                            <div class="row py-1 px-2">
                              <div class="col-12 px-0 d-flex align-items-center pointer text-left ticket-content" data-target="${this.controllerName}.bodyShow-${element.id}" data-action="click->${this.controllerName}#inlineEditBody">${element.body}</div>
                              <div class="col-12 px-1 d-flex align-items-center d-none" data-target="${this.controllerName}.bodyEdit-${element.id}">
                                <textarea autofocus data-target="${this.controllerName}.bodyEditInput-${element.id}" data-action="keyup->${this.controllerName}#saveBody change->${this.controllerName}#saveBody blur->${this.controllerName}#saveBody" class="form-control p-1 s-title-0p6rem" type="text" required></textarea>
                              </div>
                            </div>
                          </div>
                          <div class="card-footer border-top text-right py-1 px-2">
                            ${deleteBtnHtml}
                            ${resolvedBtnHtml}
                          </div>
                          ${dateBody}
                          ${performerBody}
                          ${commentBody}
                        </div>
                      </div>`
    })

    var html = elementHtml

    // svar html = `<div class="row my-2">
    // s              ${elementHtml}
    // s            </div>`

    return html
  }

  setNewSharing(ev) {
    if (ev.currentTarget.dataset.sharing == `external`) {
      var r = confirm(`Confirma o compartilhamento do Ticket? Se sim, o cliente receberá um email de aviso.`)
      if (r) {
        this.saveSharing(ev)  
      }
    } else {
      this.saveSharing(ev)
    }
  }

  saveSharing(ev) {
    this.send_data = { current_user: {}, ticket: {}, notification: {} }
    var ticketId = ev.currentTarget.closest(".card").dataset.id
    this.actionMode = `edit`
    this.send_data.ticket.id = ticketId
    this.send_data.ticket.sharing = ev.currentTarget.dataset.sharing
    this.send_data.current_user.current_user_id = this.application.current_user.id
    this.requestSave()
  }

  listPerformerName(id) {
    var html = ``
    this.application.users.forEach(element => {
      html += `<li data-performer-id="${id}" data-action="click->${this.controllerName}#selectPerformerName" data-target="${this.controllerName}.userNameFilterItem-${id}" data-text="${element.nickname}" data-filter="${element.id}" class="li-selector dark f-065">${element.nickname}</li>`
    })

    this.nameTarget(`performerNameFilter-${id}`).innerHTML = html
  }

  performerNameFilter(ev) {
    this.getControllerByIdentifier("app--helpers--input").filterList(ev, 2)
  }

  hideList(ev) {
    // this.getControllerByIdentifier("app--helpers--input").hideList(ev)
  }

  selectPerformerName(ev) {
    this.getControllerByIdentifier("app--helpers--input").selectItem(ev)
    this.savePerformerName(ev)
  }

  inlineEditPerformerName(ev) {
    var ticketId = ev.currentTarget.closest(".collapse").dataset.ticketId

    this.listPerformerName(ticketId)
    if (this.userCanUpdate()) {
      if (ev.type == "click") {
        var value = this.nameTarget(`performerNameShow-${ticketId}`).innerText
        this.nameTarget(`performerNameShow-${ticketId}`).classList.add("d-none")
        this.nameTarget(`performerNameEdit-${ticketId}`).classList.remove("d-none")
        this.nameTarget(`performerNameEditInput-${ticketId}`).value = value
        this.nameTarget(`performerNameEditInput-${ticketId}`).focus()
      } else {
        this.nameTarget(`performerNameShow-${ticketId}`).classList.remove("d-none")
        this.nameTarget(`performerNameEdit-${ticketId}`).classList.add("d-none")
      }
    }

    this.getControllerByIdentifier("app--helpers--forms").floatingLabel()
  }

  savePerformerName(ev) {
    this.send_data = { current_user: {}, ticket: {}, notification: {} }
    var ticketId = ev.currentTarget.closest(".collapse").dataset.ticketId

    var value = this.nameTarget(`performerNameEditInput-${ticketId}`).value.trim()

    if (value != this.nameTarget(`performerNameShow-${ticketId}`).innerText.trim()) {
      this.actionMode = `edit`

      this.send_data.ticket.id = ticketId
      this.send_data.ticket.performer_id = this.nameTarget(`performerNameEditInput-${ticketId}`).dataset.filter
      this.send_data.ticket.performer_name = this.nameTarget(`performerNameEditInput-${ticketId}`).dataset.text

      this.send_data.current_user.current_user_id = this.application.current_user.id
      this.requestSave()
    } else {
      var performer = { id: ticketId, performer_name: value }
      this.closeEditPerformerName(performer)
    }
  }

  closeEditPerformerName(performer) {
    this.nameTarget(`performerNameShow-${performer.id}`).classList.remove("d-none")
    this.nameTarget(`performerNameEdit-${performer.id}`).classList.add("d-none")
    this.nameTarget(`performerNameShow-${performer.id}`).innerText = performer.performer_name
  }

  doCommentHtml(ev) {
    var ticketId = ev.currentTarget.dataset.ticketId
    this.application.controllers.find(controller => {
      if (controller.context.identifier == `operations--products--tax-filings--management--comment` && controller.element.id == `collapseComments-${ticketId}`) {
        controller.ticket_id = ticketId
        controller.doCommentHtml()
      }
    })
  }

  inlineEditDate(ev) {
    var ticketId = ev.currentTarget.closest(".collapse").dataset.ticketId
    var date = new Date()
    if (this.userCanUpdate()) {
      if (ev.type == "click") {
        var value = this.nameTarget(`dateShow-${ticketId}`).innerText
        this.nameTarget(`dateShowDiv-${ticketId}`).classList.add("d-none")
        this.nameTarget(`dateEdit-${ticketId}`).classList.remove("d-none")
        this.nameTarget(`dateEditInput-${ticketId}`).value = value
        this.nameTarget(`dateEditInput-${ticketId}`).focus()
      } else {
        this.nameTarget(`dateShowDiv-${ticketId}`).classList.remove("d-none")
        this.nameTarget(`dateEdit-${ticketId}`).classList.add("d-none")
      }
    }
    
    this.getControllerByIdentifier("app--helpers--pickdate").pickOnlyFuture($(this.nameTarget(`dateEditInput-${ticketId}`)), "yearly", date.getFullYear())
  }

  cancelDate(ev) {
    var ticketId = ev.currentTarget.closest(".collapse").dataset.ticketId
    this.nameTarget(`dateShowDiv-${ticketId}`).classList.remove("d-none")
    this.nameTarget(`dateEdit-${ticketId}`).classList.add("d-none")
  }

  saveDate (ev) {
    var ticketId = ev.currentTarget.closest(".collapse").dataset.ticketId
    this.send_data = { current_user: {}, ticket: {}, notification: {} }
    this.nameTarget(`saveDateBtn-${ticketId}`).disabled = true
    this.actionMode = `edit`
    var value = this.getControllerByIdentifier("app--helpers--date").transformFullDate(this.nameTarget(`dateEditInput-${ticketId}`).value)
    
    if (value == `` || value == undefined) {
      this.cancelDate(ev)
      this.getControllerByIdentifier("app--helpers--snackbar").doSnackbar(`danger`, `A Data de Entrega não pode ficar em branco`, 2000)
    } else {
      this.send_data.ticket.id = ticketId
      this.send_data.ticket.due_at = value
      
      this.send_data.current_user.current_user_id = this.application.current_user.id
      
      this.requestSave()
      this.nameTarget(`dateShow-${ticketId}`).innerText = this.nameTarget(`dateEditInput-${ticketId}`).value
      this.cancelDate(ev)
    }
  }


  inlineEditBody(ev) {
    var ticketId = ev.currentTarget.closest(".card").dataset.id
    if (this.userCanUpdate()) {
      if (ev.type == "click") {
        var value = this.nameTarget(`bodyShow-${ticketId}`).innerText
        this.nameTarget(`bodyShow-${ticketId}`).classList.add("d-none")
        this.nameTarget(`bodyEdit-${ticketId}`).classList.remove("d-none")
        this.nameTarget(`bodyEditInput-${ticketId}`).value = value
        this.nameTarget(`bodyEditInput-${ticketId}`).focus()
      } else {
        this.nameTarget(`bodyShow-${ticketId}`).classList.remove("d-none")
        this.nameTarget(`bodyEdit-${ticketId}`).classList.add("d-none")
      }
    }
  }

  saveBody(ev) {
    var ticketId = ev.currentTarget.closest(".card").dataset.id
    this.actionMode = `edit`
    if ((ev.type == "keyup" && ev.key == "Escape" && ev.shiftKey == false)) {
      this.nameTarget(`bodyEditInput-${ticketId}`).value = this.nameTarget(`bodyShow-${ticketId}`).innerText
      this.inlineEditBody(ev)
    } else if ((ev.type == "keyup" && ev.key == "Enter" && ev.shiftKey == false) || (ev.type == "blur" && ev.target.parentElement.classList.contains("d-none") == false)) {
      var value = this.nameTarget(`bodyEditInput-${ticketId}`).value.trim().replace("\n", "")
      if (value == `` || value == undefined) {
        this.inlineEditBody(ev)
        this.getControllerByIdentifier("app--helpers--snackbar").doSnackbar(`danger`, `A Descrição não pode ficar em branco`, 2000)
      } else {
        this.inlineEditBody(ev)
        if (value != this.nameTarget(`bodyShow-${ticketId}`).innerText) {
          this.nameTarget(`bodyShow-${ticketId}`).innerText = value
          this.send_data = { current_user: {}, ticket: {}, notification: {} }
          
          this.send_data.ticket.id = ticketId
          this.send_data.ticket.body = value
          
          this.send_data.current_user.current_user_id = this.application.current_user.id
          
          this.requestSave()
        }
      }
    }
  }

  userCanUpdate() {
    return true
    var allowed = [this.ownerId, this.performerId]
    if (allowed.includes(currentUser.id) && this.stage != "done") {
      return true
    } else {
      return false
    }
  }

  cancelTicket(ev) {
    this.actionMode = `edit`
    var ticketId = ev.currentTarget.closest(".card").dataset.id
    var r = confirm("Confirma o cancelamento do Ticket?")
    if (r) {
      this.send_data = { current_user: {}, ticket: {}, notification: {} }
      ev.currentTarget.disabled = true

      this.send_data.ticket.id = ticketId
      this.send_data.ticket.active = false
      this.send_data.ticket.stage = `canceled`

      this.send_data.current_user.current_user_id = this.application.current_user.id

      this.requestSave()
    }
  }

  resolvedTicket(ev) {
    this.actionMode = `edit`
    var ticketId = ev.currentTarget.closest(".card").dataset.id
    var r = confirm("Confirma a resolução do Ticket?")
    if (r) {
      this.send_data = { current_user: {}, ticket: {}, notification: {} }
      ev.currentTarget.disabled = true
      
      this.send_data.ticket.id = ticketId
      this.send_data.ticket.stage = `resolved`
      this.send_data.ticket.finished_at = new Date()

      this.send_data.current_user.current_user_id = this.application.current_user.id

      this.requestSave()
    }
  }

  createTicket() {
    
    if (this.canRequest) {
      this.actionMode = `new`
      this.canRequest = false
      this.send_data = { current_user: {}, ticket: {}, notification: {} }

      this.send_data.ticket.opportunity_id = this.application.opportunity.id
      // this.send_data.ticket.board_id = this.application.opportunity.id
      this.send_data.ticket.board_type = `commercial_sales`
      this.send_data.ticket.board_name = this.application.opportunity.name
      this.send_data.ticket.date_id = this.application.current_date.id
      this.send_data.ticket.date_type = `commercial_dates`
      this.send_data.ticket.owner_id = this.application.current_user.id
      this.send_data.ticket.owner_name = `${this.application.current_user.name.split(" ").shift()} ${this.application.current_user.name.split(" ").pop()}`
      this.send_data.ticket.performer_id = this.application.current_user.id
      this.send_data.ticket.performer_name = `${this.application.current_user.name.split(" ").shift()} ${this.application.current_user.name.split(" ").pop()}`
      this.send_data.ticket.stage = `in_process`
      this.send_data.ticket.status = `in_time`
      this.send_data.ticket.sharing = `internal`
      this.send_data.ticket.term = `quick`
      this.send_data.ticket.priority = `low`
      this.send_data.ticket.body = `Novo Ticket`
      this.send_data.ticket.due_at = new Date()
      this.send_data.ticket.started_at = new Date()
      this.send_data.ticket.flag = `blue`

      this.send_data.current_user.current_user_id = this.application.current_user.id

      this.requestSave()
    }
  }

  requestSave() {
    if (this.actionMode == `new`) {
      var url = "/commercial/sales/opportunities/tickets/create"
      var method = "POST"
    } else {
      var url = "/commercial/sales/opportunities/tickets/update"
      var method = "PUT"
    }
    const init = { method: method, credentials: "same-origin", headers: { "X-CSRF-Token": this.application.token, 'Content-Type': 'application/json' }, body: JSON.stringify(this.send_data) }
    var controller = this
    fetch(url, init)
      .then(response => response.json())
      .then(response => {
        if (response.save) {
          var ticket = response.data.cln
          if (controller.actionMode == `new`) {
            controller.application.tickets[controller.application.tickets.length] = ticket
          } else {
            if (ticket.active) {
              controller.application.tickets.forEach((element, i) => {
                if (element.id == ticket.id) {
                  controller.application.tickets.splice(controller.application.tickets.indexOf(element), 1, ticket)
                }
              })
            } else {
              controller.application.tickets.forEach((element, i) => {
                if (element.id == ticket.id) {
                  controller.application.tickets.splice(controller.application.tickets.indexOf(element), 1)
                }
              })
            }
          }
          controller.doDataTable()
          controller.canRequest = true
        }
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar(response.type, response.message, 2000)
      })
      .catch(error => {
        controller.getControllerByIdentifier("app--helpers--console").console(error)
        controller.getControllerByIdentifier("app--helpers--snackbar").doSnackbar("danger", controller.getControllerByIdentifier("app--shared--messages").generalError(), 3000)
      })
  }

  doTicketPreloader() {
    var loader = `<div class='card timeline-item m-0 p-1 w-100' style="box-shadow:none;"><div class='animated-background animated-background-5'></div></div>`

    var html = `<div class="row my-3">
                  <div class="col-3 px-1">
                    <div class="card border-top-primary">
                      <div class="card-header p-1 text-center f-065">
                        <span>${loader}</span>
                      </div>
                      <div class="card-body p-1 text-center f-065">
                        <span class="my-2">${loader}</span>
                        <span class="my-2">${loader}</span>
                        <span class="my-2">${loader}</span>
                      </div>
                    </div>
                  </div>
                </div>`

    return html
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
      
      // if (len == 0) {
      //   controller.resolvedBtnTarget.disabled = false
      // } else {
      //   controller.resolvedBtnTarget.disabled = true
      // }
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

  // new Promise(function (resolve) {
  //   resolve()
  // }).then(() => {
  // }) 

}
