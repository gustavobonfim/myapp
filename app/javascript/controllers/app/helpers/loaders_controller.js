import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["1111", "2222", "3333", "4444", "5555", "6666", "7777", "8888", "9999"]

  connect() {
  }

  loader() {
    var html = `<div class='card timeline-item m-0 p-1 w-100' style="box-shadow:none;"><div class='animated-background animated-background-5'></div></div>`

    return html
  }

  cardLoader() {
    var loader = this.loader()

    var html = `<div class="card border-top-primary">
                  <div class="card-header p-1 text-center s-title-0p7rem">
                    <span>${loader}</span>
                  </div>
                  <div class="card-body text-center s-title-0p7rem">
                    <span>${loader}</span>
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

  // new Promise(function (resolve) {
  //   resolve()
  // }).then(() => {
  // }) 

}
