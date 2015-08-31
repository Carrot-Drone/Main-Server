class RemoveFlyerPathColumnInRestaurantsTable < ActiveRecord::Migration
  def change
    remove_column :restaurants, :flyer_path
  end
end
