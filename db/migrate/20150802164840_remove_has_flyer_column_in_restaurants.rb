class RemoveHasFlyerColumnInRestaurants < ActiveRecord::Migration
  def change
    remove_column :restaurants, :has_flyer
  end
end
