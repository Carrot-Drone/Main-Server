class AddIsNewToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :is_new, :boolean, :default =>false 
  end
end
