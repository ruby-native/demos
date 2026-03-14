Rails.application.routes.draw do
  resources :neighborhoods, only: [:index, :show]
  resources :breweries, only: [:index, :show] do
    resource :stamp, only: [:create, :destroy]
    resource :bookmark, only: [:create, :destroy]
  end

  resource :session, only: [:new, :destroy]
  resource :passport, only: [:show]
  resource :profile, only: [:show, :destroy]

  get "/auth/:provider", to: redirect("/session/new")
  get "/auth/:provider/callback", to: "omniauth_callbacks#create"
  post "/auth/:provider/callback", to: "omniauth_callbacks#create"
  get "/auth/failure", to: "omniauth_callbacks#failure"

  get "explore", to: "neighborhoods#index"
  get "terms", to: "pages#terms"
  get "privacy", to: "pages#privacy"

  root "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check
end
