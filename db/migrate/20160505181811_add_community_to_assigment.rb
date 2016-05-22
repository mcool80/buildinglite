class AddCommunityToAssigment < ActiveRecord::Migration
  def change
    add_reference :assignments, :community, index: true, foreign_key: true
  end
end
