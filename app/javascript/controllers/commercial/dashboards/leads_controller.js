import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["main", "2222", "3333", "4444", "5555", "6666", "7777", "8888", "9999"]

  connect() {
    this.loader = this.getControllerByIdentifier("app--helpers--loaders").loader()
    this.cardLoader = this.getControllerByIdentifier("app--helpers--loaders").cardLoader()
    this.controllerName = `commercial--dashboards--leads`
    this.doPageGrid()
  }

  doPageGrid() {
    var html = `<div class="row" data-controller="commercial--dashboards--sources--events commercial--dashboards--sources--landings commercial--dashboards--sources--visits">
                  <div class="col-12" data-target="commercial--dashboards--sources--events.main commercial--dashboards--sources--landings.main commercial--dashboards--sources--visits.main"></div>
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

  layout() {
    var targets = ["mainCard"]
    var identifier = ""
    // this.getControllerByIdentifier("app--helpers--layout").resizeMainCard(targets, identifier)
  }

  refreshSaveBtn() {
    var controller = this
    this.refreshTimer = setInterval(function () {
      var len = 0
      controller.validGroupTargets.forEach(element => {
        if (this.fromStringToBoolean(element.dataset.valid) == false) {
          len += 1
        }
      });
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
