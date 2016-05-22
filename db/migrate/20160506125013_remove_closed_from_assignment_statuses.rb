class RemoveClosedFromAssignmentStatuses < ActiveRecord::Migration
  def change
    remove_column :assignment_statuses, :closed, :boolean
  end
end
