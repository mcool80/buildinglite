class Community < ActiveRecord::Base
  has_many :apartments, :dependent => :destroy
  has_many :users, through: :apartments
  has_many :fees, :dependent => :destroy
end
