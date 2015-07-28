class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.belongs_to :campus, index: true
      
      t.string :title
    end
  end
end
