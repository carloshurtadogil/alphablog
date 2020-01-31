Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # home route
  root 'pages#home'
  
  # about route
  get 'about', to: 'pages#about'

  # resources creates CRUD paths
  resources :articles
end
