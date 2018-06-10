Rails.application.routes.draw do
  resources :posts, only: [:create, :index]
  resource :marks, only: [:create]
  resources :ip_addresses, only: [:index]
end
