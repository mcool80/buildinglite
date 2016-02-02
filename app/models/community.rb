class Community < ActiveRecord::Base
  has_many :apartments
  has_many :users, through: :apartments
  has_many :fees
end
