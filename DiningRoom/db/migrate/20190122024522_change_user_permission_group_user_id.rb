class ChangeUserPermissionGroupUserId < ActiveRecord::Migration[5.2]
  def change
    change_column :user_permission_groups, :user_id, :string
  end
end
