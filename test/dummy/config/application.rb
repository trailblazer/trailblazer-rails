require File.expand_path("boot", __dir__)

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TrailblazerTestApp
  class Application < Rails::Application
    config.active_record.legacy_connection_handling = false if Rails.gem_version >= Gem::Version.new("6.1")
  end
end
