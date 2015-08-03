class RemoveIsNewFromRestaurants < ActiveRecord::Migration
  def change
    remove_column :restaurants, :is_new
  end
end
