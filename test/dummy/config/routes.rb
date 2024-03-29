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
  get "params/with_variables" => "songs#with_variables"

  get "cells/with_layout", controller: "cells/with_layout"
  get "cells/without_layout", controller: "cells/without_layout"
  get "cells/with_explicit_layout", controller: "cells/with_explicit_layout"
  get "cells/new", controller: "cells/new"

  get "extractable_keywords/extract_one", controller: "extractable_keywords/extract_one"
  get "extractable_keywords/extract_all", controller: "extractable_keywords/extract_all"

  get "songs/a/songs/new", controller: "songs_controller/a/songs", action: "new"
  get "songs/a/songs/create", controller: "songs_controller/a/songs", action: "create"
  get "songs/b/songs/create", controller: "songs_controller/b/songs", action: "create"
  get "songs/c/songs/create", controller: "songs_controller/c/songs", action: "create"
  get "songs/d/songs/create", controller: "songs_controller/d/songs", action: "create"
  get "songs/e/songs/create", controller: "songs_controller/e/songs", action: "create"
  get "songs/e/songs/patch",  controller: "songs_controller/e/songs", action: "patch" # not used for doc currently
  get "songs/e/songs/put",    controller: "songs_controller/e/songs", action: "put"   # not used for doc currently
end
