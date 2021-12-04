Rails.application.routes.draw do
  get 'sheets/', to: 'sheets#index'
  namespace :admin do
    resources :movies
  end
  get '/movies', to: 'movies#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
