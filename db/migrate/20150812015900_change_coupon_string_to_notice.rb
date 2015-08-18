class ChangeCouponStringToNotice < ActiveRecord::Migration
  def change
    rename_column :restaurants, :coupon_string, :notice

  end
end
