FactoryBot.define do
  factory :municipe do

    address
    full_name { 'teste 1' }
    cns { '203292848870007' }
    cpf { '91953400094' }
    email { 'teste@email.com' }
    telephone { '5585999999999' }
    birth_date { 18.years.ago }
    status { true }

  end
end
