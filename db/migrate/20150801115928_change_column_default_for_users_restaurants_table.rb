class ChangeColumnDefaultForUsersRestaurantsTable < ActiveRecord::Migration
  def change
    change_column_default :users_restaurants, :number_of_calls_for_user, default: 0
    change_column_default :users_restaurants, :number_of_calls_for_system, default: 0
  end
end
