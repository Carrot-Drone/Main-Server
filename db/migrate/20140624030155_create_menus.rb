class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.belongs_to :restaurant
      t.string :section
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end
