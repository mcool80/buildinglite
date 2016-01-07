class CreateFees < ActiveRecord::Migration
  def change
    create_table :fees do |t|
      t.text :name
      t.integer :payment_interval
      t.string :currency
      t.string :unit
      t.references :community, index: true

      t.timestamps null: false
    end
    add_foreign_key :fees, :communities
  end
end
