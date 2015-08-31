class AddColumnToCallLogs < ActiveRecord::Migration
  def change
    rename_column :call_logs, :device, :device_type
    add_column :call_logs, :device_id, :integer
    add_index :call_logs, :device_id
  end
end
