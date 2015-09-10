class AddIsProcessedToUserRequests < ActiveRecord::Migration
  def change
    add_column :user_requests, :is_processed, :boolean, :default => false
  end
end
