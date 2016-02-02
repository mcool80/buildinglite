class User < ActiveRecord::Base
  belongs_to :apartment
  has_one :community, :through => :apartment
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def is_administrator
    return (self[:user_type] == "administrator" ? true : false)
  end
end
