class RemoveCampusFromRestaurant < ActiveRecord::Migration
  def change
    remove_column :restaurants, :campus, :string
  end
end
