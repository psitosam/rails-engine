Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/find_all', to: 'searches#find_all_merchants'
      get '/merchants/find', to: 'searches#find'
      get '/items/find', to: 'searches#find_all_items'
      get '/items/find_all', to: 'searches#find_all_items'
      resources :merchants, only: [:index, :show] do
        resources :items, controller: 'merchant_items', action: :index
      end
      resources :items do
        resources :merchant, controller: 'merchant_items', action: :show
      end
    end
  end
end
