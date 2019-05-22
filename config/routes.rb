Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create]
  resources :session, only: [:new, :create]
  resources :goals
  root "goals#index"
end
