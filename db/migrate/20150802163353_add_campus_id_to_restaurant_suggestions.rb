class AddCampusIdToRestaurantSuggestions < ActiveRecord::Migration
  def change
    add_column :restaurant_suggestions, :campus_id, :integer
    add_index :restaurant_suggestions, :campus_id
  end
end
