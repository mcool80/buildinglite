class AddOrderKeyToAssignmentStatus < ActiveRecord::Migration
  def change
    add_column :assignment_statuses, :order_key, :integer
  end
end
