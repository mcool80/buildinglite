class AddCommunityRefToAssignmentStatus < ActiveRecord::Migration
  def change
    add_reference :assignment_statuses, :community, index: true
    add_foreign_key :assignment_statuses, :communities
  end
end
