Rails.application.routes.draw do
  get 'movies/index'
  root 'application#hello'
  resources :movies
end
