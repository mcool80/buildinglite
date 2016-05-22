class CreateAssignmentUpdates < ActiveRecord::Migration
  def change
    create_table :assignment_updates do |t|
      t.text :update_text

      t.timestamps null: false
    end
  end
end
