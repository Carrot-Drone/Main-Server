class CreateCampuses < ActiveRecord::Migration
  def change
    create_table :campuses do |t|
      t.string :name_eng
      t.string :name_kor
      t.text :description

      t.timestamps null: false
    end
  end
end
