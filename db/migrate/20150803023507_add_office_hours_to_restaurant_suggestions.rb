class AddOfficeHoursToRestaurantSuggestions < ActiveRecord::Migration
  def change
    add_column :restaurant_suggestions, :restaurant_office_hours, :string
  end
end
