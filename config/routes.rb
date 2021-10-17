Rails.application.routes.draw do
  namespace :admin do
    resources :movies
  end
  resources :movies, only: [ :index ]

  get '*path', to: 'application#rescue404'
end
