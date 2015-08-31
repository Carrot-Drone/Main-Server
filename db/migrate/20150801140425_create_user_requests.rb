class CreateUserRequests < ActiveRecord::Migration
  def change
    create_table :user_requests do |t|
      t.belongs_to :user, index: true
      t.string :email
      t.text :details

      t.timestamps null: false
    end
  end
end
