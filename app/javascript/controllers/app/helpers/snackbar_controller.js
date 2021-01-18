import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["main", "messageRow", "3333", "4444", "5555", "6666", "7777", "8888", "9999"]

  connect() {
  }

  closeMessage(ev) {
    ev.currentTarget.closest(".row").remove()
  }

  doSnackbar(type, message, time) {

    if (this.application.device == "mobile") {

    } else if (this.application.device == "desktop") {

      var messageHtml = `<div class="row snackbar-outline-${type} my-4" data-target="app--helpers--snackbar.messageRow">
                          <div class="col-11 d-flex align-items-center px-0">
                            <span class="mr-auto text-left">${message}</span>
                          </div>
                          <div class="col-1 d-flex align-items-center px-0">
                            <button type="button" class="close ml-auto" data-dismiss="alert" data-action="click->app--helpers--snackbar#closeMessage" aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                            </button>
                          </div>
                        </div>`

      this.mainTarget.classList.add("show")
      this.mainTarget.insertAdjacentHTML("beforeend", messageHtml)
      var controller = this
      this.refreshTimer = setTimeout(function () {
        if (controller.hasMessageRowTarget) {
          controller.messageRowTarget.remove()
        }
      }, time);
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

  stopRefreshing() {
    if (this.refreshTimer) {
      clearInterval(this.refreshTimer)
    }
  }

  // new Promise(function (resolve) {
  //   resolve()
  // }).then(() => {
  // }) 

}
