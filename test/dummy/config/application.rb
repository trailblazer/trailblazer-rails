require File.expand_path("boot", __dir__)

require "rails"
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"

Bundler.require(*Rails.groups)

module TrailblazerTestApp
  class Application < Rails::Application
    config.load_defaults Rails.gem_version.to_s.split(".")[0..1].join(".")
    config.active_record.legacy_connection_handling = false if Rails.gem_version >= Gem::Version.new("6.1")
    config.cache_classes = true
    config.eager_load = false
    config.serve_static_files = false
    config.public_file_server.enabled = false
    config.public_file_server.headers = {"Cache-Control" => "public, max-age=3600"}
    config.consider_all_requests_local       = true
    config.action_controller.perform_caching = false
    config.action_dispatch.show_exceptions = false
    config.action_controller.allow_forgery_protection = false
    config.active_support.test_order = :random
    config.active_support.deprecation = :stderr
    if Rails.gem_version < Gem::Version.new("6.0")
      config.active_record.sqlite3.represent_boolean_as_integer = true
    end
    Rails.backtrace_cleaner.remove_silencers!
  end
end
