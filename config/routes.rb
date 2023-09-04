Rails.application.routes.draw do
  resources :categories
  resources :articles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/settings', to: 'pages#settings'
  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#dashboard'
end
