require 'action_controller/railtie'
require 'action_view/railtie'
require 'active_record'
require 'responders'
require 'fake_app/config'
# config
app = Class.new(Rails::Application)

require 'reform/rails'
if defined?(Dry)
  Rails.application.config.reform.validations = :dry
end

app.config.secret_token = '3b7cd727ee24e8444053437c36cc66c4'
app.config.session_store :cookie_store, key: '_myapp_session'
app.config.active_support.deprecation = :log
app.config.eager_load = false
# Rails.root
app.config.root = File.dirname(__FILE__)
Rails.backtrace_cleaner.remove_silencers!
app.initialize!

# routes
app.routes.draw do

  resources :songs do
    member do # argh.
      delete :destroy_with_formats
    end

    collection do
      post :other_create
      post :create_with_params
      post :create_with_block
      post :create_with_namespace
    end
  end

  resources :active_record_bands

  resources :bands do
    collection do
      post :create
      get :new_with_block
    end

    member do
      post :update_with_block
    end
  end

  namespace :rails_endpoint do
    namespace :unconfigured_test do
      resources :bands
    end
    namespace :configured_test do
      resources :bands
    end
  end

  namespace :api do
    resources :songs
  end

  resources :tenants, only: [:show]

  resources :concerts, only: [:create, :show]
end

require 'trailblazer/operation/responder'
require 'trailblazer/operation/controller'
require 'trailblazer/operation/representer'

require 'fake_app/models'
if defined?(Dry)
  require 'fake_app/concert/operations.rb'
  require 'fake_app/controllers_with_dry'
end

require 'fake_app/controllers.rb'
require 'fake_app/song/operations.rb'


# helpers
Object.const_set(:ApplicationHelper, Module.new)
