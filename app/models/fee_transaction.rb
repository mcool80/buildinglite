class FeeTransaction < ActiveRecord::Base
  belongs_to :fee
  belongs_to :apartment
  def is_currency 
    if self[:transaction_type] == "input" 
      return false
    end
    return true
  end
end
