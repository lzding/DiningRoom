class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table( :orders, :id => false) do |t|
      t.string :id, :limit => 36, :primary => true, :null => false

      t.string :user_id
      t.datetime :order_date
      t.integer :status
      t.string :pick_user_id

      t.timestamps
    end

    add_index :orders, :user_id
    add_index :orders, :order_date
    add_index :orders, :status
    add_index :orders, :pick_user_id
    execute 'ALTER TABLE orders ADD PRIMARY KEY(id)'

  end
end
