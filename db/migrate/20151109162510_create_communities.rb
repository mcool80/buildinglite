class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.text :name
      t.text :description

      t.timestamps null: false
    end
  end
end
