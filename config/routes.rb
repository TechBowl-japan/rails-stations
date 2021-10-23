Rails.application.routes.draw do
  namespace :admin do
    resources :movies
  end
  resources :movies, only: [ :index ] do
    get :search_movie, on: :collection
  end

  # get '*path', to: 'application#rescue404'
end
