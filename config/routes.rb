Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show, :new, :create] do
    resources :comments, only: [:index, :show, :create, :destroy]
  end
  resources :session, only: [:new, :create, :destroy]
  resources :goals do
    resources :comments, only: [:index, :show, :create, :destroy]
  end
  root "users#index"
end
