class CreateFlyers < ActiveRecord::Migration
  def change
    create_table :flyers do |t|
      t.belongs_to :restaurant

      t.timestamps
    end
  end
end
