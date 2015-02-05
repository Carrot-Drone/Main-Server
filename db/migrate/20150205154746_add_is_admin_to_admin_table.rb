class AddIsAdminToAdminTable < ActiveRecord::Migration
  def change
    add_column :admins, :is_super_admin, :boolean, :null => false, :default => false
  end
end
