Rails.application.routes.draw do
  resources :movies
  get '/sheets', to: 'sheets#index'
  namespace :admin do
    resources :movies
    resources :schedules, except: [:edit, :new]
    resources :movies do
      resources :schedules, only: [:edit, :new]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
