class User < ActiveRecord::Base
  belongs_to :apartment
  has_one :community, :through => :apartment
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?(admin_params = {})
    if admin_params.has_key?(:apartment) then
      apartment = admin_params.fetch(:apartment)
    else 
      apartment = self.apartment
    end
    if admin_params.has_key?(:community) then
      community = admin_params.fetch(:community)
    else
      community = self.community
    end
    return (self[:user_type] == "administrator" && self.community == apartment.community && self.community == community)
  end
  
  def super_admin?(community = nil)
    return false
  end
end
