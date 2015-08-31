class AddEmailToCampus < ActiveRecord::Migration
  def change
    add_column :campuses, :email, :string
  end
end
