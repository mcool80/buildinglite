class Fee < ActiveRecord::Base
  belongs_to :community

  def get_sum(start_date, end_date, apartment_id, type)
    payment = FeeTransaction.where(fee_id: self[:id], apartment_id: apartment_id, transaction_type: type).where('start_date <= ?', start_date).order(start_date: :desc).limit(1)
    date_pointer = start_date
    payment_value = 0
    while date_pointer < end_date do
      payment = FeeTransaction.where(fee_id: self[:id], apartment_id: apartment_id, transaction_type: type).where('start_date <= ?', date_pointer).order(start_date: :desc).limit(1)
      payment_value += payment[0].value
      date_pointer = date_pointer + 1.month
    end
    return payment_value
  end

  def get_fee_value(date, apartment_id, type)
     last_input = FeeTransaction.where(apartment_id: apartment_id, transaction_type: type, fee_id: self[:id]).where('start_date <= ?', date).order(start_date: :desc)
     return last_input.first.start_date, last_input.first.value
  end
end
