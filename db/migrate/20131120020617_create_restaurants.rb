class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :phone_number
      t.boolean :flyer, :default => false 
      t.string :flyer_path, :default => ""
      t.boolean :coupon, :default => false
      t.string :coupon_path, :default => ""

      t.timestamps
    end
  end
end
