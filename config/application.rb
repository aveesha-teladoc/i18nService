require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module I18nService
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.before_initialize do
      TeladocCMS.config.app = 'poc'
      TeladocCMS.config.set_parent_controller('ApplicationController', skip_before_actions: [:verify_authenticity_token])
      TeladocCMS.config.country = TeladocCMS::LocalizationMapping::CMS_ANY_COUNTRY
      TeladocCMS.config.brand = TeladocCMS::LocalizationMapping::CMS_ANY_BRAND

      TeladocCMS.config.redis = {
        host: ENV['CMS_REDIS_HOST'] || ENV['REDIS_SERVICE_HOST'] || ENV['REDIS_HOST'] || 'localhost',
        port: ENV['CMS_REDIS_PORT'] || ENV['REDIS_SERVICE_PORT'] || ENV['REDIS_PORT'] || 6379,
        user: ENV['CMS_REDIS_USER'] || ENV['REDIS_USER'],
        password: ENV['CMS_REDIS_PASSWD'] || ENV['REDIS_PASSWD']
      }
    end
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

  end
end
