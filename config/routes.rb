Rails.application.routes.draw do
  resources :sells
  resources :categories
  resources :articles do
    get '/add_categories', to: 'articles#add_categories', on: :member
    post '/save_categories', to: 'articles#save_categories', on: :member
    # patch '/set_categories', to: ''
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/settings', to: 'pages#settings'
  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#dashboard'
end
