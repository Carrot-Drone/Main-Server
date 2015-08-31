class AddAdministratorColumnToCampus < ActiveRecord::Migration
  def change
    add_column :campuses, :administrator, :string, :default => "캠퍼스:달"
  end
end
