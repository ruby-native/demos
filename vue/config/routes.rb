Rails.application.routes.draw do
  resource :today, only: :show, controller: "today"

  resources :habits do
    resource :completion, only: [] do
      post :toggle, on: :collection
    end
  end

  resource :profile, only: %i[show edit update]
  resource :session, only: %i[new create destroy]

  get "up" => "rails/health#show", as: :rails_health_check

  root "today#show"
end
