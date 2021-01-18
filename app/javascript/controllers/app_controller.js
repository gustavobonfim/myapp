import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["output"]

  connect() {
    this.application.current_user = { id: 1, name: "Gustavo Bonfim" }
  }
}
