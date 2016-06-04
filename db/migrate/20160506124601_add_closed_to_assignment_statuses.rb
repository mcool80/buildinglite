class AddClosedToAssignmentStatuses < ActiveRecord::Migration
  def change
    add_column :assignment_statuses, :closed, :boolean
  end
end
