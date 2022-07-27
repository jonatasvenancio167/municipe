class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :cep
      t.string :public_place
      t.string :complement
      t.string :neighborhood
      t.string :city
      t.string :uf
      t.string :ibge_code

      t.timestamps
    end
  end
end
