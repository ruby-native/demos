Rails.application.routes.draw do
  resource :session

  resources :books do
    patch :finish, on: :member
    resources :notes, only: [:new, :create]
  end

  get "discover", to: "pages#discover"
  get "stats",    to: "pages#stats"
  get "profile",  to: "pages#profile"

  get "up" => "rails/health#show", as: :rails_health_check

  root "books#index"
end
