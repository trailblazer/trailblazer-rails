# controllers
class ApplicationController < ActionController::Base
  append_view_path "test/fake_app/views"
end

class SongsController < ApplicationController
  respond_to :json, :js

  def index
    @users = Song.all.page params[:page]
    render inline: <<-ERB
<%= render_cell(:user, :show, @users) %>
ERB
  end

  include Trailblazer::Operation::Controller
  respond_to :html

  def create
    respond Song::Create
  end

  def other_create
    respond Song::Create, location: other_create_songs_path, action: :another_view
  end

  def create_with_params
    respond Song::Create, params: {song: {title: "A Beautiful Indifference"}}
  end

  def create_with_block
    respond Song::Create do |op, formats|
      return render text: "block run, valid: #{op.valid?}"
    end
  end

  def create_with_namespace
    respond Song::Create::Json, namespace: [:api], is_document: true
  end

  def destroy
    respond Song::Delete
  end

  def destroy_with_formats
    respond Song::Delete do |op, formats|
      formats.js { render text: "#{op.model.class} slayer!" }
    end
  end
end

class BandsController < ApplicationController
  include Trailblazer::Operation::Controller
  respond_to :html, :json

  def index
    collection Band::Index
  end

  def show
    op = present Band::Update
    @klass    = op.model.class
    @locality = params[:band][:locality] unless params[:format] == "json"

    return render json: op.to_json if params[:format] == "json"
    render text: "bands/show: #{[@klass, @model.class, @operation.class, @locality, @form.inspect].join(',')}"
  end

  def new
    @returned_form = form Band::Create, locality: "Sydney" # #form returns form

    @locality = params[:band][:locality]

    # assigns @form
    # returns form from #form.
    render inline: <<-ERB
<%= form_for @form do |f| %>
  <%= f.text_field :name %>
  <a><%= @form.locality %></a>
<% end %>

<b><%= [@model.class, @form.is_a?(Reform::Form), @operation.class, @returned_form.is_a?(Reform::Form), @locality].join(",") %></b>
ERB
  end

  def create
    respond Band::Create, is_document: (request.format == :json)
  end

  def update
    run Band::Create

    render text: "no block: #{@operation.model.name}, #{params[:band][:locality]}, #{@operation.class}"
  end

  def update_with_block
    run Band::Create do |op|
      return render text: "[valid] with block: #{op.model.name}, #{params[:band][:locality]}"
    end

    render text: "[invalid] with block: #{@operation.model.name}, #{params[:band][:locality]}"
  end

private
  def process_params!(params) # this is where you set :current_user, etc.
    return if params[:format] == "json"

    params[:band] ||= {}
    params[:band][:locality] = "Essen"
  end
end

require 'trailblazer/operation/controller/active_record'
class ActiveRecordBandsController < ApplicationController
  include Trailblazer::Operation::Controller
  include Trailblazer::Operation::Controller::ActiveRecord
  respond_to :html

  def index
    collection Band::Index
    render text: "active_record_bands/index.html: #{@collection.class}, #{@bands.class}, #{@operation.class}"
  end

  def show
    present Band::Update

    render text: "active_record_bands/show.html: #{@model.class}, #{@band.class}, #{@form.inspect}, #{@operation.class}"
  end
end

class TenantsController < ApplicationController
  include Trailblazer::Operation::Controller
  include Trailblazer::Operation::Controller::ActiveRecord
  respond_to :html

  def show
    present Tenant::Show
    render text: "#{@tenant.name}" # model ivar doesn't contain table prefix `bla.xxx`.
  end
end

