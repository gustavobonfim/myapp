import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["main", "card", "addNewOpportunityBtn", "4444", "5555", "6666", "7777", "8888", "9999"]

  connect() {
    this.controllerName = `commercial--sales--opportunities--dealflow--flow`
    this.controllerDashboard = this.getControllerByIdentifier("commercial--sales--opportunities--dealflow--dashboard")
  }

  doDataFlow() {
    // var html = ``
    var prospectingTotal = 0
    var qualificationTotal = 0
    var bookingTotal = 0

    this.controllerDashboard.prospectingTotalTarget.innerText = prospectingTotal
    this.controllerDashboard.qualificationTotalTarget.innerText = qualificationTotal
    this.controllerDashboard.bookingTotalTarget.innerText = bookingTotal

    var prospectingAmount = 0
    var qualificationAmount = 0
    var bookingAmount = 0

    this.controllerDashboard.prospectingAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(prospectingAmount * 100))
    this.controllerDashboard.qualificationAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(qualificationAmount * 100))
    this.controllerDashboard.bookingAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(bookingAmount * 100))

    this.application.opportunities.forEach(element => {
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
          this.controllerDashboard.prospectingFlowTarget.insertAdjacentHTML("beforeend", html)
          prospectingTotal += 1
          this.controllerDashboard.prospectingTotalTarget.innerText = prospectingTotal
          prospectingAmount += Number(element.total_amount)
          this.controllerDashboard.prospectingAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(prospectingAmount * 100))
        } else if (element.stage == `qualification`) {
          this.controllerDashboard.qualificationFlowTarget.insertAdjacentHTML("beforeend", html)
          qualificationTotal += 1
          this.controllerDashboard.qualificationTotalTarget.innerText = qualificationTotal
          qualificationAmount += Number(element.total_amount)
          this.controllerDashboard.qualificationAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(qualificationAmount * 100))
        } else if (element.stage == `booking`) {
          this.controllerDashboard.bookingFlowTarget.insertAdjacentHTML("beforeend", html)
          bookingTotal += 1
          this.controllerDashboard.bookingTotalTarget.innerText = bookingTotal
          bookingAmount += Number(element.total_amount)
          this.controllerDashboard.bookingAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(bookingAmount * 100))
        }  
      } else if (window.location.pathname == `/fluxo-fechamento`) {
        if (element.stage == `meeting`) {
          this.controllerDashboard.meetingFlowTarget.insertAdjacentHTML("beforeend", html)
          meetingTotal += 1
          this.controllerDashboard.meetingTotalTarget.innerText = meetingTotal
          meetingAmount += Number(element.total_amount)
          this.controllerDashboard.meetingAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(meetingAmount * 100))
        } else if (element.stage == `proposal`) {
          this.controllerDashboard.proposalFlowTarget.insertAdjacentHTML("beforeend", html)
          proposalTotal += 1
          this.controllerDashboard.proposalTotalTarget.innerText = proposalTotal
          proposalAmount += Number(element.total_amount)
          this.controllerDashboard.proposalAmountTarget.innerText = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(proposalAmount * 100))
        } else if (element.stage == `closing`) {
          this.controllerDashboard.closingFlowTarget.insertAdjacentHTML("beforeend", html)
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
    console.log(id)
  }

  changeStage(ev) {
    var r = confirm("Confirma o avanço na Oportunidade?")

    if (r) {
      var id = ev.currentTarget.closest(".cardRow").dataset.id
      var stage = ev.currentTarget.closest(".cardRow").dataset.stage
      var stageNumber = Number(ev.currentTarget.closest(".cardRow").dataset.stageNumber)
      
      this.application.opportunities.forEach(element => {
        if (element.id == id) {
          element.stage = this.setNewStage(stageNumber)
          element.stage_number = stageNumber + 1
        }
      })
      
      this.doDataFlow()
    }
  }

  setNewStage(stageNumber) {
    
    if (window.location.pathname == `/fluxo-prospeccao`) {
      var all_stages = ["qualification", "booking", "meeting"]
      this.controllerDashboard.prospectingFlowTarget.innerHTML = ``
      this.controllerDashboard.qualificationFlowTarget.innerHTML = ``
      this.controllerDashboard.bookingFlowTarget.innerHTML = ``
    } else if (window.location.pathname == `/fluxo-fechamento`) {
      var all_stages = ["proposal", "closing", "gain"]
      this.controllerDashboard.meetingFlowTarget.innerHTML = ``
      this.controllerDashboard.proposalFlowTarget.innerHTML = ``
      this.controllerDashboard.closingFlowTarget.innerHTML = ``
    }

    return all_stages[stageNumber]
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
