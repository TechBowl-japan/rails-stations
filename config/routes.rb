Rails.application.routes.draw do
  root 'application#hello'
  resources :movies #path: '/admin/movies'
end
