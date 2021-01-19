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

    var featureCard = `
                        <div class="col-1 px-2 my-2">
                          <div class="card border-top-primary">
                            <div class="card-header p-1 text-center f-065">
                              <span>Oportunidades</span>
                            </div>
                            <div class="card-body text-center py-2 mc-tooltip pointer" data-url="/marketing-vendas" data-action="click->pages#goToURL">
                              <span class="material-icons md-lg md-dark">account_box</span>
                              <span class="mc-tooltiptext">Oportunidades</span>
                            </div>
                          </div>
                        </div>`

    html += featureCard
    
    // if (this.application.current_user.account_kind == "admin") {
    // }

    this.outputTarget.innerHTML = html
  }
}