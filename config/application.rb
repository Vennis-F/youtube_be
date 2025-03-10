require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

require 'grape'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RemitanoBe
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Auto-load /bot and its subdirectories

    config.autoload_paths += Dir[Rails.root.join("app", "operations", "*")]
    config.autoload_paths += Dir[Rails.root.join('lib', '**/')]
    config.eager_load_paths << Rails.root.join('lib')

    config.middleware.use(Rack::Config) do |env|
      env["api.tilt.root"] = Rails.root.join("app", "views", "api")
    end

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end
