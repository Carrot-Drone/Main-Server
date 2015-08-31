class ChangeDescriptionTypeInMenus < ActiveRecord::Migration
  def change
    change_column :menus, :description, :text
  end
end
