class ChangeDateInAssignments < ActiveRecord::Migration
  def change
    change_column :assignments, :duedate, :date
  end
end
