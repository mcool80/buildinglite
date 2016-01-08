class AddCommunityToApartments < ActiveRecord::Migration
  def change
    add_reference :apartments, :community, index: true
  end
end
