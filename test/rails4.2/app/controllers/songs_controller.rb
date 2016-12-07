class SongsController < ApplicationController
  def new
    run Song::New
    render
  end

  def show
    run Song::Show
    render
  end

  def create
    run Song::Create do |result|
      return redirect_to song_path(result["model"].id)
    end

    render :new
  end
end
