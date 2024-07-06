Rails.application.routes.draw do
  resources :channels
  resources :users

  post "/auth/login", to: "auth#login"
  # Defines the root path route ("/")
  # root "posts#index"
end
