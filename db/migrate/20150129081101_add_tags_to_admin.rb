class AddTagsToAdmin < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag_name
      t.timestamps null: false
    end

    create_table :admins_tags, id: false do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :admin, index: true
    end
  end
end
