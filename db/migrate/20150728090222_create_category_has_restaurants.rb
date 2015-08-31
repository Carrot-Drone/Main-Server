class CreateCategoryHasRestaurants < ActiveRecord::Migration
  def change
    create_table :categories_restaurants do |t|
      t.belongs_to :category, index:true
      t.belongs_to :restaurant, index:true
    end
  end
end
