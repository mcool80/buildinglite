class Apartment < ActiveRecord::Base
  belongs_to :community
  has_many :users
  has_many :fee_transactions, :dependent => :delete_all

  def find_fee_transaction(fee, date, transaction_type)
    last_input = FeeTransaction.where(apartment_id: self[:id], transaction_type: transaction_type, fee_id: fee.id).where('start_date <= ?', date).order(start_date: :desc)
     return last_input.first
  end
end
