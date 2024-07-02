Rails.application.routes.draw do
  resources :users

  post "/login", to: "auth#login"
  # Defines the root path route ("/")
  # root "posts#index"
end
