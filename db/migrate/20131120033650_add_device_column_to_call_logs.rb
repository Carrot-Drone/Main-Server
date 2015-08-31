class AddDeviceColumnToCallLogs < ActiveRecord::Migration
  def change
    add_column :call_logs, :device, :string
  end
end
