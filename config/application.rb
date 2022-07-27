require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.test_driver = :selenium_chrome

    config.i18n.available_locales = ['pt-BR']
    config.i18n.default_locale = "pt-BR"
    config.time_zone = 'America/Sao_Paulo'

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.default_url_options = { host: 'localhost:3000', protocol: 'http' }
    config.action_mailer.smtp_settings = {
      address:              'smtp.gmail.com',
      domain:               'smpt.gmail.com',
      port:                 587,
      user_name:            ENV['USER_NAME_EMAIL'],
      password:             ENV['PASSWORD_EMAIL'],
      authentication:       'plain',
      enable_starttls_auto: true,
    }

  end
end
