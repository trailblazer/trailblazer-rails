Rails.application.routes.draw do
  resources :songs
  get "artists/dashboard", controller: :artists, action: :dashboard
  get "artists/dashboard/widget", controller: :artists, action: :widget
  resources :artists
end
