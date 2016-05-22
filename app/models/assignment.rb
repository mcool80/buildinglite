class Assignment < ActiveRecord::Base
  belongs_to :assignment_status
  belongs_to :user
  belongs_to :community
  has_many :assignment_updates

  def status
    if not self.assignment_status.nil? then
      self.assignment_status.status
    end
  end
  def user_first_name
    if not self.user.nil? then
      self.user.first_name
    end
  end
  def user_last_name
    if not self.user.nil? then
      self.user.last_name
    end
  end
end
