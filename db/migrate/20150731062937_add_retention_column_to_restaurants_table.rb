class AddRetentionColumnToRestaurantsTable < ActiveRecord::Migration
  def change
    add_column :restaurants, :retention, :float
  end
end
