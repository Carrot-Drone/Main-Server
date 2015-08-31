class CreateCampusReservations < ActiveRecord::Migration
  def change
    create_table :campus_reservations do |t|
      t.string :campus_name
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
