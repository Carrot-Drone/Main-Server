class RemovePhoneNumbersFromRestaurants < ActiveRecord::Migration
  def change
    remove_column :restaurants, :phone_numbers, :text
  end
end
