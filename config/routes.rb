Rails.application.routes.draw do

  get 'sheets' => 'sheets#index'
  resources :movies

  namespace :admin do
    resources :movies
  end
end
