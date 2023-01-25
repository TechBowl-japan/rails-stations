Rails.application.routes.draw do
  resources :movies
  root "application#hello"
end
