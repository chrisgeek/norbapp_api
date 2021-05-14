class CreatePendingRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :pending_requests do |t|
      t.references :group, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
