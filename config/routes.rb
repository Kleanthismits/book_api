Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :books
      resources :authors, only: [:create]
      resources :publishers, only: [:create]
    end
  end
end
