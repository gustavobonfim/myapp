Rails.application.routes.draw do
  root "pages#home"

  resources :opportunities, path: '/marketing-vendas', only: [:index, :show], path_names: {index: 'todos'}, controller: 'web/commercial/dashboards/sales'
  resources :opportunities, path: '/geracao-de-leads', only: [:index, :show], path_names: {index: 'todos'}, controller: 'web/commercial/dashboards/leads'
  resources :opportunities, path: '/oportunidades', only: [:index, :show], path_names: {index: 'todos'}, controller: 'web/commercial/sales/opportunities/entities'
  resources :opportunities, path: '/fluxo-prospeccao', only: [:index, :show], path_names: {index: 'todos'}, controller: 'web/commercial/sales/opportunities/entities'
  resources :opportunities, path: '/fluxo-fechamento', only: [:index, :show], path_names: {index: 'todos'}, controller: 'web/commercial/sales/opportunities/entities'



  namespace :api, path: '/' do
    namespace :v1, path: '/' do
      namespace :operations do

        namespace :onboards do
          post "dates/create", to: "dates#create"
          post "dates/list", to: "dates#list"
          put "dates/update", to: "dates#update"

          post "entities/create", to: "entities#create"
          post "entities/read", to: "entities#read"
          post "entities/list", to: "entities#list"
          put "entities/update", to: "entities#update"
        end

        namespace :products do
          namespace :config do
            post "dates/read", to: "dates#read"
            post "dates/list", to: "dates#list"
            put "dates/update", to: "dates#update"

            post "entities/create", to: "entities#create"
            post "entities/read", to: "entities#read"
            post "entities/list", to: "entities#list"
            put "entities/update", to: "entities#update"
          end

          namespace :clinics do
            post "partners/create", to: "partners#create"
            post "partners/list", to: "partners#list"
            put "partners/update", to: "partners#update"

            post "entities/create", to: "entities#create"
            post "entities/read", to: "entities#read"
            post "entities/list", to: "entities#list"
            put "entities/update", to: "entities#update"
          end
        end
      end

      namespace :financials do
        namespace :books do
          namespace :contracts do
            post "entities/list", to: "entities#list"
            post "entities/read", to: "entities#read"
            post "entities/create", to: "entities#create"
            put "entities/update", to: "entities#update"

            post "takers/create", to: "takers#create"
            put "takers/update", to: "takers#update"
            post "takers/list", to: "takers#list"

            post "additives/create", to: "additives#create"
            put "additives/update", to: "additives#update"
            post "additives/list", to: "additives#list"
            
            post "calculations/read", to: "calculations#read"
            post "calculations/list", to: "calculations#list"
          end

          namespace :receivables do
            post "entities/list", to: "entities#list"
            post "entities/create", to: "entities#create"
            put "entities/update", to: "entities#update"

            post "conciliations/list", to: "conciliations#list"

            post "adjustments/create", to: "adjustments#create"
            post "adjustments/list", to: "adjustments#list"
            put "adjustments/update", to: "adjustments#update"
            delete "adjustments/destroy", to: "adjustments#destroy"

            post "invoices/create", to: "invoices#create"
            post "invoices/list", to: "invoices#list"
            put "invoices/update", to: "invoices#update"
            put "invoices/update_paid", to: "invoices#update_paid"
            delete "invoices/destroy", to: "invoices#destroy"
            
            post "calculations/read", to: "calculations#read"
            post "calculations/list", to: "calculations#list"
          end


          namespace :cards do
            put "bills/update", to: "bills#update"
            put "bills/update_paid", to: "bills#update_paid"
            put "bills/close_bill", to: "bills#close_bill"
            post "bills/list", to: "bills#list"

            post "entities/create", to: "entities#create"
            put "entities/update", to: "entities#update"
            post "entities/list", to: "entities#list"

            post "transactions/create", to: "transactions#create"
            put "transactions/update", to: "transactions#update"
            post "transactions/list", to: "transactions#list"
          end

          namespace :payables do
            post "providers/create", to: "providers#create"
            put "providers/update", to: "providers#update"
            post "providers/list", to: "providers#list"

            post "entities/create", to: "entities#create"
            put "entities/update", to: "entities#update"
            put "entities/update_paid", to: "entities#update_paid"
            post "entities/list", to: "entities#list"
          end

          namespace :settings do
            post "chart_accounts/create", to: "chart_accounts#create"
            put "chart_accounts/update", to: "chart_accounts#update"
            post "chart_accounts/list", to: "chart_accounts#list"

            post "channels/create", to: "channels#create"
            put "channels/update", to: "channels#update"
            post "channels/list", to: "channels#list"
          end

          namespace :statements do
            post "transactions/create", to: "transactions#create"
            put "transactions/update", to: "transactions#update"
            post "transactions/list", to: "transactions#list"
          end

          namespace :transactions do
            post "entities/create", to: "entities#create"
            post "entities/list", to: "entities#list"
            put "entities/update", to: "entities#update"
            delete "entities/destroy", to: "entities#destroy"
          end

          namespace :balances do
            post "entities/create", to: "entities#create"
            put "entities/update", to: "entities#update"
            put "entities/refresh", to: "entities#refresh"
            post "entities/list", to: "entities#list"
            post "entities/read", to: "entities#read"
          end
        end
      end

      namespace :users do
        namespace :works do
          namespace :trackers do
            post "projects/create", to: "projects#create"
            put "projects/update", to: "projects#update"
            post "projects/read", to: "projects#read"
            post "projects/list", to: "projects#list"
            delete "projects/destroy", to: "projects#destroy"

            post "squads/create", to: "squads#create"
            post "squads/list", to: "squads#list"
            put "squads/update", to: "squads#update"
            delete "squads/destroy", to: "squads#destroy"

            post "stories/create", to: "stories#create"
            post "stories/list", to: "stories#list"
            post "stories/list_names", to: "stories#list_names"
            put "stories/update", to: "stories#update"
            delete "stories/destroy", to: "stories#destroy"

            post "relations/create", to: "relations#create"
            delete "relations/destroy", to: "relations#destroy"

            post "tickets/create", to: "tickets#create"
            post "tickets/list", to: "tickets#list"
            put "tickets/update", to: "tickets#update"
            delete "tickets/destroy", to: "tickets#destroy"
            
          end
        end
      end

      namespace :commercial do

        namespace :config do
          post "dates/read", to: "dates#read"
          post "dates/list", to: "dates#list"
          put "dates/update", to: "dates#update"

          post "calculations/list", to: "calculations#list"
          put "calculations/update", to: "calculations#update"
        end

        namespace :marketing do
          namespace :events do
            post "attendees/list", to: "attendees#list"
            post "attendees/create", to: "attendees#create"
            put "attendees/update", to: "attendees#update"
          end

          namespace :leads do
            post "generations/list_attendee", to: "generations#list_attendee"
            post "generations/list_landings", to: "generations#list_landings"
          end
        end

        namespace :sales do

          namespace :opportunities do
            post "entities/list", to: "entities#list"
            post "entities/read", to: "entities#read"
            post "entities/create", to: "entities#create"
            put "entities/update", to: "entities#update"

            post "products/list", to: "products#list"
            post "products/create", to: "products#create"
            put "products/update", to: "products#update"
            delete "products/destroy", to: "products#destroy"

            post "leads/list", to: "leads#list"
            post "leads/create", to: "leads#create"
            put "leads/update", to: "leads#update"
            delete "leads/destroy", to: "leads#destroy"

            post "journeys/list", to: "journeys#list"
            post "journeys/create", to: "journeys#create"
            put "journeys/update", to: "journeys#update"

            post "tickets/list", to: "tickets#list"
            post "tickets/create", to: "tickets#create"
            put "tickets/update", to: "tickets#update"
          end

          namespace :leads do
            post "entities/list", to: "entities#list"
            post "entities/create", to: "entities#create"
            put "entities/update", to: "entities#update"

            post "sources/list", to: "sources#list"
          end

        end
      end

      namespace :users do
        namespace :companies do
          post "entities/list", to: "entities#list"
          post "entities/create", to: "entities#create"
          post "entities/read", to: "entities#read"
          put "entities/update", to: "entities#update"
        end
      end
      
    end
  end

end
