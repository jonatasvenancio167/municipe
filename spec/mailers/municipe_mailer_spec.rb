require "rails_helper"

RSpec.describe MunicipeMailer, type: :mailer do
  describe 'welcome_email' do
    let(:municipe) { build(:municipe) }
    let(:mail) { described_class.with(user: municipe).welcome_email.deliver_now! }

    it 'renders the subject' do
      expect(mail.subject).to eq('Cadastro realizado no municipe')
    end

    it "renders the receiver email" do
      expect(mail.to).to eq(["teste@email.com"])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(['noreply@municipe.com'])
    end

    it 'assigns @user' do
      expect(mail.body.encoded).to match(municipe.full_name)
    end
  end
end