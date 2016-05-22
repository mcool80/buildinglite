class AddClosedDateToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :closed_date, :date
  end
end
