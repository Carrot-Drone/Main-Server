class ChangeCouponStringType < ActiveRecord::Migration
  def change
    change_column_default(:restaurants, :coupon_string, nil)
    change_column :restaurants, :coupon_string, :text
  end
end
