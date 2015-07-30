class AddColumnsToCallLogs < ActiveRecord::Migration
  def change
    add_column :call_logs, :campus_id, :integer
    add_column :call_logs, :user_id, :integer

    add_index :call_logs, :restaurant_id
    add_index :call_logs, :campus_id
    add_index :call_logs, :user_id
  end
end
