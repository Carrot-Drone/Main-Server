class AddShortNameToCampuses < ActiveRecord::Migration
  def change
    add_column :campuses, :name_kor_short, :string
  end
end
