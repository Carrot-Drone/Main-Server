class CreateRestaurantCorrections < ActiveRecord::Migration
  def change
    create_table :restaurant_corrections do |t|
      t.belongs_to :user, index: true
      t.belongs_to :restaurant, index: true

      t.string :major_correction
      t.text :details

      t.timestamps null: false
    end
  end
end
