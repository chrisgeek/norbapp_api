class AddMoreAttributesToSubscription < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :renewed_at, :datetime
    add_column :subscriptions, :payment_ref, :string
  end
end
