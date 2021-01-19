import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["searchInput", "searchTable", "searchList", "4444", "5555", "6666", "7777", "8888", "9999"]

  connect() { }

  doSearchTable(ev) {

    var filter = ev.target.value.toUpperCase()
    var filterUnaccent = filter.normalize("NFD").replace(/[\u0300-\u036f]/g, "")

    var table = this.searchTableTarget
    var tr = table.getElementsByTagName("tr")

    for (var i = 1; i < tr.length; i++) {
      var td = tr[i].getElementsByTagName("td")
      var show = false
      for (var x = 0; x < td.length; x++) {
        if (td[x]) {
          var txtValue = td[x].textContent || td[x].innerText;
          var txtValueUnaccent = txtValue.normalize("NFD").replace(/[\u0300-\u036f]/g, "")
          if ((txtValue.toUpperCase().indexOf(filter) > -1) || (txtValueUnaccent.toUpperCase().indexOf(filterUnaccent) > -1)) {
            show = true;
          }
        }
      }
      if (show == true) {
        tr[i].style.display = "";
        tr[i].classList.add("filter-row")
      } else {
        tr[i].style.display = "none";
        tr[i].classList.remove("filter-row")
      }
    }
  }

  doSearchList(ev) {
    var filter = ev.target.value.toLowerCase()
    var filterUnaccent = filter.normalize("NFD").replace(/[\u0300-\u036f]/g, "")
    this.searchListTarget.children.forEach(element => {
      var show = false
      var txtValue = element.innerText.toLowerCase()
      var txtValueUnaccent = txtValue.normalize("NFD").replace(/[\u0300-\u036f]/g, "")
      if ((txtValue.indexOf(filter) > -1) || (txtValueUnaccent.indexOf(filterUnaccent) > -1)) {
        show = true
      }
      if (show == true) {
        element.classList.remove("d-none")
      } else {
        element.classList.add("d-none")
      }
    })
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