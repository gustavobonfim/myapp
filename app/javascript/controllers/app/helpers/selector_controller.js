import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["dropdown", "input", "btn", "select", "5555", "6666", "7777", "8888", "9999"]

  connect() { }

  select(ev) {
    this.dropdownTarget.parentElement.classList.add("has-value")
    this.btnTarget.classList.add("d-flex")
    this.btnTarget.style.width = "none"
    this.dropdownTarget.value = ev.target.innerText
    this.inputTarget.innerText = ev.target.innerText

    for (var x in ev.target.dataset) {
      if (x != "action" && x != "target") {
        this.inputTarget.dataset[x] = ev.target.dataset[x]
      }
    }
    this.selectTargets.forEach(element => {
      element.classList.remove("li-selected")
    });
    ev.target.classList.add("li-selected")
  }

  getControllerByIdentifier(identifier) {
    return this.application.controllers.find(controller => {
      return controller.context.identifier === identifier;
    });
  }

  nameTarget(target) {
    return this.targets.find(target)
  }

}