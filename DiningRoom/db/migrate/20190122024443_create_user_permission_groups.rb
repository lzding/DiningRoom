class CreateUserPermissionGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :user_permission_groups do |t|
      t.references :user, index: true
      t.references :permission_group, index: true

      t.timestamps
    end
  end
end
