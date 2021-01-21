import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["1111", "2222", "3333", "4444", "5555", "6666", "7777", "8888", "9999"]

  connect() {
  }

  filterList(ev, length) {
    var inputValue = ev.target.value
    var ul = ev.target.nextElementSibling
    var input = ev.target
    var filterMode = ev.target.dataset.filterMode
    if (inputValue.length > length) {
      if (filterMode == "simple") {
        this.filterListSimple(ev)
      } else {
        this.filterListComplete(ev)
      }
      ul.classList.remove("d-none")
    } else {
      ul.classList.add("d-none")
    }
  }

  hideList(ev) {
    ev.target.nextElementSibling.classList.add("d-none")
  }

  selectItem(ev) {
    ev.stopPropagation()
    if (ev.target.closest(".floating-label")) { ev.target.closest(".floating-label").classList.add("has-value") }
    var dataset = ev.target.dataset
    ev.target.parentElement.previousElementSibling.value = dataset.text
    ev.target.parentElement.previousElementSibling.dataset.filter = dataset.filter
    ev.target.parentElement.previousElementSibling.dataset.text = dataset.text
    ev.target.parentElement.classList.add("d-none")
    if (ev.target.parentElement.children.length < 10) {
      ev.target.parentElement.children.forEach(element => {
        element.classList.remove("li-filtered")
      })
    }
    ev.target.classList.add("li-filtered")
  }

  filterListSimple(ev) {
    // Faz as buscas por conjunto de caracteres
    // testar includes ao inves da sequencial de string
    // Declare variables
    var input, filter, ul, li, a, i, txtValue;
    var input = ev.target.value
    var filter = ev.target.value.toUpperCase();
    var filterUnaccent = filter.normalize("NFD").replace(/[\u0300-\u036f]/g, "")
    var li = ev.target.nextElementSibling.children

    // Loop through all list items, and hide those who don't match the search query
    for (var i = 0; i < li.length; i++) {
      var show = false
      var txtValue = li[i].textContent || li[i].innerText;
      var txtValueUnaccent = txtValue.normalize("NFD").replace(/[\u0300-\u036f]/g, "")
      if ((txtValue.toUpperCase().indexOf(filter) > -1) || (txtValueUnaccent.toUpperCase().indexOf(filterUnaccent) > -1)) {
        show = true;
      }
      if (show == true) {
        li[i].style.display = "";
        li[i].classList.add("filter-row")
      } else {
        li[i].style.display = "none";
        li[i].classList.remove("filter-row")
      }
    }
  }

  filterListComplete(ev) {
    // Faz as buscas por palavras completas
    // testar includes ao inves da sequencial de string
    // Declare variables
    var filter = ev.target.value.toUpperCase()
    var filterUnaccent = filter.normalize("NFD").replace(/[\u0300-\u036f]/g, "")
    filter = filter.split(" ")
    filterUnaccent = filterUnaccent.split(" ")
    var li = ev.target.nextElementSibling.children

    // Loop through all list items, and hide those who don't match the search query
    for (var i = 0; i < li.length; i++) {
      var show = false;
      var txtValue = li[i].textContent || li[i].innerText;
      var txtValueUnaccent = txtValue.normalize("NFD").replace(/[\u0300-\u036f]/g, "")
      filter.forEach(function (w) {
        if (txtValue.toUpperCase().split(" ").includes(w) || txtValueUnaccent.toUpperCase().split(" ").includes(w.normalize("NFD").replace(/[\u0300-\u036f]/g, ""))) {
          // if ((txtValue.toUpperCase().indexOf(filter) > -1) || (txtValueUnaccent.toUpperCase().indexOf(filterUnaccent) > -1)) {
          show = true;
        }
      });

      if (show == true) {
        li[i].style.display = "";
        li[i].classList.add("filter-row")
      } else {
        li[i].style.display = "none";
        li[i].classList.remove("filter-row")
      }
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
