class SongsController < ApplicationController
  def new
    run Song::Operation::New
  end

  def show
    run Song::Operation::Show
  end

  def create
    run Song::Operation::Create do
      return redirect_to song_path(@model.id)
    end

    render :new
  end

  def new_with_result
    run Song::Operation::New

    @class = @model.class
  end

  def with_variables
    run Params::Operation::WithVariables, controller_name: self.class.to_s

    render html: %{<h1>#{@model.inspect}</h1>}.html_safe
  end
end
