Rails.application.routes.draw do
  namespace :admin do
    resources :movies
  end
  get '/movies', to: 'movies#index'
  get '/sheets', to: 'sheets#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
