class ChangeColumnNameRestaurants < ActiveRecord::Migration
  def change
    rename_column :restaurants, :flyer, :has_flyer
    rename_column :restaurants, :coupon, :has_coupon

  end
end
