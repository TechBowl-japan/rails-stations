Rails.application.routes.draw do
  resources :movies
  resources :schedules
  get '/sheets', to: 'sheets#index'
  namespace :admin do
    resources :schedules
    resources :movies
    resources :movies do
      resources :schedules, only: [:index]
      get '/schedules/:id', to: 'schedules#edit'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
