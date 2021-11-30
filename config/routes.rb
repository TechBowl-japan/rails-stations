Rails.application.routes.draw do
  get '/', to: 'movies#index'

  namespace :admin do
    resources :movies
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
