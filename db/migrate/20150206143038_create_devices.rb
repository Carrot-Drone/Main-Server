class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :uuid, null: false
      t.string :device_type, null: false

      t.belongs_to :campus, index: true
      t.timestamps null: false
    end
  end
end
