import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
    this.outputTarget.innerText = 'Hello, Stimulus!'
    this.doAliasCard()
  }

  goToURL(ev) {
    var url = ev.currentTarget.dataset.url
    window.open(url, `_self`)
  }

  doAliasCard() {

    var html = ``

    html += `
              <div class="col-1 px-2 my-2">
                <div class="card border-top-primary">
                  <div class="card-header p-1 text-center f-065">
                    <span>Marketing & Vendas</span>
                  </div>
                  <div class="card-body text-center py-2 mc-tooltip pointer" data-url="/marketing-vendas" data-action="click->pages#goToURL">
                    <span class="material-icons md-lg md-dark">account_box</span>
                    <span class="mc-tooltiptext">Marketing & Vendas</span>
                  </div>
                </div>
              </div>
              <div class="col-1 px-2 my-2">
                <div class="card border-top-primary">
                  <div class="card-header p-1 text-center f-065">
                    <span>Geração de Leads</span>
                  </div>
                  <div class="card-body text-center py-2 mc-tooltip pointer" data-url="/geracao-de-leads" data-action="click->pages#goToURL">
                    <span class="material-icons md-lg md-dark">account_box</span>
                    <span class="mc-tooltiptext">Geração de Leads</span>
                  </div>
                </div>
              </div>`


    
    // if (this.application.current_user.account_kind == "admin") {
    // }

    this.outputTarget.innerHTML = html
  }
}