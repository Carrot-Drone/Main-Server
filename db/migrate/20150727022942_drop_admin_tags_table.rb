class DropAdminTagsTable < ActiveRecord::Migration
  def change
    drop_table :admins_tags
  end
end
