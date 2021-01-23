import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["main", "card", "addNewOpportunityBtn", "4444", "5555", "6666", "7777", "8888", "9999"]

  connect() {
    this.controllerName = `commercial--sales--opportunities--dealflow--flow`
    this.controllerDashboard = this.getControllerByIdentifier("commercial--sales--opportunities--dealflow--dashboard")
  }

  doDataFlow() {
    
    this.application.opportunities.forEach(element => {
      this.doSimpleDataFlow(element)    
    })
    this.getControllerByIdentifier("commercial--sales--opportunities--dealflow--dashboard").doTicketsHtml()
  }

  doSimpleDataFlow(element) {
    var name = ``
    element.leads.forEach(lead => {
      name += `<h6 class="mb-1 f-065">${lead.lead_name}</h6>`
    })

    var html = `<div class="row my-2 cardRow" data-id="${element.id}" data-stage="${element.stage}" data-stage-number="${element.stage_number}" data-url="${element.url}" data-target="${this.controllerName}.card-${element.id}">
                 <div class="col-12 px-1">
                   <div class="card">
                     <div class="card-body px-0 pt-1 pb-0 f-065">
                       <div class="row my-2">
                         <div class="col-9 px-1 pointer" data-action="click->${this.controllerName}#goToURL"> 
                           ${name}
                         </div>
                         <div class="col-3 mb-1 px-1 d-flex align-items-center justify-content-center">
                           <span class="mc-tooltip pointer">
                             <span class="material-icons md-sm md-danger">warning</span>
                             <span class="mc-tooltiptext">Ticket(s) em Atraso</span>
                           </span>
                           <span class="mc-tooltip mx-auto pointer" data-action="click->${this.controllerName}#addTicket">
                             <span class="material-icons md-sm md-dark">add</span>
                             <span class="mc-tooltiptext">Novo Ticket</span>
                           </span>
                         </div>
                       </div>
                       <div class="row">
                         <div class="col-12 p-0">
                           <button data-action="click->${this.controllerName}#changeStage" type="button" class="btn btn-sm btn-table p-0 w-100 mc-tooltip">
                             <span class="material-icons md-sm md-dark">trending_flat</span>
                             <span class="mc-tooltiptext mc-tooltiptext-right">Avançar</span>
                           </button>
                         </div>
                       </div>
                     </div>
                   </div>
                 </div>
               </div>`



    if (window.location.pathname == `/fluxo-prospeccao`) {
      if (element.stage == `prospecting`) {
        this.controllerDashboard.prospectingFlowTarget.insertAdjacentHTML("afterbegin", html)
        this.setTickets(element)
      } else if (element.stage == `qualification`) {
        this.controllerDashboard.qualificationFlowTarget.insertAdjacentHTML("afterbegin", html)
        this.setTickets(element)
      } else if (element.stage == `booking`) {
        this.controllerDashboard.bookingFlowTarget.insertAdjacentHTML("afterbegin", html)
        this.setTickets(element)
      }
    } else if (window.location.pathname == `/fluxo-fechamento`) {
      if (element.stage == `meeting`) {
        this.controllerDashboard.meetingFlowTarget.insertAdjacentHTML("afterbegin", html)
        this.setTickets(element)
      } else if (element.stage == `proposal`) {
        this.controllerDashboard.proposalFlowTarget.insertAdjacentHTML("afterbegin", html)
        this.setTickets(element)
      } else if (element.stage == `closing`) {
        this.controllerDashboard.closingFlowTarget.insertAdjacentHTML("afterbegin", html)
        this.setTickets(element)
      }
    }
  }

  setTickets(element) {
    element.tickets.forEach(ticket => {
      ticket.url = element.url
      this.application.tickets[this.application.tickets.length] = ticket
    })
  }

  doDataIndicator() {
    var prospectingTotal = 0
    var qualificationTotal = 0
    var bookingTotal = 0
    var meetingTotal = 0
    var proposalTotal = 0
    var closingTotal = 0

    var prospectingAmount = 0
    var qualificationAmount = 0
    var bookingAmount = 0
    var meetingAmount = 0
    var proposalAmount = 0
    var closingAmount = 0

    this.application.opportunities.forEach(element => {

      if (window.location.pathname == `/fluxo-prospeccao`) {
        this.controllerDashboard.prospectingTotalTarget.innerText = prospectingTotal
        this.controllerDashboard.qualificationTotalTarget.innerText = qualificationTotal
        this.controllerDashboard.bookingTotalTarget.innerText = bookingTotal

        this.controllerDashboard.prospectingAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(prospectingAmount * 100))
        this.controllerDashboard.qualificationAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(qualificationAmount * 100))
        this.controllerDashboard.bookingAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(bookingAmount * 100))

        if (element.stage == `prospecting`) {
          prospectingTotal += 1
          this.controllerDashboard.prospectingTotalTarget.innerText = prospectingTotal
          prospectingAmount += Number(element.total_amount)
          this.controllerDashboard.prospectingAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(prospectingAmount * 100))
        } else if (element.stage == `qualification`) {
          qualificationTotal += 1
          this.controllerDashboard.qualificationTotalTarget.innerText = qualificationTotal
          qualificationAmount += Number(element.total_amount)
          this.controllerDashboard.qualificationAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(qualificationAmount * 100))
        } else if (element.stage == `booking`) {
          bookingTotal += 1
          this.controllerDashboard.bookingTotalTarget.innerText = bookingTotal
          bookingAmount += Number(element.total_amount)
          this.controllerDashboard.bookingAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(bookingAmount * 100))
        }
      } else if (window.location.pathname == `/fluxo-fechamento`) {
        this.controllerDashboard.meetingTotalTarget.innerText = meetingTotal
        this.controllerDashboard.proposalTotalTarget.innerText = proposalTotal
        this.controllerDashboard.closingTotalTarget.innerText = closingTotal

        this.controllerDashboard.meetingAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(meetingAmount * 100))
        this.controllerDashboard.proposalAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(proposalAmount * 100))
        this.controllerDashboard.closingAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(closingAmount * 100))

        if (element.stage == `meeting`) {
          meetingTotal += 1
          this.controllerDashboard.meetingTotalTarget.innerText = meetingTotal
          meetingAmount += Number(element.total_amount)
          this.controllerDashboard.meetingAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(meetingAmount * 100))
        } else if (element.stage == `proposal`) {
          proposalTotal += 1
          this.controllerDashboard.proposalTotalTarget.innerText = proposalTotal
          proposalAmount += Number(element.total_amount)
          this.controllerDashboard.proposalAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(proposalAmount * 100))
        } else if (element.stage == `closing`) {
          closingTotal += 1
          this.controllerDashboard.closingTotalTarget.innerText = closingTotal
          closingAmount += Number(element.total_amount)
          this.controllerDashboard.closingAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(closingAmount * 100))
        }
      }
    })
  }

  goToURL(ev) {
    var url = ev.currentTarget.closest(".cardRow").dataset.url
    window.open(url, `_blank`)
  }

  addTicket(ev) {
    var id = ev.currentTarget.closest(".cardRow").dataset.id
  }

  changeStage(ev) {
    
    var stageNumber = Number(ev.currentTarget.closest(".cardRow").dataset.stageNumber)
    var newStage = this.setNewStage(stageNumber)

    if (newStage == `gain`) {
      var r = confirm("Confirma o Ganho da Oportunidade? Vamos para a página da Oportunidade atualizar os Ganhos!")  
    } else {
      var r = confirm("Confirma o avanco da Oportunidade?")  
    }
    
    if (r && newStage != `gain`) {
      var id = ev.currentTarget.closest(".cardRow").dataset.id
      var stage = ev.currentTarget.closest(".cardRow").dataset.stage

      this.send_data = { current_user: {}, journey: {}, product: {} }

      this.send_data.current_user.current_user_id = this.application.current_user.id

      this.send_data.journey.opportunity_id = id
      this.send_data.journey.stage = this.setNewStage(stageNumber)
      this.send_data.journey.date = new Date()
      this.send_data.product.stage = this.setNewStage(stageNumber)
      
      this.requestSaveJourney()
    } else if (r && newStage == `gain`) {
      this.goToURL(ev)
    }
  }

  setNewStage(stageNumber) {
    
    if (window.location.pathname == `/fluxo-prospeccao`) {
      var all_stages = ["qualification", "booking", "meeting"]
      // this.controllerDashboard.prospectingFlowTarget.innerHTML = ``
      // this.controllerDashboard.qualificationFlowTarget.innerHTML = ``
      // this.controllerDashboard.bookingFlowTarget.innerHTML = ``
    } else if (window.location.pathname == `/fluxo-fechamento`) {
      var all_stages = ["qualification", "booking", "meeting", "proposal", "closing", "gain"]
      // this.controllerDashboard.meetingFlowTarget.innerHTML = ``
      // this.controllerDashboard.proposalFlowTarget.innerHTML = ``
      // this.controllerDashboard.closingFlowTarget.innerHTML = ``
    }

    return all_stages[stageNumber]
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
          this.application.opportunities.forEach(element => {
            if (element.id == journey.opportunity_id) {
              controller.nameTarget(`card-${element.id}`).remove()
              element.stage = journey.stage
              element.stage_pretty = journey.stage
              element.stage_number = element.stage_number + 1
              element.journeys[element.journeys.length] = journey
              controller.doSimpleDataFlow(element)
              return
            }
          })
          controller.doDataIndicator()
        }
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
