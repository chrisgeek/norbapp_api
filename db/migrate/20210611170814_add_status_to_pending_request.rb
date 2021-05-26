class AddStatusToPendingRequest < ActiveRecord::Migration[6.1]
  def change
    add_column :pending_requests, :status, :string, null: false, default: 'pending'
  end
end
