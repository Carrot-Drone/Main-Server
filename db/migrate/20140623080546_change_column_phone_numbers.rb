class ChangeColumnPhoneNumbers < ActiveRecord::Migration
  def change
    change_column :restaurants, :phone_numbers, :text, :default => nil
  end
end
