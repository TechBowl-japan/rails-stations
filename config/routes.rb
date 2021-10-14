Rails.application.routes.draw do
  namespace :admin do
    resources :movies, only: [ :index, :new, :create ]
  end
  resources :movies, only: [ :index ]

  # get '*path', to: 'application#rescue404'
end
