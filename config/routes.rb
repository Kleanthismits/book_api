Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books
      resources :authors, only: [:create]
      resources :publishers, only: [:create]
    end
  end
end
