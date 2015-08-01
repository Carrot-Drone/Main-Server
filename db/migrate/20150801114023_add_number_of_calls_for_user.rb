class AddNumberOfCallsForUser < ActiveRecord::Migration
  def change
    add_column :users_restaurants, :number_of_calls_for_user, :integer
    rename_column :users_restaurants, :number_of_calls, :number_of_calls_for_system
  end
end
