class RemoveOpeningHoursClosingHoursFromRestaurantSuggestions < ActiveRecord::Migration
  def change
    remove_column :restaurant_suggestions, :restaurant_opening_hours, :float
    remove_column :restaurant_suggestions, :restaurant_closing_hours, :float
  end
end
