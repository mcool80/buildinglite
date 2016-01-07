class CreateFeeTransactions < ActiveRecord::Migration
  def change
    create_table :fee_transactions do |t|
      t.date :start_date
      t.date :end_date
      t.string :transaction_type
      t.decimal :value
      t.references :fee, index: true
      t.references :apartment, index: true

      t.timestamps null: false
    end
    add_foreign_key :fee_transactions, :fees
    add_foreign_key :fee_transactions, :apartments
  end
end
