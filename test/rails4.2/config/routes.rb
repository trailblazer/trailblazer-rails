Rails.application.routes.draw do
  resources :songs

  get "artists/dashboard", controller: :artists, action: :dashboard
end
