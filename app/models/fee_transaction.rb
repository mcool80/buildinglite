class FeeTransaction < ActiveRecord::Base
  belongs_to :fee
  belongs_to :apartment

  # transaction_type has following values: input, debt, payment

  def is_currency 
    if self[:transaction_type] == "input"
      return false
    end
    return true
  end

end
