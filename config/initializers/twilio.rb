require 'twilio-ruby'

Twilio.configure do |config|
  config.account_sid = Rails.application.credentials.twilio_account_sid
  config.auth_token = Rails.application.credentials.twilio_account_token
end