class Assignment < ActiveRecord::Base
  belongs_to :assignment_status
  belongs_to :user
  belongs_to :community
  has_many :assignment_updates, :dependent => :destroy

  def new_no(community)
    last_assignment = Assignment.where(:community_id => community.id).order(no: :desc).first
    if not last_assignment.nil? then
      return last_assignment.no + 1
    end
    return 1
  end
end
