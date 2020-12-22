Rails.application.routes.draw do
  resources :songs
  get "songs/new_with_result", controller: :songs, action: :new_with_result

  get "artists/with_expose", controller: "artists/with_expose"
  get "artists/with_expose_and_args", controller: "artists/with_expose_and_args"

  get "artists/dashboard", controller: :artists, action: :dashboard
  get "artists/dashboard/widget", controller: :artists, action: :widget
  resources :artists

  get "args/with_args", controller: "args/with_args"
  get "params/with_args", controller: "params/with_args"
end
