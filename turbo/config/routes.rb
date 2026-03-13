Rails.application.routes.draw do
  resources :links do
    resource :reminder, only: :create
  end
  resources :tags, only: %i[index show]
  resource :profile, only: %i[show edit update]
  resource :search, only: :show
  resource :session, only: %i[new create destroy]
  resource :registration, only: %i[new create]

  mount PurchaseKit::Engine, at: "/purchasekit"

  root "pages#landing"
end
