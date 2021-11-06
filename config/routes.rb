Rails.application.routes.draw do
  resources :sheets, only: [:index]
  namespace :admin do
    resources :movies
  end
  resources :movies, only: [:index, :show] do
    resources :schedules, only: [:index]
    get :search_movie, on: :collection
  end

  # get '*path', to: 'application#rescue404'
end
