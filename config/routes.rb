Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # user signup route
  get 'signup', to: 'users#new'

  # user resources for CRUD paths
  resources :users, except: [:new]

  # home route
  root 'pages#home'
  
  # about route
  get 'about', to: 'pages#about'

  # routes for login form

  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy'

  # article resources creates CRUD paths
  resources :articles

  # category resources creates CRUD paths
  # Exception allows us to not create a destroy function
  resources :categories, except: [:destroy]
end
