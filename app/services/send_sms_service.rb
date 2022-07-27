class SendSmsService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    client = Twilio::REST::Client.new
    client.messages.create(
      from: Rails.application.credentials.twilio_phone_number,
      to: '+5585987786793',
      body: "#{user.full_name} a sua conta foi #{status} com sucesso!",
    )
  end

  private

  def status
    I18n.t(user.status, scope: 'municipe.status')
  end
end