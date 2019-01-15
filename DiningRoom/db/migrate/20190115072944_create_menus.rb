class CreateMenus < ActiveRecord::Migration[5.2]
  def up
    create_table( :menus, :id => false) do |t|
      t.string :id, :limit => 36, :primary => true, :null => false

      t.datetime :dinner_date
      t.integer :dinner_type
      t.string :dish_one
      t.string :dish_two
      t.string :dish_three
      t.string :soup

      t.timestamps
    end

    add_index :menus, :dinner_date
    add_index :menus, :dinner_type
    execute 'ALTER TABLE menus ADD PRIMARY KEY(id)'

  end


  def down
    drop_table :menus
  end
end
