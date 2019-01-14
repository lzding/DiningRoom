require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DiningRoom
  class Application < Rails::Application

    config.paths['config/database']='config/database.yml'
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    # for the api
    %w{models api service presenters caches}.each do |namespace|
      config.paths.add File.join('app', namespace), glob: File.join('**', '*.rb')
      config.autoload_paths += Dir[Rails.root.join('app', namespace, '**')]
    end

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
