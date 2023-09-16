Rails.application.routes.draw do
  resources :sells do
    post '/filter', to: 'sells#filter', on: :collection
    resources :article_sells
  end

  resources :categories

  resources :articles do
    get '/add_categories', to: 'articles#add_categories', on: :member
    post '/save_categories', to: 'articles#save_categories', on: :member
    post '/search_by_name', to: 'articles#search_by_name', on: :collection
    post '/filter', to: 'articles#filter', on: :collection
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/settings', to: 'pages#settings'
  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#dashboard'
end
