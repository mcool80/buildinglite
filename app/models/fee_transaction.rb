class FeeTransaction < ActiveRecord::Base
  belongs_to :fee
  belongs_to :apartment
end
