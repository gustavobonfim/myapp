Rails.application.routes.draw do
  root "pages#home"

  resources :opportunities, path: '/oportunidades', only: [:index, :show], path_names: {index: 'todos'}, controller: 'web/commercial/dashboards/sales'



  namespace :api, path: '/' do
    namespace :v1, path: '/' do
      namespace :commercial do

        namespace :config do
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
        end

        namespace :sales do

          namespace :opportunities do
            post "entities/list", to: "entities#list"
            post "entities/create", to: "entities#create"
            put "entities/update", to: "entities#update"

            post "products/list", to: "products#list"
            post "products/create", to: "products#create"
            put "products/update", to: "products#update"

            post "leads/list", to: "leads#list"
            post "leads/create", to: "leads#create"
            put "leads/update", to: "leads#update"

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
    end
  end

end
