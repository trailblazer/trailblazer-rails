class SongsController < ApplicationController
  def new
    run Song::New
  end

  def show
    run Song::Show
  end

  def create
    run Song::Create do
      return redirect_to song_path(@model.id)
    end

    render :new
  end

  def new_with_result
    run Song::New

    @class = @model.class
  end

  def with_variables
    run Params::WithVariables, controller_name: self.class.to_s

    render html: %{<h1>#{@model.inspect}</h1>}.html_safe
  end
end
