require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    
    # for rspec
    # Setting it to false will prevent unnecessary test files from being created.
    config.generators do |g|
      g.test_framework :rspec, 
      view_specs: false, 
      helper_specs: false, 
      controller_specs: false, 
      routing_specs: false
    end
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Tokyo"
    # config.eager_load_paths << Rails.root.join("extras")
    
    # 参照（https://yukimasablog.com/rails-field-with-errors）
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
  end
end
