Rails.application.routes.draw do
  root "application#hello"
  get "movies" => "application#movies"
end
