class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.text :address
      t.text :apartment_no

      t.timestamps null: false
    end
  end
end
