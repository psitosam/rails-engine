Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, controller: 'merchant_items', action: :index
      end
      resources :items do
        resources :merchant, controller: 'merchant_items', action: :show
      end
    end
  end 
end
