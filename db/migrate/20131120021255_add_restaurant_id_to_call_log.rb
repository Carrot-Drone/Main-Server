class AddRestaurantIdToCallLog < ActiveRecord::Migration
  def change
    add_column :call_logs, :restaurant_id, :string
  end
end
