class ChangeCouponPath < ActiveRecord::Migration
  def change
    rename_column :restaurants, :coupon_path, :coupon_string
  end
end
