class RemoveCampusIdFromRestaurants < ActiveRecord::Migration
  def change
    remove_index :restaurants, [:campus_id]
    remove_column :restaurants, :campus_id
  end
end
