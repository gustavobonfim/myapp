import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["main", "viewTitle", "addNewOpportunityBtn", "4444", "5555", "6666", "7777", "8888", "9999"]

  connect() {
    this.controllerName = `commercial--sales--opportunities--entities--view`
    this.doViewHtml()
  }

  addNewOpportunity() {
    this.getControllerByIdentifier("commercial--sales--opportunities--entities--save").current_lead = {}
    this.getControllerByIdentifier("commercial--sales--opportunities--entities--save").doFormHtml()
  }

  doViewHtml() {
    var html = `<div class="card" style="width:100%;display:relative;" data-target="${this.controllerName}.main">
                  <div class="card-header d-flex align-items-center card-header-table-list f-065">
                    <h6 class="card-title display-4" style="padding:1rem;font-size:110%;margin-bottom:0px;" data-target="${this.controllerName}.viewTitle">Adicione Novas Oportunidades</h6>
                    <div class="card-actions ml-auto py-0 mc-tooltip">
                      <button aria-expanded="false" aria-haspopup="true" class="btn btn-outline my-0" data-target="${this.controllerName}.addNewOpportunityBtn" data-action="click->${this.controllerName}#addNewOpportunity" type="button">
                        <span class="material-icons">add</span>
                      </button>
                      <span class="mc-tooltiptext">Adicionar Nova Oportunidade</span>
                    </div>
                  </div>
                </div>`

    this.mainTarget.innerHTML = html
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
