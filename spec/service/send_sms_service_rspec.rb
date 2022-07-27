# frozen_string_literal: true

require 'rails-helper'

RSpec.describe SendSmsService, method: :service do
  let(:municipe) { build(:municipe) }
  let(:send_sms) { described_class(municipe) }

  context '#call' do
    subject { send_sms.call }

    before do
    end

    it 'request send email' do

    end
  end
end