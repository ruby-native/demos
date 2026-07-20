Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  get "testing", to: "testing#index", as: :testing

  get "today", to: "today#index", as: :today
  get "inbox", to: "inbox#index", as: :inbox
  get "done", to: "done#index", as: :done

  resource :profile, only: [ :show, :edit, :update ]

  resources :todos do
    member do
      patch :complete
      patch :uncomplete
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "today#index"
end
