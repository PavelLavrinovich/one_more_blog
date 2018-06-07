Rails.application.routes.draw do
  resource :posts, only: [:create]
end
