class AssignmentStatus < ActiveRecord::Base
  belongs_to :community
  has_many :assignment_status
  validate :validate_close_state

  def validate_close_state
    if self.close_state and AssignmentStatus.where(community_id: self.community_id, close_state: true).count > 0 then
      errors.add(:close_state, 'Can only be one close state')
    end
  end
end
