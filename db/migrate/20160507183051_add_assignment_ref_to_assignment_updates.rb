class AddAssignmentRefToAssignmentUpdates < ActiveRecord::Migration
  def change
    add_reference :assignment_updates, :assignment, index: true
    add_foreign_key :assignment_updates, :assignments
  end
end
