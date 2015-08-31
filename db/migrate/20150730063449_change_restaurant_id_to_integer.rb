class ChangeRestaurantIdToInteger < ActiveRecord::Migration
  def self.up
    change_column :call_logs, :restaurant_id, :integer
  end
  def self.down
    change_column :call_logs, :restaurant_id, :string
  end
end
