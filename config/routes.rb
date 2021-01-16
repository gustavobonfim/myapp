Rails.application.routes.draw do
  root "pages#home"

  resources :opportunities, path: '/oportunidades', only: [:index, :show], path_names: {index: 'todos'}, controller: 'web/commercial/sales/opportunities/entities'



  namespace :api, path: '/' do
    namespace :v1, path: '/' do
      namespace :commercial do

        namespace :marketing do
        end

        namespace :sales do

          namespace :opportunities do
            post "entities/list", to: "entities#list"
            post "entities/create", to: "entities#create"
            put "entities/update", to: "entities#update"
          end

        end
      end
    end
  end

end
