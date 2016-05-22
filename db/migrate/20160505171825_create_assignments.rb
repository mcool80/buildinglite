class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :no
      t.string :reference
      t.string :text
      t.references :assignment_status, index: true
      t.timestamp :duedate
      t.references :user, index: true
      t.string :comment

      t.timestamps null: false
    end
    add_foreign_key :assignments, :assignment_statuses
    add_foreign_key :assignments, :users
  end
end
