class AddCampusColumnToCallLog < ActiveRecord::Migration
  def change
    add_column :call_logs, :campus, :string 
  end
end
