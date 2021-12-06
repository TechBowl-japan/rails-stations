Rails.application.routes.draw do
  namespace :admin do
    resources :movies do
      resources :schedules, only: [:index]
      get '/schedules/:id', to: 'schedules#edit'
    end
  end
  resources :movies
  resources :schedules
  get '/sheets', to: 'sheets#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
