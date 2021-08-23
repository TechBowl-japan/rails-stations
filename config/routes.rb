Rails.application.routes.draw do
  # namespace :admin do
  #   get 'movies/index'
  #   get 'movies/show'
  # end
  # root 'application#hello'
  # resources :movies, only: [:index, :show] 
  #   namespace :admin do
  #     resources :movies, only: [:index, :new, :create, :show,  :edit, :destroy]
  #   end
  root 'application#hello'
  get '/movies', to: 'movies#view'
  resources :movies,path: '/admin/movies'
end