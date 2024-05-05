Rails.application.routes.draw do
  devise_for :users

  resources :movies do
    member do
      get 'reservation', to: 'movies#reservation'
      resources :reservations
    end

    resources :schedules do
      resources :reservations
    end
    
    resources :sheets
    resources :reservations
    resources :screens
  end

  resources :sheets
  resources :reservations

  namespace :admin do
    resources :screens
    resources :reservations
    resources :movies do
      resources :schedules, only: %i[new create]
    end
    resources :schedules, except: %i[new create]
  end
end