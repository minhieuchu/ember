Rails.application.routes.draw do
  resources :channels
  resources :users
  resources :direct_messages, only: [:create, :update, :destroy] do
    collection do
      get "chat/:user_id", to: "direct_messages#chat"
    end
  end

  post "/auth/login", to: "auth#login"
end
