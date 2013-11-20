class CreateCallLogs < ActiveRecord::Migration
  def change
    create_table :call_logs do |t|
      t.string :phoneNumber

      t.timestamps
    end
  end
end
