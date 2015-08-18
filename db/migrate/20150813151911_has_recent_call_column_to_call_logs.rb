class HasRecentCallColumnToCallLogs < ActiveRecord::Migration
  def change
    add_column :call_logs, :has_recent_call, :boolean, :default => false
  end
end
