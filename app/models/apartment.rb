class Apartment < ActiveRecord::Base
  belongs_to :community
  has_many :users

end
