class Fee < ActiveRecord::Base
  belongs_to :community
  has_many :fee_transactions, :dependent => :delete_all

  enum fee_type_value: {no_user_input: 0, user_input: 1}

  def get_sum(start_date, end_date, apartment_id, type)
    payment = FeeTransaction.where(fee_id: self[:id], apartment_id: apartment_id, transaction_type: type).where('start_date <= ?', start_date)
    if payment.empty? then
      return 0
    end
    date_pointer = start_date
    payment_value = 0
    while date_pointer < end_date do
      payment = FeeTransaction.where(fee_id: self[:id], apartment_id: apartment_id, transaction_type: type).where('start_date <= ?', date_pointer).order(start_date: :desc).limit(1)
      payment_value += payment[0].value
      date_pointer = date_pointer + 1.month
    end
    return payment_value
  end
end
