Rails.application.routes.draw do
  devise_for :users
  resources :movements, only: [:index, :new, :create, :destroy]
  root "movements#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
