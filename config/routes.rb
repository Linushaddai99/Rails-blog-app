Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  # get "/users", to: "users#index"
  # get "/users/:id", to: "users#show"
  # get "/users/:user_id/posts", to: "posts#index"
  # get "/users/:user_id/posts/:id", to: "posts#show"
  # resources :users
  # resources :posts

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:create]
      resources :likes, only: [:create]
    end
  end

end