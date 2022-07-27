require 'rails_helper'

RSpec.describe Address, type: :model do

  context 'validates' do
    [:city, :public_place, :neighborhood, :uf].each do |field|
      it { should validate_presence_of(field) }
    end
  end
end