class SongsController < ApplicationController
  def new
    run Song::New
    render
  end
end
