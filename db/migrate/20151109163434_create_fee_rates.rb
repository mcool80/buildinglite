class CreateFeeRates < ActiveRecord::Migration
  def change
    create_table :fee_rates do |t|
      t.date :start_date
      t.date :end_date
      t.decimal :rate_apartment
      t.decimal :rate_cost
      t.references :fee, index: true

      t.timestamps null: false
    end
    add_foreign_key :fee_rates, :fees
  end
end
