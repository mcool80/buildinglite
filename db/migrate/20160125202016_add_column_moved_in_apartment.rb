class AddColumnMovedInApartment < ActiveRecord::Migration
  def change
    add_column :apartments, :moved, :date
  end
end
