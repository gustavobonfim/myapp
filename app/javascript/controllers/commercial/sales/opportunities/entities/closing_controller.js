import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["modal", "body"]

  connect() {
    this.open()
  }

  setValues() {
    var newStage = this.getControllerByIdentifier("commercial--sales--opportunities--entities--show").send_data.product.stage
    if (newStage == `gain`) {
      this.application.opportunity.products.forEach(product => {
        this.nameTarget(`productAmount-${product.id}`).value = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(product.amount * 100))
        this.nameTarget(`productGain-${product.id}`).value = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(product.amount * 100))
        this.nameTarget(`productLost-${product.id}`).value = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(product.lost * 100))
        this.nameTarget(`productLost-${product.id}`).disabled = true
      })
    } else if (newStage== `lost`) {
      this.application.opportunity.products.forEach(product => {
        this.nameTarget(`productAmount-${product.id}`).value = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(product.amount * 100))
        this.nameTarget(`productGain-${product.id}`).value = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(product.gain * 100))
        this.nameTarget(`productGain-${product.id}`).disabled = true
        this.nameTarget(`productLost-${product.id}`).value = this.getControllerByIdentifier("app--helpers--numbers").currencyMask(parseInt(product.amount * 100))
      })
    }
    
    this.getControllerByIdentifier("app--helpers--forms").floatingLabel()
  }

  saveProducts() {
    var products = []
    this.application.opportunity.products.forEach(element => {
      var product = {}
      product.id = element.id
      product.gain = this.getControllerByIdentifier("app--helpers--numbers").fromCurrencyToNumber(this.nameTarget(`productGain-${element.id}`).value)
      product.lost = this.getControllerByIdentifier("app--helpers--numbers").fromCurrencyToNumber(this.nameTarget(`productLost-${element.id}`).value)
      products[products.length] = product
    })
    this.getControllerByIdentifier("commercial--sales--opportunities--entities--show").send_data.product.products = products
    this.getControllerByIdentifier("commercial--sales--opportunities--entities--show").requestSaveJourney()
    this.close()
  }

  open() {
    document.body.classList.add("modal-open");
    this.element.setAttribute("style", "display: block;");
    this.element.classList.add("show");
    const html = `<div class="modal-backdrop fade show"></div>`
    document.body.insertAdjacentHTML("beforeend", html)
  }

  close() {
    document.body.classList.remove("modal-open");
    this.element.removeAttribute("style");
    this.element.classList.remove("show");
    document.getElementsByClassName("modal-backdrop")[0].remove();
    this.modalTarget.remove()
  }

  currencyMask(ev) {
    this.getControllerByIdentifier("app--helpers--numbers").changeNumberToCurrency(ev)
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

}