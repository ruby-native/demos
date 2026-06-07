Rails.application.routes.draw do
  resource :session
  resource :demo_session, only: :create

  resources :books, except: %i[edit update] do
    member do
      patch :change_status
      get "progress/edit", action: :progress, as: :edit_progress
      patch :progress, action: :update_progress
    end
    collection do
      get :manual
    end
  end

  get "discover", to: "pages#discover"
  get "stats",    to: "pages#stats"
  get "profile",  to: "pages#profile"

  get "up" => "rails/health#show", as: :rails_health_check

  root "books#index"
end
