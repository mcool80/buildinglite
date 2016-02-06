class Apartment < ActiveRecord::Base
  belongs_to :community
  has_many :users
  has_many :fee_transactions, :dependent => :delete_all

end
