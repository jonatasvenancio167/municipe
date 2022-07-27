require 'rails_helper'

RSpec.describe Municipe, type: :model do

  describe '#validate_age' do
    let(:municipe) { build(:municipe, birth_date: Date.today) }
    subject { municipe.validate_age }

    it { is_expected.to eq('Você deve ter mais de 18 anos') }
  end

  describe '#cpf_valid?' do
    context 'generate cpf digit invalid' do
      let!(:cpf_digit_invalid) { build(:municipe, cpf: '123.456.789-09', cns: '000 1111 2211 321') }

      it 'cpf digit_invalid' do
        expect(cpf_digit_invalid).to be_invalid
        expect(cpf_digit_invalid.errors[:cpf]).not_to be_empty
        expect(cpf_digit_invalid.errors[:cpf]).to eq([I18n.t("cpf_is_not_invalid")])
      end

    end

    context 'generate cpf invalid' do
      let(:cpf_invalid) { build(:municipe, cpf: '123.456.129-11', cns: '000 1111 2211 321' ) }

      it 'cpf invalid' do
        expect(cpf_invalid).to be_invalid
        expect(cpf_invalid.errors[:cpf]).not_to be_empty
        expect(cpf_invalid.errors[:cpf]).to eq([I18n.t("cpf_is_not_invalid")])
      end
    end

    context 'cpf valid' do
      let(:cpf) { build(:municipe) }
      subject { cpf.cpf_valid? }

      it { is_expected.to eq(true) }
    end
  end

  describe '#cns_valid?' do
    context 'cns invalid' do
      let(:cns) { build(:municipe, cpf: '123.456.129-11', cns: '000 1111 2211 3211') }

      it 'generate cns invalid' do
        expect(cns).to be_invalid
        expect(cns.errors[:cns]).not_to be_empty
        expect(cns.errors[:cns]).to eq([I18n.t("cns_is_not_invalid")])
      end
    end

    context 'cns invalid' do
      let(:cns) { build(:municipe, cpf: '123.456.129-11', cns: '000 1111 2211 321') }

      it 'generate cns invalid' do
        expect(cns).to be_invalid
        expect(cns.errors[:cns]).not_to be_empty
        expect(cns.errors[:cns]).to eq([I18n.t("cns_incomplete")])
      end
    end
  end
end
