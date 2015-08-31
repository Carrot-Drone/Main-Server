class CreateSubmenus < ActiveRecord::Migration
  def change
    create_table :submenus do |t|
      t.belongs_to :menu, index: true
      t.string :name
      t.integer :price

      t.timestamps null: false
    end
  end
end
