Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # /movies
  resources :movies, only: [:index, :show] do
    get "reservation", to: "movies#reservation"

    resources :schedule, only: [] do
      resources :reservations, only: [:new, :create]
    end
  end
  # /sheets
  resources :sheets, only: [:index]

  # /reservations
  resources :reservations, only: [:create]

  # /admin
  namespace :admin do
    resources :movies, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
      resources :schedules, only: [:new, :create]
    end

    resources :schedules, only: [:index, :show, :edit, :update, :destroy]
  end
  # Defines the root path route ("/")
  # root "posts#index"
end
