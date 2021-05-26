class RenameJwtExpiredAt < ActiveRecord::Migration[6.1]
  def change
    rename_table :jwt_denylist, :jwt_denylists
    rename_column :jwt_denylists, :expired_at, :exp
  end
end
