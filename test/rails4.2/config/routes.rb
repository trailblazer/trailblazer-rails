Rails.application.routes.draw do
  resources :songs
  get "songs/new_with_result", controller: :songs, action: :new_with_result
  get "artists/dashboard", controller: :artists, action: :dashboard
  get "artists/dashboard/widget", controller: :artists, action: :widget
  resources :artists

  get "params/with_args", controller: "params/with_args"
end
