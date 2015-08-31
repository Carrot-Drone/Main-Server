class AddFlyerToFlyers < ActiveRecord::Migration
  def change
    add_column :flyers, :flyer, :string
  end
end
