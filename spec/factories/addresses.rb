FactoryBot.define do
  factory :address do
    cep { '44218970' }
    city { 'Acupe' }
    public_place { 'Rua Edval Barreto' }
    neighborhood { 'Centro' }
    uf { 'BA' }
    ibge_code { '123456' }
  end
end
