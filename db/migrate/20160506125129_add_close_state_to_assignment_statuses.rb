class AddCloseStateToAssignmentStatuses < ActiveRecord::Migration
  def change
    add_column :assignment_statuses, :close_state, :boolean
  end
end
