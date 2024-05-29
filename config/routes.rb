Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'movies#index'
  resources :movies, only: [:index, :show]
  resources :sheets, only: [:index]

  namespace :admin do
    resources :movies, only: [:index, :new, :show, :edit, :update, :create, :destroy] do
      resources :schedules, only: [:new]
    end
    resources :schedules, only: [:index, :show, :edit, :create, :update, :destroy]
  end
end
