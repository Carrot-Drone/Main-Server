class AddIsClosedToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :is_closed, :boolean, :default => false
  end
end
