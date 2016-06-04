class AddCloseDateToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :close_date, :date
  end
end
