class SetDefaultValueToNumberOfCalls < ActiveRecord::Migration
  def change
    change_column_default :users_restaurants, :number_of_calls_for_user, 0
    change_column_default :users_restaurants, :number_of_calls_for_system, 0
  end
end
