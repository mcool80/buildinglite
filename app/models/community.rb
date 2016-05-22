class Community < ActiveRecord::Base
  has_many :apartments, :dependent => :destroy
  has_many :users, through: :apartments
  has_many :fees, :dependent => :destroy
  has_many :assignments
  has_many :assignment_statuses

  def assignment_status_close
    self.assignment_statuses.where(:close_state => true).first
  end
end
