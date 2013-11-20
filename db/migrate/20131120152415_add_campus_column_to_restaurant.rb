class AddCampusColumnToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :campus, :string
  end
end
