Rails.application.routes.draw do
  namespace :admin do
    resources :users do
      patch '/update/profile', to: 'users#update_profile', on: :member
    end
  end
  # User Authentication routes.
  resources :users, only: %i[create] do
    resources :profiles
  end
  # get '/signup', to: 'users#new'
  get '/users/:token_id', to: 'users#show', as: 'user'
  get '/users/edit/:token_id', to: 'users#edit', as: 'edit_user'
  patch '/users/edit/:token_id', to: 'users#update', as: 'update_user'
  delete '/users/destroy/:token_id', to: 'users#destroy', as: 'destroy_user'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#logout'
  get '/password/recover', to: 'sessions#recover', as: 'recover_password'
  post '/password/reset', to: 'sessions#reset_password', as: 'reset_password'
  get '/reset/password/form/:recover_password_token', to: 'sessions#reset_password_form', as: 'reset_password_form'
  post '/password/update', to: 'sessions#update_password', as: 'update_password'
  # get '/email/confirmation/:token_id', to: 'users#confirm_account', as: 'confirm_user_account'

  resources :sells do
    get '/export/pdf', to: 'sells#export_pdf', on: :member
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
  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#dashboard'
end
