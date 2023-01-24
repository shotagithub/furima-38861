Rails.application.routes.draw do
  root to #index
  resources :items, only: [:index]
end
