class RemoveColumns < ActiveRecord::Migration
  def change
    remove_column :restaurants, :flyer
  end
end
