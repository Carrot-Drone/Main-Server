class AddMimimumPriceColumnToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :minimum_price, :integer, default: 0
  end
end
