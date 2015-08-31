class AddRestaurantSuggestionReferenceToFlyer < ActiveRecord::Migration
  def change
    add_column :flyers, :restaurant_suggestion_id, :integer
    add_index :flyers, :restaurant_suggestion_id
  end
end
