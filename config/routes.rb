Rails.application.routes.draw do
  resource :posts, only: [:create]
  resources :marks, only: [:create, :index]
  resources :ip_addresses, only: [:index]
end
