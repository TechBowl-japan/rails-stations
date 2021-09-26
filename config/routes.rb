Rails.application.routes.draw do

  resources :movies

  namespace :admin do
    resources :movies
  end
end
