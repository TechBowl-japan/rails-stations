Rails.application.routes.draw do
  resources :movies
  get '/sheets', to: 'sheets#index'
  namespace :admin do
    resources :movies
    resources :schedules
    resources :movies do
      resources :schedules, except: [:edit]
      get '/schedules/:id', to: 'schedules#edit'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
