class RenameOfficeHoursInRestaurants < ActiveRecord::Migration
  def change
    rename_column :restaurants, :openingHours, :opening_hours
    rename_column :restaurants, :closingHours, :closing_hours

  end
end
