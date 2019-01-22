class AddUserNrToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :user_nr, :string, :null => false
    add_index :orders, :user_nr
  end
end
