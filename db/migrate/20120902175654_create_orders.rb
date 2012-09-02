class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :buyer_id
      t.integer :seller_id
      t.integer :item_id

      t.timestamps
    end

    add_index :orders, :buyer_id
    add_index :orders, :seller_id
    add_index :orders, :item_id
  end
end
