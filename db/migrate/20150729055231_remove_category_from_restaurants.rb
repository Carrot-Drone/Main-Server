class RemoveCategoryFromRestaurants < ActiveRecord::Migration
  def change
    remove_column :restaurants, :category, :string
  end
end
