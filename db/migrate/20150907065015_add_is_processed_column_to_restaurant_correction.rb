class AddIsProcessedColumnToRestaurantCorrection < ActiveRecord::Migration
  def change
    add_column :restaurant_corrections, :is_processed, :boolean, :default => false
  end
end
