class AddColumnToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :category, :string
    add_column :restaurants, :openingHours, :float
    add_column :restaurants, :closingHours, :float
  end
end
