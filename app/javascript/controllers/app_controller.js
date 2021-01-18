import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["output"]

  connect() {
    this.application.current_user = { id: 1, name: "Gustavo Bonfim", account_kind: "admin" }
    this.application.token = $('meta[name=csrf-token]').attr('content')
  }
}
