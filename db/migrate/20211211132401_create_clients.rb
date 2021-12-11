class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :phone_number
      t.string :email 
      t.string :country_code
      t.string :passord_digest

      t.timestamps
    end
  end
end
