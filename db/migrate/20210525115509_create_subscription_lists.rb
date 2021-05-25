class CreateSubscriptionLists < ActiveRecord::Migration[6.1]
  def change
    create_table :subscription_lists do |t|
      t.string :name
      t.string :price
      t.integer :user_limit

      t.timestamps
    end
  end
end
