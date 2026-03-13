Rails.application.routes.draw do
  resources :categories, only: [:index, :show], path: "menu" do
    resources :items, only: [:show], controller: "products"
  end

  resource :cart, only: [:show] do
    resources :cart_items, only: [:create, :update, :destroy], path: "items"
  end

  resources :orders, only: [:index, :show, :create]
  resource :rewards, only: [:show]
  resource :account, only: [:show, :edit, :update]
  resource :session, only: [:new, :create, :destroy]
  resource :guest_session, only: [:create]
  resource :registration, only: [:new, :create]

  # OAuth callbacks.
  get "/auth/:provider", to: redirect("/session/new")
  get "/auth/:provider/callback", to: "omniauth_callbacks#create"
  post "/auth/:provider/callback", to: "omniauth_callbacks#create"
  get "/auth/failure", to: "omniauth_callbacks#failure"

  root "pages#landing"

  get "up" => "rails/health#show", as: :rails_health_check
end
