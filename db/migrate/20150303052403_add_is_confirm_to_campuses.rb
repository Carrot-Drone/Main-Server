class AddIsConfirmToCampuses < ActiveRecord::Migration
  def change
    add_column :campuses, :is_confirmed, :boolean, :default => false
  end
end
