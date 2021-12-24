Rails.application.routes.draw do
  resources :movies do
    resources :schedules do 
      resources :sheets
      resources :reservations
    end
  end
  
  namespace :admin do
    resources :schedules
    resources :movies do
      resources :schedules 
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
