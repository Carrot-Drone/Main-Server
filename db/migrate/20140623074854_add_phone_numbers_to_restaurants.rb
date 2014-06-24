class AddPhoneNumbersToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :phone_numbers, :text
  end
end
