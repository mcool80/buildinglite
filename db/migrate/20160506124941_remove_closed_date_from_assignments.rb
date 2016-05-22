class RemoveClosedDateFromAssignments < ActiveRecord::Migration
  def change
    remove_column :assignments, :closed_date, :date
  end
end
