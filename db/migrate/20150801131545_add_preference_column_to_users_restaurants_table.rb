class AddPreferenceColumnToUsersRestaurantsTable < ActiveRecord::Migration
  def change
    add_column :users_restaurants, :preference, :integer, :default => 0
  end
end
