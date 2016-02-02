class AddColumnPaymentIntervalOnFee < ActiveRecord::Migration
  def change
    add_column :fees, :payment_interval, :string
  end
end
