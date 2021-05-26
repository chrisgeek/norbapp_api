class RemoveAdminIdFromGroup < ActiveRecord::Migration[6.1]
  def change
    remove_column :groups, :admin_id
  end
end
