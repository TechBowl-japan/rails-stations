Rails.application.routes.draw do
  resources :sheets, only: [:index]
  namespace :admin do
    resources :movies do
      resources :schedules, only: [:create]
    end
  end
  resources :movies, only: [:index] do
    get :search_movie, on: :collection
  end

  # get '*path', to: 'application#rescue404'
end
