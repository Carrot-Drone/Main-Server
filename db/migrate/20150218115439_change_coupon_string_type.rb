class ChangeCouponStringType < ActiveRecord::Migration
  def change
    change_column :restaurants, :coupon_string, :text
  end
end
