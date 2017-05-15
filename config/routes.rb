Courses::Application.routes.draw do
  resources :users do
    collection { post :import}
  end

  resources :posts do
    collection { post :import}
  end

  root to: "static_pages#index"
  get "/home" => "static_pages#index"

  resources :sessions, only: [:new, :create, :destroy]

  match 'index', to: 'static_pages#index', via: [:get, :post]


  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

  resources :posts
  resources :books do
    post 'search', on: :collection
  end

  get "static_pages/update_users_list" => 'static_pages#update_users_list', as: "update_users_list"
end
