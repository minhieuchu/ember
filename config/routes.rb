Rails.application.routes.draw do
  resources :channels
  resources :users

  post "/login", to: "auth#login"
  # Defines the root path route ("/")
  # root "posts#index"
end
