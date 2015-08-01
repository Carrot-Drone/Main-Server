class CreateRestaurantSuggestions < ActiveRecord::Migration
  def change
    create_table :restaurant_suggestions do |t|
      t.belongs_to  :user, index: true

      t.string :campus_name
      t.string :restaurant_name
      t.string :restaurant_phone_number
      t.string :restaurant_opening_hours
      t.string :restaurant_closing_hours

      t.boolean :is_suggested_by_restaurant
      t.boolean :is_processed, :default => false

      t.timestamps null: false
    end
  end
end
