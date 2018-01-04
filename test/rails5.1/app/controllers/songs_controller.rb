class SongsController < ApplicationController
  def new
    run Song::New
  end

  def show
    run Song::Show
  end

  def create
    run Song::Create do |result|
      return redirect_to song_path(result[:model].id)
    end

    render :new
  end

  def new_with_result
    result = run Song::New

    @class = result[:model].class
  end
end
