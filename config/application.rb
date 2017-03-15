require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
# require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DataCatalogBrowser
  class Application < Rails::Application
    # Settings in config/environments/* take precedence
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Exception handling via Rack middleware
    config.exceptions_app = lambda do |env|
      ExceptionController.action(:render_error).call(env)
    end
  end
end

# Additional libs to load
require 'kaminari'
require 'version'
require 'cairn_catalog_browser/version'
