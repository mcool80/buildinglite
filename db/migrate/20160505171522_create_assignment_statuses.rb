class CreateAssignmentStatuses < ActiveRecord::Migration
  def change
    create_table :assignment_statuses do |t|
      t.string :status

      t.timestamps null: false
    end
  end
end
