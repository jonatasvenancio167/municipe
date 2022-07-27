class AddMunicipeToAddress < ActiveRecord::Migration[7.0]
  def change
    add_reference :addresses, :municipe, null: false, foreign_key: true
  end
end
