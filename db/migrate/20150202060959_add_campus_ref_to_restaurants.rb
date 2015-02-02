class AddCampusRefToRestaurants < ActiveRecord::Migration
  def change
    add_reference :restaurants, :campus, index: true
  end
end
