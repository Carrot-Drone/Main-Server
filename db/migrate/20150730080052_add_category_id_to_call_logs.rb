class AddCategoryIdToCallLogs < ActiveRecord::Migration
  def change
    add_column :call_logs, :category_id, :integer
    add_index :call_logs, :category_id
  end
end
