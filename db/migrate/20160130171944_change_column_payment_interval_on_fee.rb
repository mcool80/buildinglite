class ChangeColumnPaymentIntervalOnFee < ActiveRecord::Migration
  def change
    rename_column :fees, :payment_interval, :fee_type
  end
end
