class CreateUsersRestaurants < ActiveRecord::Migration
  def change
    create_table :users_restaurants do |t|
      t.belongs_to :user, index: true
      t.belongs_to :restaurant, index: true

      t.integer :number_of_calls

      t.timestamps null: false
    end
  end
end
