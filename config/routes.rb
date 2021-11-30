Rails.application.routes.draw do
  get '/', to: 'movies#index'

  namespace :admin do
    get 'movies', to: 'movies#index'
    get 'movies/new', to:'movies#new'
    post 'movies', to:'movies#create'
    get 'movies/:id/edit', to:'movies#edit'
    patch 'movies/:id', to:'movies#update'
    put 'movies/:id', to:'movies#update'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
