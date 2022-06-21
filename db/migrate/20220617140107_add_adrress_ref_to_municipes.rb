class AddAdrressRefToMunicipes < ActiveRecord::Migration[5.2]
  def change
    add_reference :municipes, :address, foreign_key: true
  end
end
