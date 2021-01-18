import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["searchInput", "searchTable", "searchList", "4444", "5555", "6666", "7777", "8888", "9999"]

  connect() {
  }

  doTablePreloader(columns, rows) {
    var columnPreloaderHtml = ''
    for (var i = 0; i < columns; i++) {
      columnPreloaderHtml += `<td class='animated-background animated-background-td'></td>`
    }
    var tablePreloaderHtml = ''
    for (var i = 0; i < rows; i++) {
      tablePreloaderHtml += `<tr class='timeline-item' data-target="marketing--courses--entities--index.bodyTablePreloader">` + columnPreloaderHtml + `</tr>`
    }
    return tablePreloaderHtml
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